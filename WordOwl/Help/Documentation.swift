//
//  Documentation.swift
//  WordOwl
//
//  Created by Alasdair Casperd on 03/04/2023.
//

import SwiftUI

extension Document {
    
    static let generalGuides = [
        checklistMode, exportingResults, dictionarySelection, orderingResults, resultDetail
    ]
    
    static let toolGuides = [
        anagramsGuide, crosswordSolverGuide, containsStringGuide, firstLetterGuide, startingStringGuide, lastLetterGuide, endingStringGuide, containsOnlyGuide, containsAtLeastGuide, containsQuantitiesGuide, wordLengthGuide, wordLengthRangeGuide, matchesPatternGuide
    ]
    
    static let compoundSearchDocuments = [
        compoundSearchIntroduction, invertedFilters
    ]
    
    // General Guides
    
    static let checklistMode = Document(
        icon: "checkmark.circle",
        name: "Checklist Mode",
        items: [
            Item(
                type: .paragraph,
                text: "After performing a search, *Checklist Mode* allows you to manually filter options from the list of results. These selections can then be copied or exported as a text file. Note that checklist mode is only available when viewing \(PageResultsView.resultsPerPage) results or fewer."
            ),
            Item(type: .image, image: Image("Docs Checklist Mode")),
            Item(type: .header, text: "Activating Checklist Mode"),
            Item(
                type: .paragraph,
                text: "To activate Checklist Mode, long-press on a result and select 'Enter Checklist Mode'."
            ),
            Item(type: .image, image: Image("Docs Copy Enter Checklist Mode")),
            Item(
                type: .paragraph,
                text: "You can now tap on results to select and deselect them. With checklist mode activated, the export function will export only the results which you have selected. You can also long-press on a result again to access options to 'Select All' or 'Deselect All'."
            ),
            Item(type: .header, text: "Exiting Checklist Mode"),
            Item(
                type: .paragraph,
                text: "To deactivate Checklist Mode, long-press on an answer and select 'Exit Checklist Mode'."
            ),
            Item(type: .image, image: Image("Docs Exit Checklist Mode"))
        ]
    )
    
    static let exportingResults = Document(
        icon: "square.and.arrow.up",
        name: "Exporting Results",
        items: [
            Item(
                type: .paragraph,
                text: "After performing a search, you can export your results to copy them to the clipboard, save them as a text file or import them into other applications. To do so, tap the export icon in the top right-hand corner of the results view."
            ),
            Item(type: .image, image: Image("Docs Export Result Highlighted")),
            Item(type: .header, text: "Copying Results"),
            Item(
                type: .paragraph,
                text: "You can also copy individual results, or results selected with Checklist Mode, by long-pressing on a result and selecting 'Copy' or 'Copy Selections'."
            ),
            Item(type: .image, image: Image("Docs Copy Enter Checklist Mode")),
        ]
    )
    
    static let dictionarySelection = Document(
        icon: "book.closed",
        name: "Dictionary Selection",
        items: [
            Item(
                type: .paragraph,
                text: "Before performing a search, you can choose which dictionary to search."
            ),
            Item(type: .image, image: Image("Docs Dictionary Highlighted")),
            Item(
                type: .paragraph,
                text: "Currently, two dictionaries are available. The **WordOwl Dictionary** is a standard English dictionary, containing both English and American-English words, as well as a number of common proper nouns. The **Small** dictionary is a smaller dictionary containing around 65,000 of the most common English words. This dictionary aims to contain only the set of words with which the average English speaker is familiar. We aim to add more dictionaries to the app soon."
            ),
        ]
    )
    
    static let orderingResults = Document(
        icon: "arrow.up.arrow.down",
        name: "Sorting Results",
        items: [
            Item(
                type: .paragraph,
                text: "Before performing a search, you may select one of a number of options under 'Sort Words' to control how the results returned are sorted. Options include alphabetical sorting, sorting by length and many more."
            ),
            Item(type: .image, image: Image("Docs Sort Words Highlighted")),
            Item(type: .header, text: "Setting a Default Sorting"),
            Item(
                type: .paragraph,
                text: "It is possible to set a default choice for this option under (Settings → Default Ordering)."
            ),
        ]
    )
    
