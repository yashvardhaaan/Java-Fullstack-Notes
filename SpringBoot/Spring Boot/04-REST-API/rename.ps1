# Rename REST API Markdown files in learning order

$mapping = @{
    "REST Basics.md"         = "01-REST Basics.md"
    "HTTP Status Codes.md"   = "02-HTTP Status Codes.md"
    "RestController.md"      = "03-RestController.md"
    "Controller.md"          = "04-Controller.md"
    "Request Mapping.md"     = "05-Request Mapping.md"
    "Path Variable.md"       = "06-Path Variable.md"
    "Request Param.md"       = "07-Request Param.md"
    "Request Body.md"        = "08-Request Body.md"
    "Response Entity.md"     = "09-Response Entity.md"
    "CRUD APIs.md"           = "10-CRUD APIs.md"
    "REST Best Practices.md" = "11-REST Best Practices.md"
}

foreach ($item in $mapping.GetEnumerator()) {
    if (Test-Path $item.Key) {
        Rename-Item -Path $item.Key -NewName $item.Value
        Write-Host "Renamed: $($item.Key) -> $($item.Value)"
    }
    else {
        Write-Host "Not Found: $($item.Key)"
    }
}

Write-Host ""
Write-Host "✅ Renaming Completed!"