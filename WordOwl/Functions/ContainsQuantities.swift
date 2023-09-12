
func containsQuantities(_ inputWords: [String], _ aggregateInput: AggregateInput) async -> [String] {
        
    var words = inputWords
    var output = [String]()
    var inputQuantities = [Int]()
    var inputBools = [Bool]()
    
    for i in 0...(EnglishAlphabet.allCases.count-1) {
        let b = aggregateInput.inputBools[i]
        let n = aggregateInput.inputInts[i]
        inputBools.append(b)
        inputQuantities.append(b ? n : 0)
    }
    
    let mode = aggregateInput.inputInts[30]
    let allowOthers = aggregateInput.inputBools[31]
    
    // Mininmum mode
    if mode == 0 {
        
        if (!allowOthers) {
            // Apply contains only to exclude other letters
            words = await containsOnly(words, aggregateInput)
        }
        
        // First apply standard containsAtLeast (this make the search more efficient)
        words = await containsAtLeast(words, aggregateInput)
        
        var p = 0
        
        for word in words {
            
            // Introduce pause for async
            p += 1
            if p.isMultiple(of: 100) {
                await Task.yield()
            }
            
            var including = true
            
            for i in 0...(EnglishAlphabet.allCases.count - 1) {
                
                if (inputBools[i] && inputQuantities[i] > 1) {
                    let EA = EnglishAlphabet.allCases[i].rawValue.lowercased()
                    let c = EA[EA.index(EA.startIndex, offsetBy: 0)]
                    
                    if (word.lowercased().characterCount(of: c) < inputQuantities[i])
                    {
                        including = false
                    }
                }
            }
            
            if including { output.append(word)}
        }
    }
    
    // Exact mode
    if mode == 1 {
        
        if (!allowOthers) {
            // Apply contains only to exclude other letters
            words = await containsOnly(words, aggregateInput)
        }
        
        // First apply standard containsAtLeast (this make the search more efficient)
        words = await containsAtLeast(words, aggregateInput)
        
        var p = 0
        
        for word in words {
            
            // Introduce pause for async
            p += 1
            if p.isMultiple(of: 100) {
                await Task.yield()
            }
            
            var including = true
            
            for i in 0...(EnglishAlphabet.allCases.count - 1) {
                
                if (inputBools[i]) {
                    let EA = EnglishAlphabet.allCases[i].rawValue.lowercased()
                    let c = EA[EA.index(EA.startIndex, offsetBy: 0)]
                    
                    if (word.lowercased().characterCount(of: c) != inputQuantities[i])
                    {
                        including = false
                    }
                }
            }
            
            if including { output.append(word) }
        }
    }
    
    // Maximum mode
    if mode == 2 {
        
        if (!allowOthers) {
            // Apply contains only to exclude other letters
            words = await containsOnly(words, aggregateInput)
        }
                
        var p = 0
        
        for word in words {
            
            // Introduce pause for async
            p += 1
            if p.isMultiple(of: 100) {
                await Task.yield()
            }
            
            var including = true
            
            for i in 0...(EnglishAlphabet.allCases.count - 1) {
                
                if (inputBools[i]) {
                    let EA = EnglishAlphabet.allCases[i].rawValue.lowercased()
                    let c = EA[EA.index(EA.startIndex, offsetBy: 0)]
                    
                    if (word.lowercased().characterCount(of: c) > inputQuantities[i])
                    {
                        including = false
                    }
                }
            }
            
            if including { output.append(word)}
        }
    }
    
    return output
}

func containsQuantitiesAggregateInputFromString(string: String, quantityMode: Int, allowOtherLetters: Bool) -> AggregateInput {
    
    let A = AggregateInput()
    
    for c in EnglishAlphabet.allCases {
        let i = EnglishAlphabet.allCases.firstIndex(of: c)!
        A.inputBools[i] = string.uppercased().contains(where: {a in return String(a) == c.rawValue})
        A.inputInts[i] = string.uppercased().filter({String($0) == c.rawValue}).count
    }
    
    A.inputInts[30] = quantityMode
    A.inputBools[31] = allowOtherLetters
    
    return A
}
func containsQuantities(_ inputWords: [String], string: String, quantityMode: Int, allowOtherLetters: Bool) async -> [String] {
    return await containsQuantities(inputWords, containsQuantitiesAggregateInputFromString(string: string, quantityMode: quantityMode, allowOtherLetters: allowOtherLetters))
}

