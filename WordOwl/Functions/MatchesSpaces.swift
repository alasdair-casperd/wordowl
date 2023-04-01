//
//  MatchesSpaces.swift
//  WordOwl
//
//  Created by Alasdair Casperd on 02/02/2022.
//

func matchesSpaces(_ words: [String], _ aggregateInput: AggregateInput) async -> [String] {
    
    var letters = [String]()
    
    if aggregateInput.inputStrings[9].isEmpty {
        for i in (0...(aggregateInput.i-1)) {
            letters.append(aggregateInput.inputStrings[i].lowercased())
        }
    }
    else {
        for letter in aggregateInput.inputStrings[9] {
            letters.append("\(letter)".lowercased())
        }
    }
    
    let n = letters.count    
    
    var output = [String]()
    
    var p = 0
    
    for word in words {
        
        // Introduce pause for async
        p += 1
        if p.isMultiple(of: 100) {
            await Task.yield()
        }
        
        var match = true
        if (word.count == n) {
            for i in 0...(n-1) {
                if letters[i] != "" && letters[i] != "?" {
                    if letters[i][letters[i].startIndex] != word.lowercased()[word.index(word.startIndex, offsetBy: i)] {
                        match = false
                        break
                    }
                }
            }
        }
        else {
            match = false
        }
        
        if (match) {
            output.append(word)
        }
    }
    
    return output
}

