
func containsQuantities(_ dictionary: Dictionary, _ aggregateInput: AggregateInput) -> [String] {
        
    var output = [String]()
    var inputQuantities = [Int]()
    var inputBools = [Bool]()
    
    for i in 0...(EnglishAlphabet.allCases.count-1) {
        let b = aggregateInput.inputBools[i]
        let n = aggregateInput.inputInts[i]
        inputBools.append(b)
        inputQuantities.append(b ? n : 0)
    }
    
    var words = dictionary.words
    
    let mode = aggregateInput.inputInts[30]
    let allowOthers = aggregateInput.inputBools[31]
    
    // Mininmum mode
    if mode == 0 {
        
        if (!allowOthers) {
            // Apply contains only to exclude other letters
            words = containsOnlyWords(words, aggregateInput)
        }
        
        // First apply standard containsAtLeast (this make the search more efficient)
        words = containsAtLeastWords(words, aggregateInput)
        
        for word in words {
            
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
            words = containsOnlyWords(words, aggregateInput)
        }
        
        // First apply standard containsAtLeast (this make the search more efficient)
        words = containsAtLeastWords(words, aggregateInput)
        
        for word in words {
            
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
            words = containsOnlyWords(words, aggregateInput)
        }
        
        for word in words {
            
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
