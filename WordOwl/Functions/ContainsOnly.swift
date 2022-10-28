
func containsOnly(_ dictionary: Dictionary, _ aggregateInput: AggregateInput) -> [String] {
    
    let words = dictionary.words
    
    return containsOnlyWords(words, aggregateInput)
}

func containsOnlyWords(_ words: [String], _ aggregateInput: AggregateInput) -> [String] {
    
    var input = ""
    for letter in EnglishAlphabet.allCases {
        if aggregateInput.inputBools[EnglishAlphabet.allCases.firstIndex(of: letter)!] {
            input += letter.rawValue.lowercased()
        }
    }
        
    var output = [String]()
    
    for word in words {
        if word.lowercased() == word.lowercased().filter({ input.contains($0) }) {
            output.append(word)
        }
    }
    
    return output
}
