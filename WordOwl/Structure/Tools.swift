
import SwiftUI

extension Tool {
    
    static let categories = [
        Category(name: "Common Tools", tools: [anagramsTool, crosswordSolver, containsStringTool]),
        Category(name: "Search by Start", tools: [firstLetterTool, startingStringTool]),
        Category(name: "Search by End", tools: [lastLetterTool, endingStringTool]),
        Category(name: "Search by Letters", tools: [containsOnlyTool, containsAtLeastTool, containsQuantitiesTool]),
        Category(name: "Search by Length", tools: [wordLengthTool, wordLengthRangeTool]),        
        Category(name: "Word Game Solvers", tools: [wordleSolver, domingoSolver, wordWheelSolver], compoundable: false),
        Category(name: "Advanced Tools", tools: [matchesPatternTool]),
    ]

    static let anagramsTool = Tool(
        name: "Anagram Tool",
        shortName: "Anagrams",
        description: "Find words that contain the same letters as the input word but in a different order.",
        shortDescription: "Find anagrams of any word.",
        searchFunction: findAnagrams,
        icon: Icon.VariableIcon.image("shuffle"),
        input: .string,
        prompt: ["Enter word..."], promptName: "Input Word",
        color: Color("WordOwl Red")
    )

    static let startingStringTool = Tool(
        name: "Starting Letters",
        shortName: "Starting Letters",
        description: "Enter a string of starting letters to find all words which begin with this string.",
        shortDescription: "Find words beginning with any string.",
        searchFunction: startingStringOrCharacter,
        icon: Icon.VariableIcon.image("arrow.left.to.line"),
        input: .string,
        prompt: ["Enter starting letters..."], promptName: "Input",
        color: Color("WordOwl Green")
    )


    static let endingStringTool = Tool(
        name: "Ending Letters",
        shortName: "Ending Letters",
        description: "Enter a string of ending letters to find all words which end with this string.",
        shortDescription: "Find words ending in any string.",
        searchFunction: endingStringOrCharacter,
        icon: Icon.VariableIcon.image("arrow.right.to.line"),
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
        icon: Icon.VariableIcon.image("arrowtriangle.right.and.line.vertical.and.arrowtriangle.left"),
        input: .number,
        prompt: [String](), promptName: "Length",
        color: Color("WordOwl Warm Blue")
    )

    static let wordLengthRangeTool = Tool(
        name: "Word Length Range",
        shortName: "Length Range",
        description: "Find all words whose lengths fall within a specified range.",
        shortDescription: "Find words of a range of lengths.",
        searchFunction: wordLengthBetween,
        icon: Icon.VariableIcon.image("arrowtriangle.left.and.line.vertical.and.arrowtriangle.right"),
        input: .range,
        prompt: ["From", "To"], promptName: "Range",
        color: Color("WordOwl Warm Blue")
    )

    static let containsStringTool = Tool(
        name: "Contains String",
        shortName: "Contains String",
        description: "Find words containing a specified string of letters. The letters must appear consecutively and in the original order within the returned words.",
        shortDescription: "Find words containing a string.",
        searchFunction: containsString,
        icon: Icon.VariableIcon.image("textformat"),
        input: .string,
        prompt: ["Enter string..."], promptName: "String",
        color: Color("WordOwl Yellow")
    )

    static let firstLetterTool = Tool(
        name: "First Letter",
        shortName: "First Letter",
        description: "Find all words starting with the specified letter.",
        shortDescription: "Find words starting with any letter.",
        searchFunction: startingStringOrCharacter,
        icon: Icon.VariableIcon.image("arrow.left.to.line"),
        input: .character,
        prompt: ["First Letter", "Enter first letter..."], promptName: "First Letter",
        color: Color("WordOwl Green")
    )

    static let lastLetterTool = Tool(
        name: "Last Letter",
        shortName: "Last Letter",
        description: "Find all words ending in the specified letter.",
        shortDescription: "Find words ending in any letter.",
        searchFunction: endingStringOrCharacter,
        icon: Icon.VariableIcon.image("arrow.right.to.line"),
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
        icon: Icon.VariableIcon.image("newspaper"),
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
        icon: Icon.VariableIcon.image("lessthan.circle"),
        input: .multipleCharacters,
        prompt: ["Enter letters..."], promptName: "Input",
        color: Color("WordOwl Cold Blue")
    )

    static let containsAtLeastTool = Tool(
        name: "Contains At Least",
        shortName: "Contains At Least",
        description: "Find words which must contain at least the specified set of letters, but may contain others.",
        shortDescription: "Find words containing a list of letters.",
        searchFunction: containsAtLeast,
        icon: Icon.VariableIcon.image("greaterthan.circle"),
        input: .multipleCharacters,
        prompt: ["Enter letters..."], promptName: "Input",
        color: Color("WordOwl Cold Blue")
    )

    static let containsQuantitiesTool = Tool(
        name: "Contains Quantities",
        shortName: "Contains Quantities",
        description: "Find words according to the quantities of various letters contained. Select a quantity mode below for the desired functionality.",
        shortDescription: "A powerful tool for searching by letters.",
        searchFunction: containsQuantities,
        icon: Icon.VariableIcon.image("slider.horizontal.3"),
        input: .characterQuantities,
        prompt: ["Enter letters..."], promptName: "Input",
        color: Color("WordOwl Cold Blue")
    )

    static let matchesPatternTool = Tool(
        name: "Matches Pattern",
        shortName: "Matches Pattern",
        description: "Use question marks (?) to indicate unknown letters. Use hyphens (-) to indicate whole unknown strings of letters. Use single digit numbers to indicate unknown but matching letters. For example, '1-1' indicates a word that must start and end with the same letter.",
        shortDescription: "An advanced tool for searching by a pattern.",
        searchFunction: matchesPattern,
        icon: Icon.VariableIcon.image("ellipsis.curlybraces"),
        input: .code,
        prompt: ["Enter pattern..."], promptName: "Pattern",
        color: Color("WordOwl Dark Blue")
    )

    static let domingoSolver = Tool(
        name: "Domingo Solver",
        shortName: "Domingo Solver",
        description: "Solve Domingo puzzles by entering the characters preceding and following the coda (❖).",
        shortDescription: "Solve puzzles from the hit iOS game.",
        searchFunction: matchesDomingoPuzzle,
        icon: Icon.VariableIcon.character("❖"),
        input: .twoStrings,
        prompt: ["Enter starting letters...", "Enter ending letters..."], promptName: "Input",
        color: Color("WordOwl Purple"),
        compoundable: false
    )
    
    static let wordWheelSolver = Tool(
        name: "Word Wheel Solver",
        shortName: "Word Wheel Solver",
        description: "Find words using only a small set of letters which must contain a required letter.",
        shortDescription: "Solve Word Wheel puzzles.",
        searchFunction: matchesWordWheel,
        icon: Icon.VariableIcon.image("circle.hexagongrid"),
        input: .twoStrings,
        prompt: ["Enter allowed letters...", "Enter required letter(s)..."], promptName: "Input",
        color: Color("WordOwl Purple"),
        compoundable: false
    )
    
    static let wordleSolver = Tool(
        name: "Wordle Solver",
        shortName: "Wordle Solver",
        description: "Enter the guesses that you have made so far, and tap on the squares below to enter the colours you received.",
        shortDescription: "Solve Wordle puzzles.",
        searchFunction: matchesWordle,
        icon: Icon.VariableIcon.image("square.grid.3x3.square"),
        input: .wordle,
        prompt: [String](), promptName: "Guesses",
        color: Color("WordOwl Purple"),
        compoundable: false
    )
}
