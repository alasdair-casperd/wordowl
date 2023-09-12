//
//  DomingoSolver.swift
//  WordOwl
//
//  Created by Alasdair Casperd on 21/05/2023.
//

import Foundation

func matchesDomingoPuzzle(_ words: [String], _ aggregateInput: AggregateInput) async -> [String] {
    
    var list = words
    list = await startingString(list, input: aggregateInput.x)
    list = await endingString(list, input: aggregateInput.y)
    
    var output = [String]()
    var p = 0
    
    for word in list {
        if word.count > aggregateInput.x.count + aggregateInput.y.count {
            output.append(word)
        }
        
        // Introduce pause for async
        p += 1
        if p.isMultiple(of: 100) {
            await Task.yield()
        }
    }
    
    return output
}
