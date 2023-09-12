//
//  ToolList.swift
//  WordOwl
//
//  Created by Alasdair Casperd on 19/06/2022.
//

import Foundation

struct Filter: Identifiable, Equatable {
    static func == (lhs: Filter, rhs: Filter) -> Bool {
        return lhs.id == rhs.id
        && lhs.tool == rhs.tool
        && lhs.aggregateInput == rhs.aggregateInput
        && lhs.inverted == rhs.inverted
    }
    var id: UUID
    var tool: Tool
    var aggregateInput: AggregateInput
    var inverted: Bool = false
    
    var inputDescription : String {
        return aggregateInput.styledFor(tool: tool)
    }
    
    var description: String {
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
                return "Not " + inputDescription + " letters long"
            }
            else {
                return inputDescription + " letters long"
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
                return "Not of the form " + inputDescription
            }
            else {
                return "Of the form " + inputDescription
            }
        }
        else if tool == Tool.containsOnlyTool {
            if inverted {
                return "Error: this tool should not be inverted."
            }
            else {
                return "Only contains " + inputDescription
            }
        }
        else if tool == Tool.containsAtLeastTool {
            if inverted {
                return "Error: this tool should not be inverted."
            }
            else {
                return "Contains " + inputDescription
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
        
        if tool == Tool.matchesPatternTool {
            if inverted {
                return "Does not match pattern '\(aggregateInput.x)'"
            }
            else {
                return "Matches pattern '\(aggregateInput.x)'"
            }
        }
        
        return "Missing description."
    }
}
