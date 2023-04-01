//
//  ToolView.swift
//  WordOwl
//
//  Created by Alasdair Casperd on 18/01/2022.
//

import SwiftUI

struct ToolView: View {
    
    var tool: Tool
    
    @State private var selectedDictionary = Dictionaries.list[0]
    @State var selectedSorting: Sorting
    @State var selectedResultDetailType: ResultDetailType
    
    @StateObject var aggregateInput = AggregateInput()
    
    @State private var results = [String]()
    @State private var showingResults = false
    
    var filters: [Filter] {
        return [Filter(id: UUID(), tool: tool, aggregateInput: aggregateInput)]
    }
    
    var body: some View {
        ZStack {
            Form {
                Section(footer: Text(tool.description)) {
                    ToolInputView(tool: tool, aggregateInput: aggregateInput)
                }
                
                ToolSettingsView(tool: tool, aggregateInput: aggregateInput)
                
                Section(header: Text("Search Options")) {
                    Picker("Dictionary", selection: $selectedDictionary) {
                        ForEach(Dictionaries.list) { dictionary in
                            
                            Text(dictionary.name)
//                            HStack {
//                                Image(systemName: dictionary.symbolName ?? "text.book.closed.fill")
//                                Text(dictionary.name)
//                            }
                            .tag(dictionary)
                        }
                        //.navigationTitle("Dictionary")
                    }
                }
                
                Section(header: Text("Display Options")) {
                    Picker("Sort Words", selection: $selectedSorting) {
                        ForEach(Sortings.list) {sorting in
                            Text(sorting.name).tag(sorting)
                        }
                        //.navigationTitle("Sort Words")
                    }
                    Picker("Additional Detail", selection: $selectedResultDetailType) {
                        ForEach(ResultDetailTypes.list) { resultDetailType in
                            Text(resultDetailType.name).tag(resultDetailType)
                        }
                        //.navigationTitle("Additional Detail")
                    }
                }
                SearchButton(filters: filters, selectedSorting: selectedSorting, selectedResultDetailType: selectedResultDetailType, searchDisabled: searchDisabled)
            }
//            NavigationLink(
//                destination:
//                    ResultsView(
//                    tool: tool,
//                    dictionary:selectedDictionary,
//                    sorting: selectedSorting,
//                    resultDetailType: selectedResultDetailType,
//                    aggregateInput: aggregateInput,
//                    input: styledAggregateInput(aggregateInput, tool: tool)
//                    ),
//                isActive:
//                    $showingResults
//            ) { EmptyView() }
        }
        .navigationTitle(tool.shortName)        
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
                return styledAggregateInput(aggregateInput, tool: tool) == "None"
            case .characterQuantities:
                return styledAggregateInput(aggregateInput, tool: Tool.containsOnlyTool) == "None"
            case .code:
                return aggregateInput.inputStrings[0] == ""
            default:
                return false
            }
        }
    }
    
}


struct ToolView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ToolView(tool: Tool.containsAtLeastTool, selectedSorting: Sortings.list[0], selectedResultDetailType: ResultDetailTypes.list[0])
        }
    }
}
