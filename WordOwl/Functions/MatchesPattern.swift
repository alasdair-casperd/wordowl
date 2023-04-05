//
//  matchesPattern.swift
//  WordOwl
//
//  Created by Alasdair Casperd on 01/04/2023.
//

import Foundation

func matchesPattern(_ inputWords: [String], _ aggregateInput: AggregateInput) async -> [String] {
    return await matchesPattern(inputWords, aggregateInput, checkMatchFor: [String]())
}

func matchesPattern(_ inputWords: [String], _ aggregateInput: AggregateInput, checkMatchFor wordsToCheck: [String] = [String]()) async -> [String] {
    
    var p = 0
    
    var output = [String]()
    
    for word in inputWords {
        
        // Introduce pause for async
        p += 1
        if p.isMultiple(of: 100) {
            await Task.yield()
        }
        
        var matches = false
        let startingletterVariables: [String?] = Array(repeating: nil, count: 10)
        
        var pass = 0
        
        func checkMatch(word: String, pattern: String, debugging: Bool, letterVariables: [String?]) {
            
            var localLetterVariables = letterVariables
            
            pass += 1
            
            let localPass = pass
            
            func printDebugMessage(_ message: String) {
                if debugging {
                    print("PASS \(localPass): " + message)
                }
            }
            
            printDebugMessage("-----")
            printDebugMessage("Check Match initiated with word=\(word) and pattern=\(pattern)")
            printDebugMessage("-----")
            
            if pattern.count == 0 {
                printDebugMessage("I will terminate as pattern=\"\"")
                if word.count == 0 {
                    printDebugMessage("word=\"\", so SUCCESS")
                    matches = true
                }
                printDebugMessage("word=\"\", so NO SUCCESS")
            }
            else {
                let p = pattern.prefix(1)
                switch p {
                case "?":
                    if word.count > 0 {
                        printDebugMessage("Pattern begins with ?, and word is nonempty")
                        printDebugMessage("I'll remove the ? and continue by search")
                        checkMatch(
                            word: word.removingFirst(1),
                            pattern: pattern.removingFirst(1),
                            debugging: debugging,
                            letterVariables: localLetterVariables
                        )
                    }
                case "-":
                    printDebugMessage("Pattern begins with -, so I'll iterate the possible remaining lengths")
                    for i in 0...word.count {
                        printDebugMessage("Case i\(localPass)=\(i)")
                        checkMatch(
                            word: word.removingFirst(i),
                            pattern: pattern.removingFirst(1),
                            debugging: debugging,
                            letterVariables: localLetterVariables
                        )
                    }
                case "0", "1", "2", "3", "4", "5", "6", "7", "8", "9":
                    printDebugMessage("Pattern begins with \(p), a variable")
                    if word.count > 0 {
                        printDebugMessage("The word remains nonempty")
                        let i = Int(p)!
                        if localLetterVariables[i] == nil {
                            printDebugMessage("I've not seen this variable before, so I'm storing \(i)=\(word.prefix(1))")
                            localLetterVariables[i] = String(word.prefix(1))
                            printDebugMessage("I'll now remove the symbol and continue")
                            checkMatch(
                                word: word.removingFirst(1),
                                pattern: pattern.removingFirst(1),
                                debugging: debugging,
                                letterVariables: localLetterVariables
                            )
                        }
                        else {
                            printDebugMessage("I've seen this variable before")
                            printDebugMessage("Previously it meant \(localLetterVariables[i]!)")
                            if localLetterVariables[i]! == word.prefix(1) {
                                printDebugMessage("Luckily, it still does")
                                printDebugMessage("I'll remove the symbol and continue my search")
                                checkMatch(
                                    word: word.removingFirst(1),
                                    pattern: pattern.removingFirst(1),
                                    debugging: debugging,
                                    letterVariables: localLetterVariables
                                )
                            }
                            else {
                                printDebugMessage("It doesn't; NO SUCCESS")
                            }
                        }
                    }
                    else {
                        printDebugMessage("But the word is empty! So NO SUCCESS")
                    }
                default:
                    if word.count > 0 {
                        if p == word.prefix(1) {
                            checkMatch(
                                word: word.removingFirst(1),
                                pattern: pattern.removingFirst(1),
                                debugging: debugging,
                                letterVariables: localLetterVariables
                            )
                        }
                    }
                }
            }
        }
        
        checkMatch(word: word, pattern: aggregateInput.x.lowercased(), debugging: wordsToCheck.contains(word), letterVariables: startingletterVariables)
        if matches { output.append(word) }
    }
    
    return output
}
