//
//  CustomToolView.swift
//  WordOwl
//
//  Created by Alasdair Casperd on 07/02/2022.
//

import SwiftUI

struct CompoundSearchView: View {
    
    static let filledIcon = "square.stack.3d.up.fill"
    static let icon = "square.stack.3d.up"
    
    @Environment(\.editMode) private var editMode
    
    @State private var selectedDictionary = Dictionaries.list[0]
    
    // (!) Make this reflect the app settings
    @State var selectedSorting: Sorting = Sortings.list[0]
    @State var selectedResultDetailType: ResultDetailType = ResultDetailTypes.list[0]
    
    // The current list of filters (searches)
    @StateObject var toolList: ToolList = ToolList()
    
    // Shows the tool picker sheet
    @State private var showingToolPicker = false
    @State private var showingToolEditor = false
    @State private var showingSearchResults = false
    
    @State private var editorFilter = Filter(id: UUID(), tool: Tool.startingStringTool, aggregateInput: AggregateInput())
    
    var searchDisabled: Bool {
        return toolList.filters.count == 0
    }
    
    func addFilter(filter: Filter) {
        toolList.addFilter(filter: filter)
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
                            .padding(.bottom)
                    ) {
                        ForEach(toolList.filters) { filter in
//                            NavigationLink(destination:
//                                            ToolFilterView(dismiss: {showingToolEditor = false}, aggregateInput: filter.aggregateInput, tool: filter.tool, addFilter: addFilter)
//                                    .navigationTitle(filter.tool.shortName)) {
                            CompoundSearchRowView(order: (toolList.filters.firstIndex(of: filter) ?? 0) + 1, tool: filter.tool, aggregateInput: filter.aggregateInput, inverted: filter.inverted, initiateEdit: {initiateEdit(filter: filter)})
//                            }
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
                    
                    Section(header: Text("Search Options")) {
                        Picker("Dictionary", selection: $selectedDictionary) {
                            ForEach(Dictionaries.list) { dictionary in
                                
                                Text(dictionary.name)
                                .tag(dictionary)
                            }
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
                    
                    // Search button
                    
                    SearchButton(filters: toolList.filters, selectedDictionary: selectedDictionary, selectedSorting: selectedSorting, selectedResultDetailType: selectedResultDetailType, searchDisabled: searchDisabled)                    
                }
                .navigationBarTitle("Compound Search")
                .toolbar {
                    ToolbarItem() {
                        EditButton()
                    }
                }

            }
        }
        .sheet(isPresented: $showingToolPicker) {
            ToolPickerView(addFilter: addFilter)
        }
        .sheet(isPresented: $showingToolEditor) {
            NavigationView {
                ToolFilterView(id: editorFilter.id, dismiss: {showingToolEditor = false}, buttonText: "Save", tool: editorFilter.tool, preloadingFilter: editorFilter, addFilter: addFilter)
            }
        }
        .onChange(of: editorFilter) { _ in print("Editor filter updated")}
    }
    
    func initiateEdit(filter: Filter) {
        print("Initiating edit")
        print("FILTER")
        print("Inverted: \(filter.inverted)")
        print("Input x: \(filter.aggregateInput.x)")
        editorFilter = filter
        print("FILTER")
        print("Inverted: \(editorFilter.inverted)")
        print("Input x: \(editorFilter.aggregateInput.x)")
        showingToolEditor = true
    }
    
    func initiateSearch() {
        self.showingSearchResults = true
    }
}

struct CompoundSearchView_Previews: PreviewProvider {
    
    static var previews: some View {
        CompoundSearchView()
    }
}
