
func endingString(_ dictionary: Dictionary, _ aggregateInput: AggregateInput) -> [String] {
    
    let input = aggregateInput.x.isEmpty ? aggregateInput.a.rawValue : aggregateInput.x
    let words = dictionary.words
    var output = [String]()
    
    for word in words {
        if word.suffix(input.count).uppercased() == input.uppercased() {
            output.append(word)
        }
    }
    
    return output
}
