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
    
    @State private var selectedDictionary = Dictionary.mainDictionaries[0]
    
    // (!) Make this reflect the app settings
    @State var selectedSorting: Sorting = Sorting.allSortings[0]
    @State var selectedResultDetailType: ResultDetailType = ResultDetailType.allResultDetailTypes[0]
    
    // The current list of filters (searches)
    @StateObject var toolList: ToolList = ToolList()
    
    // Shows the tool picker sheet
    @State private var showingToolPicker = false
    @State private var showingToolEditor = false
    @State private var showingSearchResults = false
    
    @State private var editMode: EditMode = .inactive
    
    @State private var editorFilter = Filter(id: UUID(), tool: Tool.startingStringTool, aggregateInput: AggregateInput())
    
    var searchDisabled: Bool {
        return toolList.filters.count == 0
    }
    
    func addFilter(filter: Filter) {
        toolList.addFilter(filter: filter)
    }
    
    var body: some View {
        ZStack {
            Form {
                Section(
                    header: Text("Use multiple filters simultaneously to perform compound searches.")
                        .textCase(nil)
                        .font(.body)
                        .multilineTextAlignment(.leading)
                        .padding(.bottom)
                        .listRowInsets(EdgeInsets())
                        .foregroundColor(.primary)
                ) {
                    ForEach(toolList.filters) { filter in
//                            NavigationLink(destination:
//                                            ToolFilterView(dismiss: {showingToolEditor = false}, aggregateInput: filter.aggregateInput, tool: filter.tool, addFilter: addFilter)
//                                    .navigationTitle(filter.tool.shortName)) {
                        CompoundSearchRowView(order: (toolList.filters.firstIndex(of: filter) ?? 0) + 1, filter: filter, initiateEdit: {initiateEdit(filter: filter)})
//                            }
                    }
                    .onDelete(perform: onDelete)
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
                        //.navigationTitle("Sort Words")
                    }
                    Picker("Additional Detail", selection: $selectedResultDetailType) {
                        ForEach(ResultDetailType.allResultDetailTypes) { resultDetailType in
                            Text(resultDetailType.name).tag(resultDetailType)
                        }
                        //.navigationTitle("Additional Detail")
                    }
                } header: {
                    Text("Display Options")
                } footer: {
                    SearchButton(filters: toolList.filters, selectedDictionary: selectedDictionary, selectedSorting: selectedSorting, selectedResultDetailType: selectedResultDetailType, searchDisabled: searchDisabled)
                        .padding(.top, 40)
                }
                
            }
            .environment(\.editMode, .constant(editMode).animation(.spring()))
            .navigationBarTitle("Compound Search")
            .toolbar {
                
                ToolbarItem(placement: iPadVersion ? .navigationBarTrailing : .navigationBarLeading) {
                    HelpButton(document: .compoundSearchIntroduction)
                }
                
                ToolbarItem() {
//                        EditButton()
                    Button(editMode == .active ? "Done" : "Edit") {
                        if editMode == .active {
                            withAnimation {
                                editMode = .inactive
                            }
                        }
                        else {
                            withAnimation {
                                editMode = .active
                            }
                        }
                    }
                    .disabled(toolList.filters.count == 0)
                }
            }
            .onAppear {
                if toolList.filters.count == 0 {
                    selectedSorting = Sorting.allSortings[UserDefaults.standard.integer(forKey: "selectedSorting")]
                    selectedResultDetailType = ResultDetailType.allResultDetailTypes[UserDefaults.standard.integer(forKey: "selectedResultDetailType")]
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
        editorFilter = filter
        showingToolEditor = true
    }
    
    func initiateSearch() {
        self.showingSearchResults = true
    }
    
    func onDelete(at offsets: IndexSet) {
        toolList.deleteFilters(at: offsets)
        if toolList.filters.count == 0 {
            editMode = EditMode.inactive
        }
    }
}

struct CompoundSearchView_Previews: PreviewProvider {
    
    static var previews: some View {
        NavigationView {
            CompoundSearchView()
        }
    }
}
