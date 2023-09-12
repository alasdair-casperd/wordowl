//
//  WordWheelSolver.swift
//  WordOwl
//
//  Created by Alasdair Casperd on 21/05/2023.
//

import Foundation

func matchesWordWheel(_ words: [String], _ aggregateInput: AggregateInput) async -> [String] {
    
    var output = words
    
    let requiredString = aggregateInput.y
    let allowedString = aggregateInput.x + aggregateInput.y
    
    let A1 = AggregateInput()
    let A2 = AggregateInput()
    
    for c in EnglishAlphabet.allCases {
        A1.inputBools[EnglishAlphabet.allCases.firstIndex(of: c)!] = requiredString.uppercased().contains(where: {a in return String(a) == c.rawValue})
    }
    
    for c in EnglishAlphabet.allCases {
        A2.inputBools[EnglishAlphabet.allCases.firstIndex(of: c)!] = allowedString.uppercased().contains(where: {a in return String(a) == c.rawValue})
    }
    
    output = await containsAtLeast(output, A1)
    output = await containsOnly(output, A2)
    
    return output
}
