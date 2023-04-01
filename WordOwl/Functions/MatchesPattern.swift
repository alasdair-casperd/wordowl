//
//  matchesPattern.swift
//  WordOwl
//
//  Created by Alasdair Casperd on 01/04/2023.
//

import Foundation

func matchesPattern(_ inputWords: [String], _ aggregateInput: AggregateInput) async -> [String] {
    
    var p = 0
    
    var output = [String]()
    
    for word in inputWords {
        
        // Introduce pause for async
        p += 1
        if p.isMultiple(of: 100) {
            await Task.yield()
        }
        
        var matches = false
        var letterVariables: [String?] = Array(repeating: nil, count: 10)
        
        func checkMatch(word: String, pattern: String) {
            
            if pattern.count == 0 {
                if word.count == 0 {
                    matches = true
                }
            }
            else {
                let p = pattern.prefix(1)
                switch p {
                case "?":
                    if word.count > 0 {
                        checkMatch(
                            word: word.removingFirst(1),
                            pattern: pattern.removingFirst(1)
                        )
                    }
                case "-":
                    for i in 0...word.count {
                        checkMatch(
                            word: word.removingFirst(i),
                            pattern: pattern.removingFirst(1)
                        )
                    }
                case "0", "1", "2", "3", "4", "5", "6", "7", "8", "9":
                    if word.count > 0 {
                        let i = Int(p)!
                        if letterVariables[i] == nil {
                            letterVariables[i] = String(word.prefix(1))
                            checkMatch(
                                word: word.removingFirst(1),
                                pattern: pattern.removingFirst(1)
                            )
                        }
                        else {
                            if letterVariables[i]! == word.prefix(1) {
                                checkMatch(
                                    word: word.removingFirst(1),
                                    pattern: pattern.removingFirst(1)
                                )
                            }
                        }
                    }
                default:
                    if word.count > 0 {
                        if p == word.prefix(1) {
                            checkMatch(
                                word: word.removingFirst(1),
                                pattern: pattern.removingFirst(1)
                            )
                        }
                    }
                }
            }
        }
        
        checkMatch(word: word, pattern: aggregateInput.x.lowercased())
        if matches { output.append(word) }
    }
    
    return output
}
