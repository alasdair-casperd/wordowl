//
//  ContainsLetters.swift
//  WordOwl
//
//  Created by Alasdair Casperd on 02/04/2023.
//

import Foundation

func containsLetters(_ words: [String], _ aggregateInput: AggregateInput) async -> [String] {
    
    let letters = aggregateInput.x.lowercased()
    
    let newInput = AggregateInput()
    
    for a in EnglishAlphabet.allCases {
        newInput.inputInts[EnglishAlphabet.allCases.firstIndex(of: a)!]
        = letters.filter{ String($0).uppercased() == a.rawValue.uppercased()}.count
    }
    
    newInput.inputInts[30] = 0
    newInput.inputBools[31] = true
    
    return await containsQuantities(words, newInput)
}
