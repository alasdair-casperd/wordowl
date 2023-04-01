
func containsString(_ words: [String], _ aggregateInput: AggregateInput) async -> [String] {
    
    let input = aggregateInput.x.lowercased()    
    
    var output = [String]()
    
    var p = 0
    
    for word in words {
        
        // Introduce pause for async
        p += 1
        if p.isMultiple(of: 100) {
            await Task.yield()
        }
        
        if word.lowercased().contains(input) {
            output.append(word)
        }
    }
    
    return output
}
