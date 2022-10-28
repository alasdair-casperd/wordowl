//
//  WordLength.swift
//  WordOwl
//
//  Created by Alasdair Casperd on 31/01/2022.
//

func wordLength(_ dictionary: Dictionary, _ aggregateInput: AggregateInput) -> [String] {
    return baseWordLength(dictionary, aggregateInput.i)
}

private func baseWordLength(_ dictionary: Dictionary, _ i: Int) -> [String] {
    
    let words = dictionary.words
    var output = [String]()
    
    for word in words {
        if word.count == i {
            output.append(word)
        }
    }
    
    return output
}

// Expected input: e.g. "2,7"
func wordLengthBetween(_ dictionary: Dictionary, _ aggregateInput: AggregateInput) -> [String] {
    
    let i = aggregateInput.i
    let j = aggregateInput.j
    
    guard j <= i else {
        fatalError("Innapropriate input provided to wordLengthBetween. [4]")
    }
    
    var output = [String]()
    
    for k in j...i {
        output += baseWordLength(dictionary, k)
    }
    
    return output
}
