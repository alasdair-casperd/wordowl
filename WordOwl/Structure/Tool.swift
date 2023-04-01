import Foundation
import SwiftUI

struct Tool: Identifiable, Equatable {
    
    struct Category: Identifiable {
        var id: UUID = UUID()
        var name: String
        var tools: [Tool]
    }
    
    static func == (lhs: Tool, rhs: Tool) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id: UUID = UUID()
    let name: String
    let shortName: String
    
    let description: String
    let shortDescription: String    
    
    let searchFunction: ([String], AggregateInput) async -> [String]
    
    let symbolName: String?
    
    let input: InputType
    let prompt: [String]
    let promptName : String
    
    let color: Color
    
    static let categories = [
        Category(name: "Common Tools", tools: [anagramsTool, crosswordSolver, containsStringTool]),
        Category(name: "Search by Start", tools: [firstLetterTool, startingStringTool]),
        Category(name: "Search by End", tools: [lastLetterTool, endingStringTool]),
        Category(name: "Search by Letters", tools: [containsOnlyTool, containsAtLeastTool, containsQuantitiesTool]),
        Category(name: "Search by Length", tools: [wordLengthTool, wordLengthRangeTool]),
        Category(name: "Advanced Tools", tools: [matchesPatternTool]),
    ]
    
    static let anagramsTool = Tool(
        name: "Anagram Tool",
        shortName: "Anagrams",
        description: "Find words that contain the same letters as the input word but in a different order.",
        shortDescription: "Find anagrams of any word.",
        searchFunction: findAnagrams,
        symbolName: "shuffle",
        input: .string,
        prompt: ["Enter word..."], promptName: "Input Word",
        color: Color("WordOwl Red")
    )
    
    static let startingStringTool = Tool(
        name: "Starting Letters",
        shortName: "Starting Letters",
        description: "Enter a string of starting letters to find all words which begin with this string.",
        shortDescription: "Find words beginning with any string.",
        searchFunction: startingString,
        symbolName: "arrow.left.to.line",
        input: .string,
        prompt: ["Enter starting letters..."], promptName: "Input",
        color: Color("WordOwl Green")
    )
    
    
    static let endingStringTool = Tool(
        name: "Ending Letters",
        shortName: "Ending Letters",
        description: "Enter a string of ending letters to find all words which end with this string.",
        shortDescription: "Find words ending in any string.",
        searchFunction: endingString,
        symbolName: "arrow.right.to.line",
        input: .string,
        prompt: ["Enter ending letters..."], promptName: "Input",
        color: Color.teal
    )
    
    static let wordLengthTool = Tool(
        name: "Word Length",
        shortName: "Word Length",
        description: "Find all words of the specified length.",
        shortDescription: "Find words of a specific length.",
        searchFunction: wordLength,
        symbolName: "arrowtriangle.right.and.line.vertical.and.arrowtriangle.left",
        input: .number,
        prompt: [String](), promptName: "Length",
        color: Color("WordOwl Purple")
    )
    
    static let wordLengthRangeTool = Tool(
        name: "Word Length Range",
        shortName: "Length Range",
        description: "Find all words whose lengths fall within a specified range.",
        shortDescription: "Find words of a range of lengths.",
        searchFunction: wordLengthBetween,
        symbolName: "arrowtriangle.left.and.line.vertical.and.arrowtriangle.right",
        input: .range,
        prompt: ["From", "To"], promptName: "Range",
        color: Color("WordOwl Purple")
    )
    
    static let containsStringTool = Tool(
        name: "Contains String",
        shortName: "Contains String",
        description: "Find words containing a specified string of letters. The letters must appear consecutively and in the original order within the returned words.",
        shortDescription: "Find words containing a string.",
        searchFunction: containsString,
        symbolName: "textformat",
        input: .string,
        prompt: ["Enter string..."], promptName: "String",
        color: Color("WordOwl Yellow")
    )
    
    static let firstLetterTool = Tool(
        name: "First Letter",
        shortName: "First Letter",
        description: "Find all words starting with the specified letter.",
        shortDescription: "Find words starting with any letter.",
        searchFunction: startingString,
        symbolName: "arrow.left.to.line",
        input: .character,
        prompt: ["First Letter", "Enter first letter..."], promptName: "First Letter",
        color: Color("WordOwl Green")
    )
    
    static let lastLetterTool = Tool(
        name: "Last Letter",
        shortName: "Last Letter",
        description: "Find all words ending in the specified letter.",
        shortDescription: "Find words ending in any letter.",
        searchFunction: endingString,
        symbolName: "arrow.right.to.line",
        input: .character,
        prompt: ["Last Letter", "Enter last letter..."], promptName: "Last Letter",
        color: Color.teal
    )
    
    static let crosswordSolver = Tool(
        name: "Crossword Solver",
        shortName: "Crossword Solver",
        description: "Find words by entering known letters in certain positions. In plain text input mode, enter question marks (?) to indicate unknown letters.",
        shortDescription: "Find words with some known letters.",
        searchFunction: matchesSpaces,
        symbolName: "newspaper",
        input: .spaces,
        prompt: ["Length", ""], promptName: "Input",
        color: Color("WordOwl Orange")
    )
    
    static let containsOnlyTool = Tool(
        name: "Contains Only",
        shortName: "Contains Only",
        description: "Find words which contain exclusively letters from the specified list.",
        shortDescription: "Find words containing only certain letters.",
        searchFunction: containsOnly,
        symbolName: "lessthan.circle",
        input: .multipleCharacters,
        prompt: ["Characters"], promptName: "Input",
        color: Color("WordOwl Cold Blue")
    )
    
    static let containsAtLeastTool = Tool(
        name: "Contains At Least",
        shortName: "Contains At Least",
        description: "Find words which must contain at least the specified set of letters, but may contain others.",
        shortDescription: "Find words containing a list of letters.",
        searchFunction: containsAtLeast,
        symbolName: "greaterthan.circle",
        input: .multipleCharacters,
        prompt: ["Characters"], promptName: "Input",
        color: Color("WordOwl Cold Blue")
    )
    
    static let containsQuantitiesTool = Tool(
        name: "Contains Quantities",
        shortName: "Contains Quantities",
        description: "Find words according to the quantities of various letters contained. Select a quantity mode below for the desired functionality.",
        shortDescription: "A powerful tool for searching by letters.",
        searchFunction: containsQuantities,
        symbolName: "slider.horizontal.3",
        input: .characterQuantities,
        prompt: ["Characters"], promptName: "Input",
        color: Color("WordOwl Cold Blue")
    )
    
    static let matchesPatternTool = Tool(
        name: "Matches Pattern",
        shortName: "Matches Pattern",
        description: "Use question marks (?) to indicate unknown letters. Use dashes (-) to indicate whole unknown strings of letters. Use single digit numbers to indicate unknown but matching letters. For example, '1-1' indicates a word that must start and end with the same letter.",
        shortDescription: "An advanced tool for searching by a pattern.",
        searchFunction: matchesPattern,
        symbolName: "ellipsis.curlybraces",
        input: .code,
        prompt: ["Enter pattern..."], promptName: "Pattern",
        color: Color("WordOwl Cold Blue")
    )
}

enum InputType {
    case character
    case string
    case code
    case number
    case range
    case spaces
    case multipleCharacters
    case characterQuantities
}

