//
//  ToolPickerView.swift
//  WordOwl
//
//  Created by Alasdair Casperd on 19/06/2022.
//

import SwiftUI

struct ToolPickerView: View {
    
    // Closure called when finished
    var addFilter: (Tool, AggregateInput) -> Void
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Common tools")) {
                    ToolPickerRowItem(addFilter: addFilter, dismiss: dismiss, tool: Tools.anagramsTool)
                    ToolPickerRowItem(addFilter: addFilter, dismiss: dismiss, tool: Tools.crosswordSolver)
                    ToolPickerRowItem(addFilter: addFilter, dismiss: dismiss, tool: Tools.containsStringTool)
                }
                
                Section(header: Text("Search by start")) {
                    ToolPickerRowItem(addFilter: addFilter, dismiss: dismiss, tool: Tools.firstLetterTool)
                    ToolPickerRowItem(addFilter: addFilter, dismiss: dismiss, tool: Tools.startingStringTool)
                }
                Section(header: Text("Search by end")) {
                    ToolPickerRowItem(addFilter: addFilter, dismiss: dismiss, tool: Tools.lastLetterTool)
                    ToolPickerRowItem(addFilter: addFilter, dismiss: dismiss, tool: Tools.endingStringTool)
                }
                
                Section(header: Text("Search by letters")) {
                    ToolPickerRowItem(addFilter: addFilter, dismiss: dismiss, tool: Tools.containsOnlyTool)
                    ToolPickerRowItem(addFilter: addFilter, dismiss: dismiss, tool: Tools.containsAtLeastTool)
                    ToolPickerRowItem(addFilter: addFilter, dismiss: dismiss, tool: Tools.containsQuantitiesTool)
                }
                
                Section(header: Text("Search by length")) {
                    ToolPickerRowItem(addFilter: addFilter, dismiss: dismiss, tool: Tools.wordLengthTool)
                    ToolPickerRowItem(addFilter: addFilter, dismiss: dismiss, tool: Tools.wordLengthRangeTool)
                }
            }
            .navigationTitle("Select Tool")
            .toolbar {
                // Cancel
                ToolbarItem() {
                    Button(action: { dismiss() }) {
                        Text("Cancel")
                    }
                }
            }
        }
    }
}

struct ToolPickerRowItem: View {
    
    var addFilter: (Tool, AggregateInput) -> Void
    var dismiss: DismissAction
    var tool: Tool
    
    var body: some View {
        NavigationLink(destination: ToolFilterView(dismiss: dismiss, tool: tool, addFilter: addFilter)) {
            HStack {
                Image(systemName: tool.symbolName ?? "doc.text.magnifyingglass")
                    .foregroundColor(.accentColor)
                    .font(.title2)
                .frame(width: 30, height: 50, alignment: .center)
                VStack(alignment: .leading) {
                    Text(tool.shortName)
                    Text(tool.shortDescription)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ToolPickerView_Previews: PreviewProvider {
    static var previews: some View {
        ToolPickerView(addFilter: {_, _ in})
    }
}
