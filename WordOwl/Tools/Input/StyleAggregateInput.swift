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
            return "None"
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
    case .code:
        if aggregateInput.x.count > 0 {
            return "\"" + aggregateInput.x.lowercased() + "\""
        }
        else {
            return "None"
        }
    }
}

// Produces a string describing the effect of a filter with a given tool and aggregate input

func styledAggregateInputForFilterDisplay(_ aggregateInput: AggregateInput, tool: Tool, inverted: Bool) -> String {
    
    if tool == Tool.anagramsTool {
        if inverted {
            return "Not an anagram of " + "\"" + aggregateInput.x.lowercased().capitalizingFirstLetter() + "\""
        }
        else {
            return "Anagram of " + "\"" + aggregateInput.x.lowercased().capitalizingFirstLetter() + "\""
        }
    }
    else if tool == Tool.startingStringTool {
        if inverted {
            return "Does not start with " + "\"" + aggregateInput.x.lowercased().capitalizingFirstLetter() + "\""
        }
        else {
            return "Starts with " + "\"" + aggregateInput.x.lowercased().capitalizingFirstLetter() + "\""
        }
    }
    else if tool == Tool.endingStringTool {
        if inverted {
            return "Does not end with " + "\"" + aggregateInput.x.lowercased() + "\""
        }
        else {
            return "Ends with " + "\"" + aggregateInput.x.lowercased() + "\""
        }
    }
    else if tool == Tool.wordLengthTool {
        if inverted {
            return "Not \(aggregateInput.i)" + " letters long"
        }
        else {
            return "\(aggregateInput.i)" + " letters long"
        }
    }
    else if tool == Tool.wordLengthRangeTool {
        if inverted {
            return "Not " + styledAggregateInput(aggregateInput, tool: tool) + " letters long"
        }
        else {
            return styledAggregateInput(aggregateInput, tool: tool) + " letters long"
        }
    }
    else if tool == Tool.containsStringTool {
        if inverted {
            return "Does not contain " + "\"" + aggregateInput.x.lowercased().capitalizingFirstLetter() + "\""
        }
        else {
            return "Contains " + "\"" + aggregateInput.x.lowercased().capitalizingFirstLetter() + "\""
        }
    }
    else if tool == Tool.firstLetterTool {
        if inverted {
            return "Does not start with " + aggregateInput.a.rawValue.uppercased()
        }
        else {
            return "Starts with " + aggregateInput.a.rawValue.uppercased()
        }
    }
    else if tool == Tool.lastLetterTool {
        if inverted {
            return "Does not end with " + aggregateInput.a.rawValue.uppercased()
        }
        else {
            return "Ends with " + aggregateInput.a.rawValue.uppercased()
        }
    }
    else if tool == Tool.crosswordSolver {
        if inverted {
            return "Not of the form " + styledAggregateInput(aggregateInput, tool: tool)
        }
        else {
            return "Of the form " + styledAggregateInput(aggregateInput, tool: tool)
        }
    }
    else if tool == Tool.containsOnlyTool {
        if inverted {
            return "Error: this tool should not be inverted."
        }
        else {
            return "Only contains " + styledAggregateInput(aggregateInput, tool: tool)
        }
    }
    else if tool == Tool.containsAtLeastTool {
        if inverted {
            return "Error: this tool should not be inverted."
        }
        else {
            return "Contains " + styledAggregateInput(aggregateInput, tool: tool)
        }
    }
    else if tool == Tool.containsQuantitiesTool {
        
        if inverted {
            return "Error: this tool should not be inverted."
        }
        else {
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
    }
    else if tool == Tool.matchesPatternTool {
        if inverted {
            return "Not of the form \"\(aggregateInput.x)\""
        }
        else {
            return "Of the form \"\(aggregateInput.x)\""
        }
    }
    
    return "Missing description."
}
