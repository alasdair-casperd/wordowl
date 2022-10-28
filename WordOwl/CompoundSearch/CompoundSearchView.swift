//
//  CustomToolView.swift
//  WordOwl
//
//  Created by Alasdair Casperd on 07/02/2022.
//

import SwiftUI

struct CompoundSearchView: View {
    
    @Environment(\.editMode) private var editMode
    
    @State private var selectedDictionary = Dictionaries.list[0]
    
    // (!) Make this reflect the app settings
    @State var selectedSorting: Sorting = Sortings.list[0]
    @State var selectedResultDetailType: ResultDetailType = ResultDetailTypes.list[0]
    
    // The current list of filters (searches)
    @StateObject var toolList: ToolList = ToolList()
    
    // Shows the tool picker sheet
    @State private var showingToolPicker = false
    @State private var showingSearchResults = false
    
    // Warning alert
    @State private var warningText = "Error"
    @State private var showingWarning = false
    
    @State var results = [String]()
    
    func addFilter(tool: Tool, aggregateInput: AggregateInput) {
        toolList.addFilter(tool: tool, aggregateInput: aggregateInput)
    }    
    
    var body: some View {
        NavigationView {
            ZStack {
                Form {

                    Section(
                        header: Text("Use multiple filters simultaneously to perform compound searches.")
                            .textCase(nil)
                            .font(.footnote)
                            .multilineTextAlignment(.leading)
                    ) {
                        ForEach(toolList.filters) { filter in
                            CompoundSearchRowView(order: (toolList.filters.firstIndex(of: filter) ?? 0) + 1, tool: filter.tool, aggregateInput: filter.aggregateInput)
                        }
                        .onDelete(perform: toolList.deleteFilters)
                        .onMove(perform: toolList.moveFilter)
                        
                        // Add filter
                        
                        Button(action: { showingToolPicker = true }) {
                            HStack {
                                Image(systemName: "plus.circle")
                                    .foregroundColor(.accentColor)
                                    .font(.title3)
                                Text("Add Filter")
                                Spacer()
                            }
                        }
                    }
                    
                    // Settings
                    
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
                    
                    // Search button
                    
                    Section {
                        Button(action: { initiateSearch() }) {
                            HStack {
                                Spacer()
                                Text("Search for words")
                                Spacer()
                            }
                        }.disabled(toolList.filters.count == 0)
                        .alert(warningText, isPresented: $showingWarning) {
                                    Button("Ok", role: .cancel) { }
                                }                        
                    }
                }
                .navigationBarTitle("Compound Search")
                .toolbar {
                    ToolbarItem() {
                        EditButton()
                    }
                }
                NavigationLink(
                    destination:
                        ResultsView(
                        tool: Tools.wordLengthTool,
                        dictionary: selectedDictionary,
                        sorting: selectedSorting,
                        resultDetailType: selectedResultDetailType,
                        aggregateInput: AggregateInput(),
                        input: "No input given",
                        compoundSearch: true,
                        toollist: toolList,
                        results: self.results),
                    isActive: $showingSearchResults
                ) { EmptyView() }
            }
        }
        .sheet(isPresented: $showingToolPicker) {
            ToolPickerView(addFilter: addFilter)
        }
    }
    
    func initiateSearch() {
        if toolList.filters.isEmpty {
            warningText = "Please Add Search Filters"
            showingWarning = true
        }
        else {
            
            results = [String]()
            var dict = selectedDictionary
            
            for filter in toolList.filters {
                results = filter.tool.searchFunction(dict, filter.aggregateInput)
                dict = CustomDictionary(words: results)
            }
            
            if results.isEmpty {
                warningText = "No Words Found"
                showingWarning = true
            }
            else {
                self.showingSearchResults = true
            }
        }
    }
}

struct CompoundSearchView_Previews: PreviewProvider {
    
    static var previews: some View {
        CompoundSearchView()
    }
}
