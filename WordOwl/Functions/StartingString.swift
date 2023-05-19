
func startingString(_ words: [String], _ aggregateInput: AggregateInput) -> [String] {
    
    let input = aggregateInput.x.isEmpty ? aggregateInput.a.rawValue : aggregateInput.x
    var output = [String]()
    
    for word in words {
        if word.prefix(input.count).uppercased() == input.uppercased() {
            output.append(word)
        }
    }
    
    return output
}
