$renameMap = @{
    "Collections Overview.md" = "01-Collections Overview.md"
    "List.md"                 = "02-List.md"
    "ArrayList.md"            = "03-ArrayList.md"
    "LinkedList.md"           = "04-LinkedList.md"
    "Stack.md"                = "05-Stack.md"
    "Queue.md"                = "06-Queue.md"
    "PriorityQueue.md"        = "07-PriorityQueue.md"
    "Deque.md"                = "08-Deque.md"
    "Set.md"                  = "09-Set.md"
    "HashSet.md"              = "10-HashSet.md"
    "LinkedHashSet.md"        = "11-LinkedHashSet.md"
    "TreeSet.md"              = "12-TreeSet.md"
    "Map.md"                  = "13-Map.md"
    "HashMap.md"              = "14-HashMap.md"
    "LinkedHashMap.md"        = "15-LinkedHashMap.md"
    "Hashtable.md"            = "16-Hashtable.md"
    "TreeMap.md"              = "17-TreeMap.md"
    "Comparable.md"           = "18-Comparable.md"
    "Comparator.md"           = "19-Comparator.md"
    "Collections Utility.md"  = "20-Collections Utility.md"
}

foreach ($item in $renameMap.GetEnumerator()) {
    if (Test-Path $item.Key) {
        Rename-Item -Path $item.Key -NewName $item.Value
        Write-Host "Renamed: $($item.Key) -> $($item.Value)"
    } else {
        Write-Host "Not Found: $($item.Key)"
    }
}