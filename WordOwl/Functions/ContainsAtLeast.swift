
func containsAtLeast(_ words: [String], _ aggregateInput: AggregateInput) async -> [String] {
    
    var input = ""
    for letter in EnglishAlphabet.allCases {
        if aggregateInput.inputBools[EnglishAlphabet.allCases.firstIndex(of: letter)!] {
            input += letter.rawValue.lowercased()
        }
    }
        
    var output = [String]()
    var p = 0
    
    for word in words {
        
        // Introduce pause for async
        p += 1
        if p.isMultiple(of: 100) {
            await Task.yield()
        }
        
        if input == input.filter({ word.lowercased().contains($0) }) {
            output.append(word)
        }
    }
    
    return output
}
