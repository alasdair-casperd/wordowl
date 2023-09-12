//
//  ToolView.swift
//  WordOwl
//
//  Created by Alasdair Casperd on 18/01/2022.
//

import SwiftUI

struct ToolView: View {
    
    var tool: Tool
    
    @State private var selectedDictionary = Dictionary.mainDictionaries[0]
    @State var selectedSorting: Sorting
    @State var selectedResultDetailType: ResultDetailType
    
    @StateObject var aggregateInput = AggregateInput()
    
    @State private var results = [String]()
    @State private var showingResults = false
    
    @State private var showingHelpSheet = false
    
    var filters: [Filter] {
        return [Filter(id: UUID(), tool: tool, aggregateInput: aggregateInput)]
    }
    
    var body: some View {

        Form {
            
            ToolInputView(tool: tool, aggregateInput: aggregateInput)
            ToolSettingsView(tool: tool, aggregateInput: aggregateInput)
            
            Section(header: Text("Search Options")) {
                Picker("Dictionary", selection: $selectedDictionary) {
                    ForEach(Dictionary.mainDictionaries) { dictionary in
                        Text(dictionary.shortName)
                            .tag(dictionary)
                    }
                }
            }
            
            Section {
                Picker("Sort Words", selection: $selectedSorting) {
                    ForEach(Sorting.allSortings) {sorting in
                        Text(sorting.name).tag(sorting)
                    }
                }
                Picker("Additional Detail", selection: $selectedResultDetailType) {
                    ForEach(ResultDetailType.allResultDetailTypes) { resultDetailType in
                        Text(resultDetailType.name).tag(resultDetailType)
                    }                    
                }
            } header: {
                Text("Display Options")
                
            } footer: {
                SearchButton(filters: filters, selectedDictionary: selectedDictionary, selectedSorting: selectedSorting, selectedResultDetailType: selectedResultDetailType, searchDisabled: searchDisabled)
                    .padding(.top, 40)
            }
        }

        .navigationTitle(tool.shortName)
        .toolbar {
            ToolbarItem() {
                if let guide = Document.documentForTool(tool) {
                    HelpButton(document: guide, suffix: " Guide")
                }
            }
        }
    }
    
//    func initiateSearch() {
//        self.showingResults = true
//    }
    
    var searchDisabled: Bool {
        get {
            switch tool.input {
            case .string:
                return aggregateInput.inputStrings[0] == ""
            case .spaces:
                var output = aggregateInput.inputStrings[9] != ""
                for i in 1...(aggregateInput.i) {
                    output = output || aggregateInput.inputStrings[i-1] != ""
                }
                return !output
            case .multipleCharacters:
                return aggregateInput.styledFor(tool: tool) == "None"
            case .characterQuantities:
                return aggregateInput.styledFor(tool: tool) == "None"
            case .code:
                return aggregateInput.inputStrings[0] == ""
            case .twoStrings:
                return aggregateInput.x == "" && aggregateInput.y == ""
            case .wordle:
                var correctLengths = true
                var allEmpty = true
                for i in 0...5 {
                    let l = aggregateInput.inputStrings[i].count
                    if !(l == 0 || l == 5) {
                        correctLengths = false
                    }
                    else if l == 5 {
                        allEmpty = false
                    }
                }
                return !correctLengths || allEmpty
            default:
                return false
            }
        }
    }
    
}


struct ToolView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ToolView(tool: Tool.wordleSolver, selectedSorting: Sorting.allSortings[0], selectedResultDetailType: ResultDetailType.allResultDetailTypes[0])
        }
    }
}
