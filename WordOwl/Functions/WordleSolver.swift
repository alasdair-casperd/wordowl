//
//  WordleSolver.swift
//  WordOwl
//
//  Created by Alasdair Casperd on 22/05/2023.
//

import SwiftUI

func matchesWordle(_ words: [String], _ aggregateInput: AggregateInput) async -> [String] {
    
    var p = 0
        
    enum Color {
        case Green
        case Yellow
        case None
    }
    
    var output = words
    
    // Read input
    
    var guesses = [[String]]()
    var colors = [[Color]]()
    
    for i in 0...5 {
        let guess = aggregateInput.inputStrings[i].lowercased()
        if guess.count == 5 {
            var letterArray = [String]()
            var colorArray = [Color]()
            for j in 0..<5 {
                letterArray.append(guess[j])
                let c = aggregateInput.inputInts[5*i+j+1]
                if c == 0 {
                    colorArray.append(.Green)
                }
                else if c == 1 {
                    colorArray.append(.None)
                }
                else {
                    colorArray.append(.Yellow)
                }
            }
            guesses.append(letterArray)
            colors.append(colorArray)
        }
    }
    
    print(guesses)
    print(colors)
    
    // Filter to five-letter words
    
    output = await baseWordLength(output, 5)
    
    // Check green letters
    
    var knownLetters = ["?", "?", "?", "?", "?"]
    
    for i in 0..<guesses.count {
        for j in 0...4 {
            if colors[i][j] == .Green {
                if knownLetters[j] != "?" && knownLetters[j] != guesses[i][j] {
                    return [String]()
                }
                else {
                    knownLetters[j] = guesses[i][j]
                }
            }
        }
    }
    
    output = await baseMatchesSpaces(output, knownLetters)
    
    // Check letter quantities and negative information from yellows
    
    var letterMinima = [String: Int]()
    var letterMaxima = [String: Int]()
    
    for X in EnglishAlphabet.allCases {
        
        let x = X.rawValue.lowercased()
        
        var m = 0
        var M = 5
        
        for i in 0..<guesses.count {
            
            var a = 0
            var b = 0
            
            for j in 0...4 {
                
                if guesses[i][j] == x {
                    if colors[i][j] == .None {
                        b += 1
                    }
                    else {
                        a += 1
                    }
                }
            }
            
            m = max(a, m)
            
            if b > 0 {
                M = min(a, M)
            }
        }
        
        if m > 0 {
            letterMinima[x] = m
        }
        if M < 5 {
            letterMaxima[x] = M
        }
        
    }
        
    var finalOutput = [String]()
    
    for word in output {
        
        var including = true
        
        // Introduce pause for async
        p += 1
        if p.isMultiple(of: 100) {
            await Task.yield()
        }
        
        for i in 0..<guesses.count {
            for j in 0...4 {
                if colors[i][j] == .Yellow {
                    if guesses[i][j] == word[j] {
                        including = false
                    }
                }
            }
        }
        
        if including {
            for (x,n) in letterMaxima {
                if word.filter({"\($0)" == x}).count > n {
                    including = false
                    break
                }
            }
        }
        
        if including {
            for (x,n) in letterMinima {
                if word.filter({"\($0)" == x}).count < n {
                    including = false
                    break
                }
            }
        }
        
        if including {
            finalOutput.append(word)
        }
    }
    
    // Return
    
    return finalOutput
    
    // OLD METHOD
    
//    var containsQuantitiesStrings = [String]()
    
//    for i in 0..<guesses.count {
//
//        var containsQuantitiesString = ""
//
//        for j in 0...4 {
//
//            if colors[i][j] == .Green {
//                greenLetters.append((guesses[i][j], j))
////                containsQuantitiesString += guesses[i][j]
//            }
//            else if colors[i][j] == .Yellow {
//                yellowLetters.append((guesses[i][j], j))
////                containsQuantitiesString += guesses[i][j]
//            }
//            else {
//                greyLetters.append((guesses[i][j], j))
//            }
//        }
//
////        containsQuantitiesStrings.append(containsQuantitiesString)
//    }
//
//    var finalOutput = [String]()
//
//    for word in output {
//        var keep = true
//
//        for (x,i) in greenLetters {
//            if word[i] != x {
//                keep = false
//                break
//            }
//        }
//
//        for (x,i) in (yellowLetters + greenLetters) {
//
//        }
//    }
    
    
    
    // Check for letters in sufficient quantities
    
//    for c in containsQuantitiesStrings {
//        await output = containsQuantities(output, string: c, quantityMode: 0, allowOtherLetters: true)
//    }
    
    // Check words one by one for incorrect letters
    
//    var finalOutput = [String]()
//
//    for word in output {
//
//        var keep = true
//
//        for (x,_) in greyLetters {
//            if word.contains(where: {"\($0)" == x}) {
//                keep = false
//            }
//        }
//
//        for (x,i) in yellowLetters {
//            if word[i] == x {
//                keep = false
//            }
//            else if !word.contains(where: {"\($0)" == x}) {
//                keep = false
//            }
//        }
//
//        if keep {
//            finalOutput.append(word)
//        }
//    }
    
    // Return
}

struct Wordle_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ToolView(tool: Tool.wordleSolver, selectedSorting: Sorting.allSortings[0], selectedResultDetailType: ResultDetailType.allResultDetailTypes[0])
        }
    }
}