    static let resultDetail = Document(
        icon: "info.circle",
        name: "Additional Detail",
        items: [
            Item(
                type: .paragraph,
                text: "Before performing a search, you may choose to display additional information alongside the returned words. To do so, select an option under 'Additional Detail'."
            ),
            Item(type: .image, image: Image("Docs Additional Detail Highlighted")),
            Item(type: .header, text: "Example"),
            Item(
                type: .paragraph,
                text: "For example, if you wished to see the lengths of the words found displayed alongside them, you could select 'Word Length'."),
            Item(type: .header, text: "Setting a Default Option"),
            Item(
                type: .paragraph,
                text: "It is possible to set a default choice for this option under (Settings → Default Detail)."
            ),
        ]
    )
    
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
            Item(type: .image, image: Image("Docs Crossword Solver")),
            Item(type: .header, text: "Textual Input"),
            Item(
                type: .paragraph,
                text: "For longer words, the *Textual Input* mode is used. Here, the spaces above are replaced with a simple textbox. To perform a search, enter a string of characters using question marks (?) to indicate any unknown letters. Textual Input mode can be enabled by default in (Settings → Crossword Solver Input)."
            ),
            Item(type: .header, text: "Example"),
            Item(type: .filter, filter: Filter.exampleCrosswordFilter()),
            Item(type: .results, results: ["Gravely", "Gnawers", "Goatees"]),
        ]
    )
    
    static let containsStringGuide = Document(
        icon: Tool.containsStringTool.symbolName ?? "doc",
        name: Tool.containsStringTool.name,
        items: [
            Item(type: .tool, tool: Tool.containsStringTool),
            Item(
                type: .paragraph,
                text: "The **Contains String** tool can be used to search for words that contain a certain string of letters. These letters must appear consecutively and in the original order within the returned words."
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
                text: "The **Contains Quantities** tool is more advanced version of the Contains Only and Contains At Least tools. We recommend using it only if neither of those tools suits your needs."
            ),
            Item(type: .header, text: "Selecting Characters"),
            Item(
                type: .paragraph,
                text: "To use the tool, begin by selecting a list of letters under 'Add Characters'. The search will only return words that contain these characters. When you exit this view, you will be able to assign a quantity to each selected letter with the plus (+) and minus (-) buttons. You can also swipe to delete a character you no longer want to include."
            ),
            Item(type: .image, image: Image("Docs Contains Quantities")),
            Item(type: .header, text: "Allowing Other Letters"),
            Item(
                type: .paragraph,
                text: "Next, choose whether or not to enable *Allow Other Letters*. If you do not enable this option, the tool will find words containing only the letters you selected. If you do enable the option, the returned words may contain additional letters that you did not select."
            ),
            Item(type: .header, text: "Quantity Modes"),
            Item(
                type: .paragraph,
                text: "Finally, select an option under 'Quantity Mode'. This setting controls how the quantities you provided affect the search. If you select *Minimum Mode*, the tool will search for words containing the selected letters in at least the specified quantities. If you select *Maximum Mode*, the tool will find words containing the letters in at most the specified quantities. If you select *Exact Mode*, the returned words must contain the selected letters in exactly the quantities you specify."
            ),
            Item(type: .header, text: "Example"),
            Item(type: .filter, filter: Filter.exampleContainsQuantitiesFilter()),
            Item(type: .results, results: ["Allegorically", "Ballistically", "Collaterally"]),
        ]
    )
    
    static let wordLengthGuide = Document(
        icon: Tool.wordLengthTool.symbolName ?? "doc",
        name: Tool.wordLengthTool.name,
        items: [
            Item(type: .tool, tool: Tool.wordLengthTool),
            Item(
                type: .paragraph,
                text: "The **Word Length** tool simply finds all words of the specified length."
            ),
            Item(type: .header, text: "Example"),
            Item(type: .filter, filter: Filter.exampleWordLengthFilter()),
            Item(type: .results, results: ["Abandoning", "Abatements", "Abbreviate"]),
        ]
    )
    
    static let wordLengthRangeGuide = Document(
        icon: Tool.wordLengthRangeTool.symbolName ?? "doc",
        name: Tool.wordLengthRangeTool.name,
        items: [
            Item(type: .tool, tool: Tool.wordLengthRangeTool),
            Item(
                type: .paragraph,
                text: "The **Word Length Range** tool searches for all words whose lengths fall within the specified range. Use the plus (+) and minus (-) to select the bounds of the range (labelled 'From' and 'To'). Both bounds selected are included in the range."
            ),
            Item(type: .header, text: "Example"),
            Item(type: .filter, filter: Filter.exampleWordLengthRangeFilter()),
            Item(type: .results, results: ["Abandoning", "Abandonment", "Abatements"]),
        ]
    )
    
    static let matchesPatternGuide = Document(
        icon: Tool.matchesPatternTool.symbolName ?? "doc",
        name: Tool.matchesPatternTool.name,
        items: [
            Item(type: .tool, tool: Tool.matchesPatternTool),
            Item(
                type: .paragraph,
                text: "The **Matches Pattern** tool is a truly versatile searching tool for advanced users. To use the tool, combine known letters with the symbols detailed below to create a 'pattern' which the returned words must conform to."
            ),
            Item(type: .header, text: "Simple Spaces"),
            Item(
                type: .paragraph,
                text: "Just as when using the Crossword Solver tool in Textual Input mode, you can enter question marks (?) here to represent single unknown letters. You can use multiple repeated question marks to indicate unknown portions of the word of particular lengths. For example, '???e' indicates a four letter word that ends in 'e'."
            ),
            Item(type: .filter, filter: Filter.exampleMatchesPatternFilter1()),
            Item(type: .results, results: ["Able", "Ache", "Bake"]),
            
            Item(type: .header, text: "Free Spaces"),
            Item(
                type: .paragraph,
                text: "Hyphens (-) are used to indicate unknown portions of the word. A single hyphen can represent a sequence of any number of letters (even zero)."
            ),
            Item(type: .filter, filter: Filter.exampleMatchesPatternFilter2()),
            Item(type: .results, results: ["Exchangeable", "Excisable", "Excitable"]),
            Item(
                type: .paragraph,
                text: "Naturally, multiple hyphens can be employed for more complex searches."
            ),
            Item(type: .filter, filter: Filter.exampleMatchesPatternFilter3()),
            Item(type: .results, results: ["Astonishing", "Attending", "Attenuating"]),
            
            Item(type: .header, text: "Letter Variables"),
            Item(
                type: .paragraph,
                text: "The digits 0 through 9 can be used as 'variables'. That is, they function exactly as question marks (?) except that, where two or more of the same digit occur within the pattern, these letters must match in the returned words. For example, the pattern below can be used to search for all words that begin and end with the same letter and contain a double letter."
            ),
            Item(type: .filter, filter: Filter.exampleMatchesPatternFilter4()),
            Item(type: .results, results: ["Addenda", "Antenna", "Deemed"]),
            Item(
                type: .paragraph,
                text: "As a final example, the pattern below can be used to search for all words that contain three consecutive pairs of double letters."
            ),
            Item(type: .filter, filter: Filter.exampleMatchesPatternFilter5()),
            Item(type: .results, results: ["Bookkeeper", "Bookkeepers", "Bookkeeping"]),
        ]
    )
    
    // Compound Search
    
    static let compoundSearchIntroduction = Document(
        icon: CompoundSearchView.icon,
        name: "Using Compound Search",
        items: [
            Item(
                type: .paragraph,
                text: "*Compound Search* allows you to combine multiple tools together to perform complex searches. Use compound search when you need to find words satisfying multiple criteria."
            ),
            Item(type: .image, image: Image("Docs Compound Search Filters")),
            Item(type: .header, text: "Adding Filters"),
            Item(
                type: .paragraph,
                text: "To begin using Compound Search, navigate to the tab labelled 'Compound' and press 'Add Filter'."
            ),
            Item(type: .image, image: Image("Docs Compound Search Add Filter Highlighted")),
            Item(
                type: .paragraph,
                text: "Select the first tool with which you want to filter and configure it as you would normally. When you are ready, press 'Add' in the top right-hand corner."
            ),
            Item(type: .image, image: Image("Docs Compound Search Add Highlighted")),
            Item(
                type: .paragraph,
                text: "You can add as many filters as you like. When you are ready, press 'Search for Words' to initiate the search."
            ),
            Item(type: .header, text: "Editing a Filter"),
            Item(
                type: .paragraph,
                text: "You can edit any filter you have created by tapping on it. When you have made the changes you desire, make sure to press 'Save' in the top right-hand corner to save your changes."
            ),
            Item(type: .header, text: "Removing a Filter"),
            Item(
                type: .paragraph,
                text: "You can remove any filter that you have created by swiping it to the left. Alternatively, you can press 'Edit' in the top right-hand corner of the 'Compound' tap and tap on the appropriate red minus (-) icon that appears."
            ),
            Item(type: .image, image: Image("Docs Compound Search Delete Filter")),
            Item(type: .header, text: "Examples"),
            Item(
                type: .paragraph,
                text: "The filters below could be used to search for words which begin with 'Se' and end with 'ke'."
            ),
            Item(type: .filters, filters: Filter.exampleCompoundSearchFilters1()),
            Item(type: .results, results: ["Seaquake", "Seedcake", "Seedlike"]),
            Item(
                type: .paragraph,
                text: "Numerous filters can be combined for truly complex searches, as shown in the example below."
            ),
            Item(type: .filters, filters: Filter.exampleCompoundSearchFilters2()),
            Item(type: .results, results: ["Airproof", "Approach", "Approval"]),
            
        ]
    )
    
    static let invertedFilters = Document(
        icon: "exclamationmark.arrow.triangle.2.circlepath",
        name: "Inverting Filters",
        items: [
            Item(
                type: .paragraph,
                text: "When adding a filter to a Compound Search, you will have the option to invert the filter. Inverted filters return the opposite of the results that they would otherwise. For example, if you inverted the *Starting Letter* tool, the search would now avoid any words beginning with the selected letter."
            ),
            Item(type: .image, image: Image("Docs Invert Filter Highlighted"))
        ]
    )

    
}
