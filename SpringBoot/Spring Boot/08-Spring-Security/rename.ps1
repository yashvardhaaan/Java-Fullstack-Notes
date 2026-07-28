$mapping = @{
    "01-Spring Security Basics.md" = "01-Spring Security Basics.md"
    "02-Security Filter Chain.md"  = "02-Security Filter Chain.md"
    "03-Password Encoder.md"       = "03-Password Encoder.md"
    "04-Authorization.md"          = "04-Authorization.md"
    "05-Role Based Access.md"      = "05-Role Based Access.md"
    "06-Method Security.md"        = "06-Method Security.md"
    "07-CSRF.md"                   = "07-CSRF.md"
    "08-CORS.md"                   = "08-CORS.md"
    "09-JWT.md"                    = "09-JWT.md"
    "10-JWT Authentication.md"     = "10-JWT Authentication.md"
    "11-OAuth2 Basics.md"          = "11-OAuth2 Basics.md"
    "Authentication.md"            = "00-Authentication.md"
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