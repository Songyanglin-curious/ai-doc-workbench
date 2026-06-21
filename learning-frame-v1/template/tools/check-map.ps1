param(
  [string]$FrameRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
)

$ErrorActionPreference = 'Stop'
$mapRoot = Join-Path $FrameRoot 'docs\map'
if (-not (Test-Path -LiteralPath $mapRoot)) {
  Write-Error "Map directory not found: $mapRoot"
}

function Parse-FrontMatter {
  param([string]$Path)
  $text = Get-Content -Raw -Encoding UTF8 -LiteralPath $Path
  $lines = $text -split "`r?`n"
  if ($lines.Count -lt 3 -or $lines[0].Trim() -ne '---') {
    return $null
  }

  $end = -1
  for ($i = 1; $i -lt $lines.Count; $i++) {
    if ($lines[$i].Trim() -eq '---') {
      $end = $i
      break
    }
  }
  if ($end -lt 0) { return $null }

  $data = @{}
  $currentKey = $null
  for ($i = 1; $i -lt $end; $i++) {
    $line = $lines[$i]
    if ($line -match '^([A-Za-z_][A-Za-z0-9_-]*):\s*(.*)$') {
      $key = $matches[1]
      $value = $matches[2].Trim()
      $currentKey = $key
      if ($value -eq '[]') {
        $data[$key] = @()
      } elseif ($value -eq '') {
        $data[$key] = @()
      } else {
        $data[$key] = $value.Trim('"').Trim("'")
      }
      continue
    }
    if ($line -match '^\s*-\s*(.+?)\s*$' -and $currentKey) {
      if (-not ($data[$currentKey] -is [System.Array])) {
        $data[$currentKey] = @()
      }
      $data[$currentKey] = @($data[$currentKey]) + $matches[1].Trim().Trim('"').Trim("'")
    }
  }

  return $data
}

$errors = New-Object System.Collections.Generic.List[string]
$warnings = New-Object System.Collections.Generic.List[string]
$docs = @()

Get-ChildItem -Path $mapRoot -Recurse -File -Filter '*.md' | Where-Object {
  $_.FullName -notmatch "[\\/]_templates[\\/]"
} | ForEach-Object {
  $fm = Parse-FrontMatter -Path $_.FullName
  if (-not $fm) {
    $errors.Add("Missing front matter: $($_.FullName)")
    return
  }
  if (-not $fm.ContainsKey('id') -or [string]::IsNullOrWhiteSpace([string]$fm['id'])) {
    $errors.Add("Missing id: $($_.FullName)")
  }
  if (-not $fm.ContainsKey('type') -or [string]::IsNullOrWhiteSpace([string]$fm['type'])) {
    $errors.Add("Missing type: $($_.FullName)")
  }
  $docs += [pscustomobject]@{ Path = $_.FullName; FrontMatter = $fm }
}

$ids = @{}
foreach ($doc in $docs) {
  $id = [string]$doc.FrontMatter['id']
  if ([string]::IsNullOrWhiteSpace($id)) { continue }
  if ($ids.ContainsKey($id)) {
    $errors.Add("Duplicate id '$id': $($ids[$id]) and $($doc.Path)")
  } else {
    $ids[$id] = $doc.Path
  }
}

$allowedTypes = @('index', 'scenario', 'capability-chain', 'capability-node')
$allowedStatuses = @('candidate', 'learning', 'unstable', 'confirmed', 'risk')
$referenceFields = @('prerequisites', 'used_in', 'related', 'chains', 'capability_nodes', 'nodes', 'scenario')

foreach ($doc in $docs) {
  $fm = $doc.FrontMatter
  $type = [string]$fm['type']
  if ($type -and $allowedTypes -notcontains $type) {
    $errors.Add("Invalid type '$type': $($doc.Path)")
  }

  if ($fm.ContainsKey('status')) {
    $status = [string]$fm['status']
    if ($status -and $allowedStatuses -notcontains $status) {
      $errors.Add("Invalid status '$status': $($doc.Path)")
    }
  } elseif ($type -ne 'index') {
    $warnings.Add("Missing status on non-index doc: $($doc.Path)")
  }

  foreach ($field in $referenceFields) {
    if (-not $fm.ContainsKey($field)) { continue }
    $values = @($fm[$field]) | Where-Object { -not [string]::IsNullOrWhiteSpace([string]$_) }
    foreach ($value in $values) {
      $v = [string]$value
      if ($v -match '^[a-z]+://' -or $v -match '[\\/]' -or $v -match '^#') { continue }
      if (-not $ids.ContainsKey($v)) {
        $warnings.Add("Reference '${field}: $v' does not resolve to a map id: $($doc.Path)")
      }
    }
  }
}

if ($warnings.Count -gt 0) {
  Write-Host 'Warnings:' -ForegroundColor Yellow
  $warnings | ForEach-Object { Write-Host "- $_" -ForegroundColor Yellow }
}

if ($errors.Count -gt 0) {
  Write-Host 'Errors:' -ForegroundColor Red
  $errors | ForEach-Object { Write-Host "- $_" -ForegroundColor Red }
  exit 1
}

Write-Host "Map check passed. Files checked: $($docs.Count). IDs: $($ids.Count)." -ForegroundColor Green