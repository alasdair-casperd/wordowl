
func containsString(_ dictionary: Dictionary, _ aggregateInput: AggregateInput) -> [String] {
    
    let input = aggregateInput.x.lowercased()
    let words = dictionary.words
    
    var output = [String]()
    
    for word in words {
        if word.lowercased().contains(input) {
            output.append(word)
        }
    }
    
    return output
}
