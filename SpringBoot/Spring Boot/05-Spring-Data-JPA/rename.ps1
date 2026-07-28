$mapping = @{
    "JPA Basics.md"            = "01-JPA Basics.md"
    "Hibernate.md"             = "02-Hibernate.md"
    "Entity.md"                = "03-Entity.md"
    "Repository.md"            = "04-Repository.md"
    "CrudRepository.md"        = "05-CrudRepository.md"
    "JpaRepository.md"         = "06-JpaRepository.md"
    "JPQL.md"                  = "07-JPQL.md"
    "Native Queries.md"        = "08-Native Queries.md"
    "Pagination.md"            = "09-Pagination.md"
    "Sorting.md"               = "10-Sorting.md"
    "Specifications.md"        = "11-Specifications.md"
    "Entity Relationships.md"  = "12-Entity Relationships.md"
    "OneToOne.md"              = "13-OneToOne.md"
    "OneToMany.md"             = "14-OneToMany.md"
    "ManyToOne.md"             = "15-ManyToOne.md"
    "ManyToMany.md"            = "16-ManyToMany.md"
    "Fetch Types.md"           = "17-Fetch Types.md"
    "Cascade Types.md"         = "18-Cascade Types.md"
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