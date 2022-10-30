import Foundation

struct Tool: Identifiable, Equatable {
    
    static func == (lhs: Tool, rhs: Tool) -> Bool {
        return lhs.id == rhs.id
    }
    
        
    let id: UUID
    let name: String
    let shortName: String
    
    let description: String
    let shortDescription: String    
    
    let searchFunction: (Dictionary, AggregateInput) -> [String]
    
    let symbolName: String?
    
    let input: InputType
    let prompt: [String]
    let promptName : String
}

enum InputType {
    case character
    case string
    case number
    case range
    case spaces
    case multipleCharacters
    case characterQuantities
}

class Tools {
    
    static let anagramsTool = Tool(
        id: UUID(),
        name: "Anagram Tool",
        shortName: "Anagrams",
        description: "Find words that contain the same letters as the input word but in a different order.",
        shortDescription: "Find anagrams of any word.",
        searchFunction: findAnagrams,
        symbolName: "shuffle",
        input: .string,
        prompt: ["Enter word..."], promptName: "Input Word"
    )
    
    static let startingStringTool = Tool(
        id: UUID(),
        name: "Starting Letters",
        shortName: "Starting Letters",
        description: "Enter a string of starting letters to find all words which begin with this string.",
        shortDescription: "Find words beginning with any string.",
        searchFunction: startingString,
        symbolName: "arrow.left.to.line",
        input: .string,
        prompt: ["Enter starting letters..."], promptName: "Input")
    
    static let endingStringTool = Tool(
        id: UUID(),
        name: "Ending Letters",
        shortName: "Ending Letters",
        description: "Enter a string of ending letters to find all words which end with this string.",
        shortDescription: "Find words ending in any string.",
        searchFunction: endingString,
        symbolName: "arrow.right.to.line",
        input: .string,
        prompt: ["Enter ending letters..."], promptName: "Input")
    
    static let wordLengthTool = Tool(
        id: UUID(),
        name: "Word Length",
        shortName: "Word Length",
        description: "Find all words of the specified length.",
        shortDescription: "Find words of a specific length.",
        searchFunction: wordLength,
        symbolName: "arrowtriangle.right.and.line.vertical.and.arrowtriangle.left",
        input: .number,
        prompt: [String](), promptName: "Length")
    
    static let wordLengthRangeTool = Tool(
        id: UUID(),
        name: "Word Length Range",
        shortName: "Length Range",
        description: "Find all words whose lengths fall within a specified range.",
        shortDescription: "Find words of a range of lengths.",
        searchFunction: wordLengthBetween,
        symbolName: "arrowtriangle.left.and.line.vertical.and.arrowtriangle.right",
        input: .range,
        prompt: ["From", "To"], promptName: "Range")
    
    static let containsStringTool = Tool(
        id: UUID(),
        name: "Contains String",
        shortName: "Contains String",
        description: "Find words containing a specified string of letters. The letters must appear consecutively and in the original order within the returned words.",
        shortDescription: "Find words containing a string.",
        searchFunction: containsString,
        symbolName: "textformat",
        input: .string,
        prompt: ["Enter string..."], promptName: "String")
    
    static let firstLetterTool = Tool(
        id: UUID(),
        name: "First Letter",
        shortName: "First Letter",
        description: "Find all words starting with the specified letter.",
        shortDescription: "Find words starting with any letter.",
        searchFunction: startingString,
        symbolName: "arrow.left.to.line",
        input: .character,
        prompt: ["First Letter", "Enter first letter..."], promptName: "First Letter")
    
    static let lastLetterTool = Tool(
        id: UUID(),
        name: "Last Letter",
        shortName: "Last Letter",
        description: "Find all words ending in the specified letter.",
        shortDescription: "Find words ending in any letter.",
        searchFunction: endingString,
        symbolName: "arrow.right.to.line",
        input: .character,
        prompt: ["Last Letter", "Enter last letter..."], promptName: "Last Letter")
    
    static let crosswordSolver = Tool(
        id: UUID(),
        name: "Crossword Solver",
        shortName: "Crossword Solver",
        description: "Find words by entering known letters in certain positions. In plain text input mode, enter question marks (?) to indicate unknown letters.",
        shortDescription: "Find words with some known letters.",
        searchFunction: matchesSpaces,
        symbolName: "ellipsis.circle",
        input: .spaces,
        prompt: ["Length", ""], promptName: "Input")
    
    static let containsOnlyTool = Tool(
        id: UUID(),
        name: "Contains Only",
        shortName: "Contains Only",
        description: "Find words which contain exclusively letters from the specified list.",
        shortDescription: "Find words containing only certain letters.",
        searchFunction: containsOnly,
        symbolName: "lessthan.circle",
        input: .multipleCharacters,
        prompt: ["Characters"], promptName: "Input")
    
    static let containsAtLeastTool = Tool(
        id: UUID(),
        name: "Contains At Least",
        shortName: "Contains At Least",
        description: "Find words which must contain at least the specified set of letters, but may contain others.",
        shortDescription: "Find words containing a list of letters.",
        searchFunction: containsAtLeast,
        symbolName: "greaterthan.circle",
        input: .multipleCharacters,
        prompt: ["Characters"], promptName: "Input")
    
    static let containsQuantitiesTool = Tool(
        id: UUID(),
        name: "Contains Quantities",
        shortName: "Contains Quantities",
        description: "Find words according to the quantities of various letters contained. Select a quantity mode below for the desired functionality.",
        shortDescription: "An advanced tool for searching by letters.",
        searchFunction: containsQuantities,
        symbolName: "slider.horizontal.3",
        input: .characterQuantities,
        prompt: ["Characters"], promptName: "Input")
}

