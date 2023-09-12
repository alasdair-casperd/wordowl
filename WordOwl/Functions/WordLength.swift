//
//  WordLength.swift
//  WordOwl
//
//  Created by Alasdair Casperd on 31/01/2022.
//

func wordLength(_ words: [String], _ aggregateInput: AggregateInput) async -> [String] {
    return await baseWordLength(words, aggregateInput.i)
}

func baseWordLength(_ words: [String], _ i: Int) async -> [String] {
        
    var output = [String]()
    
    var p = 0
    
    for word in words {
        
        // Introduce pause for async
        p += 1
        if p.isMultiple(of: 100) {
            await Task.yield()
        }
        
        if word.count == i {
            output.append(word)
        }
    }
    
    return output
}

// Expected input: e.g. "2,7"
func wordLengthBetween(_ words: [String], _ aggregateInput: AggregateInput) async -> [String] {
    
    let i = aggregateInput.i
    let j = aggregateInput.j
    
    guard j <= i else {
        fatalError("Innapropriate input provided to wordLengthBetween. [4]")
    }
    
    var output = [String]()
    
    for k in j...i {
        output += await baseWordLength(words, k)
    }
    
    return output
}
