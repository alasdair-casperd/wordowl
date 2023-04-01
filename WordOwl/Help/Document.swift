//
//  Document.swift
//  WordOwl
//
//  Created by Alasdair Casperd on 01/04/2023.
//

import SwiftUI

struct Document: Identifiable {
    
    struct Item: Identifiable {
        
        enum ItemType {
        case header, tool, paragraph, image, filter, filterList, results, continuedResults
        }
        
        let id: UUID = UUID()
        let type: ItemType
        var text: LocalizedStringKey?
        var image: Image?
        var results: [String]?
        var filter: Filter?
        var filterList: [Filter]?
        var tool: Tool?
    }
    
    let id: UUID = UUID()
    let icon: String
    let name: String
    let items: [Item]
    
    static let toolGuides = [
        anagramsGuide, crosswordSolverGuide, containsStringGuide, firstLetterGuide, startingStringGuide, lastLetterGuide, endingStringGuide, containsOnlyGuide, containsAtLeastGuide, containsQuantitiesGuide
    ]
    
    static let compoundSearchDocuments = [
        compoundSearchIntroduction, invertedFilters
    ]
    
    // Tool Guides
    
    static let anagramsGuide = Document(
        icon: Tool.anagramsTool.symbolName ?? "doc",
        name: Tool.anagramsTool.name,
        items: [
            Item(type: .tool, tool: Tool.anagramsTool),
            Item(
                type: .paragraph,
                text: "The **Anagrams** tool is used to search for anagrams of an input word. Two words are anagrams of each other if you can rearrange the letters of one to form the other."
            ),
            Item(type: .header, text: "Example"),
            Item(type: .filter, filter: Filter.exampleAnagramsFilter()),
            Item(type: .results, results: ["Alerting", "Altering", "Integral"]),
        ]
    )
    
    static let crosswordSolverGuide = Document(
        icon: Tool.crosswordSolver.symbolName ?? "doc",
        name: Tool.crosswordSolver.name,
        items: [
            Item(type: .tool, tool: Tool.crosswordSolver),
            Item(
                type: .paragraph,
                text: "The **Crossword Solver** tool is used to search for words of a given length when some of the letters, and their positions, are known. There are two possible input modes for this tool: Visual Input and Textual Input."
            ),
            Item(type: .header, text: "Visual Input"),
            Item(
                type: .paragraph,
                text: "*Visual Input* is the default input mode for shorter words. Press the plus (+) and minus (-) icons to control the length of the word. Once you have selected the correct length, type the letters you wish to enter into the appropriate spaces."
            ),
            Item(type: .image, image: Image("Crossword Solver Visual Input")),
            Item(type: .header, text: "Textual Input"),
            Item(
                type: .paragraph,
                text: "For longer words, the *Textual Input* mode is used. Here, the spaces above are replaced with a simple textbox. To perform a search, enter a string of characters using question marks (?) to indicate any unknown letters. Textual Input mode can be enabled by default in (Settings → Crossword Solver Input)."
            ),
            Item(type: .header, text: "Example Search"),
            Item(type: .filter, filter: Filter.exampleAnagramsFilter()),
            Item(type: .results, results: ["Alerting", "Altering", "Integral"]),
        ]
    )
    
    static let containsStringGuide = Document(
        icon: Tool.containsStringTool.symbolName ?? "doc",
        name: Tool.containsStringTool.name,
        items: [
            Item(type: .tool, tool: Tool.containsStringTool),
            Item(
                type: .paragraph,
                text: "The **Contains String** tool can be used to search for words that contains a certain string of letters. These letters must appear consecutively and in the original order within the returned words."
            ),
            Item(type: .header, text: "Example"),
            Item(
                type: .paragraph,
                text: "In the example below, the result 'volcanoes' is found, as 'volcanoes' contains the word 'canoe'."
            ),
            Item(type: .filter, filter: Filter.exampleContainsStringFilter()),
            Item(type: .results, results: ["Volcanoes", "Canoes", "Canoeists"]),
        ]
    )
    
    static let firstLetterGuide = Document(
        icon: Tool.firstLetterTool.symbolName ?? "doc",
        name: Tool.firstLetterTool.name,
        items: [
            Item(type: .tool, tool: Tool.firstLetterTool),
            Item(
                type: .paragraph,
                text: "The **First Letter** tool is used to search for words starting with a given letter."
            ),
            Item(type: .header, text: "Example"),
            Item(type: .filter, filter: Filter.exampleFirstLetterFilter()),
            Item(type: .results, results: ["Ubiquitous", "Ubiquitously", "Ubiquity"]),
        ]
    )
    
    static let lastLetterGuide = Document(
        icon: Tool.lastLetterTool.symbolName ?? "doc",
        name: Tool.lastLetterTool.name,
        items: [
            Item(type: .tool, tool: Tool.lastLetterTool),
            Item(
                type: .paragraph,
                text: "The **Last Letter** tool is used to search for words ending with a given letter."
            ),
            Item(type: .header, text: "Example"),
            Item(type: .filter, filter: Filter.exampleLastLetterFilter()),
            Item(type: .results, results: ["Academic", "Acerbic", "Acetic"]),
        ]
    )
    
