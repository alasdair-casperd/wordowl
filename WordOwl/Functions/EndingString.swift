

func endingString(_ words: [String], _ aggregateInput: AggregateInput) async -> [String] {
    return await endingString(words, input: aggregateInput.x)
}

func endingCharacter(_ words: [String], _ aggregateInput: AggregateInput) async -> [String] {
    return await endingString(words, input: aggregateInput.a.rawValue)
}

func endingStringOrCharacter(_ words: [String], _ aggregateInput: AggregateInput) async -> [String] {
    return await endingString(words, input: aggregateInput.x.isEmpty ? aggregateInput.a.rawValue : aggregateInput.x)
}


func endingString(_ words: [String], input: String) async -> [String] {
    
    var output = [String]()
    var p = 0
    
    for word in words {
        if word.suffix(input.count).uppercased() == input.uppercased() {
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
