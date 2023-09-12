
func startingString(_ words: [String], _ aggregateInput: AggregateInput) async -> [String] {
    return await startingString(words, input: aggregateInput.x)
}

func startingCharacter(_ words: [String], _ aggregateInput: AggregateInput) async -> [String] {
    return await startingString(words, input: aggregateInput.a.rawValue)
}

func startingStringOrCharacter(_ words: [String], _ aggregateInput: AggregateInput) async -> [String] {
    return await startingString(words, input: aggregateInput.x.isEmpty ? aggregateInput.a.rawValue : aggregateInput.x)
}

func startingString(_ words: [String], input: String) async -> [String] {
    
    var output = [String]()
    var p = 0
    
    for word in words {
        
        if word.prefix(input.count).uppercased() == input.uppercased() {
            output.append(word)
        }
        
        // Introduce pause for async
        p += 1
        if p.isMultiple(of: 100) {
            await Task.yield()
        }
    }
    
    return output
}