    static let startingStringGuide = Document(
        icon: Tool.startingStringTool.symbolName ?? "doc",
        name: Tool.startingStringTool.name,
        items: [
            Item(type: .tool, tool: Tool.startingStringTool),
            Item(
                type: .paragraph,
                text: "The **Starting Letters** tool is used to search for words that start with a given string of letters."
            ),
            Item(type: .header, text: "Example"),
            Item(type: .filter, filter: Filter.exampleStartingStringFilter()),
            Item(type: .results, results: ["Historian", "Historians", "Historic"]),
        ]
    )
    
    static let endingStringGuide = Document(
        icon: Tool.endingStringTool.symbolName ?? "doc",
        name: Tool.endingStringTool.name,
        items: [
            Item(type: .tool, tool: Tool.endingStringTool),
            Item(
                type: .paragraph,
                text: "The **Ending Letters** tool is used to search for words that end in a given string of letters."
            ),
            Item(type: .header, text: "Example"),
            Item(type: .filter, filter: Filter.exampleEndingStringFilter()),
            Item(type: .results, results: ["Ambling", "Assembling", "Babbling", "Bobbling", "Bubbling"]),
        ]
    )
    
    static let containsOnlyGuide = Document(
        icon: Tool.containsOnlyTool.symbolName ?? "doc",
        name: Tool.containsOnlyTool.name,
        items: [
            Item(type: .tool, tool: Tool.containsOnlyTool),
            Item(
                type: .paragraph,
                text: "The **Contains Only** tool is used to search for words which only contains letters from a specified list. The returned words may contain these letters multiple times. Before searching, select which letters to allow from the 'Characters' menu."
            ),
            Item(type: .header, text: "Example"),
            Item(type: .filter, filter: Filter.exampleContainsAtLeastFilter()),
            Item(type: .results, results: ["Acceded", "Decade", "Dabbed"]),
        ]
    )
    
    static let containsAtLeastGuide = Document(
        icon: Tool.containsAtLeastTool.symbolName ?? "doc",
        name: Tool.containsAtLeastTool.name,
        items: [
            Item(type: .tool, tool: Tool.containsAtLeastTool),
            Item(
                type: .paragraph,
                text: "The **Contains At Least** tool is used to search for words contain certain letters. To use the tool, select which letters to require from the 'Characters' menu. The words returned may contain additional letters, but must contain the letters you specify."
            ),
            Item(type: .header, text: "Example"),
            Item(type: .filter, filter: Filter.exampleContainsAtLeastFilter()),
            Item(type: .results, results: ["Abdicate", "Abdicated", "Abdicates"]),
        ]
    )
    
    static let containsQuantitiesGuide = Document(
        icon: Tool.containsQuantitiesTool.symbolName ?? "doc",
        name: Tool.containsQuantitiesTool.name,
        items: [
            Item(type: .tool, tool: Tool.containsQuantitiesTool),
            Item(
                type: .paragraph,
                text: "The **Contains Quantities** tool is more advanced version of the **Contains Only** and **Contains At Least** tools. We recommend using it only if neither of those tools suits your needs."
            ),
            Item(type: .header, text: "Selecting Characters"),
            Item(
                type: .paragraph,
                text: "To use the tool, begin by selecting a list of letters under 'Add Characters'. The search will return words only that contain these characters. When you exit this view, you will be able to assign a quantity to each selected letter with the plus (+) and minus (-) buttons. You can also swipe to delete a character you no longer want to include."
            ),
            Item(type: .header, text: "Allowing Other Letters"),
            Item(
                type: .paragraph,
                text: "Next, choose whether or not to enable *Allow Other Letters*. If you do not enable this option, the tool will find words containing only the letters you selected. If you do enable the option, the returned words may contain additional letters that you did not select."
            ),
            Item(type: .header, text: "Quantity Modes"),
            Item(
                type: .paragraph,
                text: "Finally, select an option under 'Quantity Mode'. This setting controls how the quantities you provided affect the search. If you select *Minimum Mode*, the tool will search for words containing the selected letters in *at least* the specified quantities. If you select *Maximum Mode*, the tool will find words containing the letters in *at most* the specified quantities. If you select *Exact Mode*, the returned words must contain the selected letters in *exactly* the quantities you specify."
            ),
            Item(type: .header, text: "Example"),
            Item(type: .filter, filter: Filter.examplle()),
            Item(type: .results, results: ["Abdicate", "Abdicated", "Abdicates"]),
        ]
    )
    
    // Other Documents
    
    static let compoundSearchIntroduction = Document(
        icon: CompoundSearchView.icon,
        name: "Using Compound Search",
        items: [
        ]
    )
    
    static let invertedFilters = Document(
        icon: "circle.lefthalf.filled",
        name: "Inverted Filters",
        items: [
        ]
    )
}
