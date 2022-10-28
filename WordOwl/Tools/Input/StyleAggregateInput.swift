//
//  StyleAggregateInput.swift
//  WordOwl
//
//  Created by Alasdair Casperd on 06/02/2022.
//

import Foundation

// Produces a string summarising a tool's input

func styledAggregateInput(_ aggregateInput: AggregateInput, tool: Tool) -> String {
    switch tool.input {
    case .string:
        if aggregateInput.x.count > 0 {
            return "\"" + aggregateInput.x.lowercased().capitalizingFirstLetter() + "\""
        }
        else {
            return ""
        }
    case .number:
        return "\(aggregateInput.i)"
    case .range:
        return "\(aggregateInput.j) to \(aggregateInput.i)"
    case .character:
        return aggregateInput.a.rawValue
    case .spaces:
        var output = aggregateInput.inputStrings[9].lowercased()
        if output.isEmpty {
            for i in 1...aggregateInput.i {
                let c = aggregateInput.inputStrings[i-1].uppercased()
                output += c == "" ? "?" : c
                output += " "
            }
        }        
        return output
    case .multipleCharacters:
        var output = ""
        var first = true
        for letter in EnglishAlphabet.allCases {
            if aggregateInput.inputBools[EnglishAlphabet.allCases.firstIndex(of: letter)!] {
                if !first {
                    output += ", "
                }
                output += letter.rawValue
                first = false
            }
        }
        output = output.isEmpty ? "None" : output
        return output
    case .characterQuantities:
        var output = ""
        var first = true
        for letter in EnglishAlphabet.allCases {
            if aggregateInput.inputBools[EnglishAlphabet.allCases.firstIndex(of: letter)!] {
                if !first {
                    output += ", "
                }
                output += "\(aggregateInput.inputInts[EnglishAlphabet.allCases.firstIndex(of: letter)!]) X "
                output += letter.rawValue
                first = false
            }
        }
        output = output.isEmpty ? "None" : output
        return output
    }
}

// Produces a string describing the effect of a filter with a given tool and aggregate input

func styledAggregateInputForFilterDisplay(_ aggregateInput: AggregateInput, tool: Tool) -> String {
    
    if tool == Tools.anagramsTool {
        return "Anagram of " + "\"" + aggregateInput.x.lowercased().capitalizingFirstLetter() + "\""
    }
    else if tool == Tools.startingStringTool {
        return "Starts with " + "\"" + aggregateInput.x.lowercased().capitalizingFirstLetter() + "\""
    }
    else if tool == Tools.endingStringTool {
        return "Ends with " + "\"" + aggregateInput.x.lowercased() + "\""
    }
    else if tool == Tools.wordLengthTool {
        return "\(aggregateInput.i)" + " letters long"
    }
    else if tool == Tools.wordLengthRangeTool {
        return styledAggregateInput(aggregateInput, tool: tool) + " letters long"
    }
    else if tool == Tools.containsStringTool {
        return "Contains " + "\"" + aggregateInput.x.lowercased().capitalizingFirstLetter() + "\""
    }
    else if tool == Tools.firstLetterTool {
        return "Starts with " + aggregateInput.a.rawValue.uppercased()
    }
    else if tool == Tools.lastLetterTool {
        return "Ends with " + aggregateInput.a.rawValue.uppercased()
    }
    else if tool == Tools.crosswordSolver {
        return "Of the form " + styledAggregateInput(aggregateInput, tool: tool)
    }
    else if tool == Tools.containsOnlyTool {
        return "Only contains the letters " + styledAggregateInput(aggregateInput, tool: tool)
    }
    else if tool == Tools.containsAtLeastTool {
        return "Contains the letters " + styledAggregateInput(aggregateInput, tool: tool)
    }
    else if tool == Tools.containsQuantitiesTool {
        
        var output = ""
        if aggregateInput.inputInts[30] == 0 {
            output = "Contains at least "
        }
        else if aggregateInput.inputInts[30] == 1 {
            output = "Contains exactly "
        }
        else {
            output = "Contains no more than "
        }
            
        var first = true
        for letter in EnglishAlphabet.allCases {
            if aggregateInput.inputBools[EnglishAlphabet.allCases.firstIndex(of: letter)!] {
                if !first {
                    output += ", "
                }
                output += "\(aggregateInput.inputInts[EnglishAlphabet.allCases.firstIndex(of: letter)!]) "
                output += letter.rawValue
                output += "'s"
                first = false
            }
        }
        
        return output
    }
    
    return "Missing description."
}
