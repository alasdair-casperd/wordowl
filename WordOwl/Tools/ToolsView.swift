//
//  ToolsView.swift
//  WordOwl
//
//  Created by Alasdair Casperd on 17/01/2022.
//

import SwiftUI

struct ToolsView: View {
    
    var body: some View {
        NavigationView {
            Form {
                
                Section(header: Text("Common tools")) {
                    ToolRowItem(tool: Tools.anagramsTool)
                    ToolRowItem(tool: Tools.crosswordSolver)
                    ToolRowItem(tool: Tools.containsStringTool)
                }
                
                Section(header: Text("Search by start")) {
                    ToolRowItem(tool: Tools.firstLetterTool)
                    ToolRowItem(tool: Tools.startingStringTool)
                }
                Section(header: Text("Search by end")) {
                    ToolRowItem(tool: Tools.lastLetterTool)
                    ToolRowItem(tool: Tools.endingStringTool)
                }
                
                Section(header: Text("Search by letters")) {
                    ToolRowItem(tool: Tools.containsOnlyTool)
                    ToolRowItem(tool: Tools.containsAtLeastTool)
                    ToolRowItem(tool: Tools.containsQuantitiesTool)
                }
                
                Section(header: Text("Search by length")) {
                    ToolRowItem(tool: Tools.wordLengthTool)
                    ToolRowItem(tool: Tools.wordLengthRangeTool)
                }
            }
            .navigationTitle("Search")
        }
    }
}

struct ToolsView_Previews: PreviewProvider {
    static var previews: some View {
        ToolsView()
    }
}


struct ToolRowItem: View {
    
    var tool: Tool
    
    @State private var defaultSorting = Sortings.list[UserDefaults.standard.integer(forKey: "selectedSorting")]
    @State private var defaultResultDetailType = ResultDetailTypes.list[UserDefaults.standard.integer(forKey: "selectedResultDetailType")]
    
    var body: some View {
        NavigationLink(destination: ToolView(tool: tool, selectedSorting: defaultSorting, selectedResultDetailType: defaultResultDetailType)) {
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
        .onAppear {
            defaultSorting = Sortings.list[UserDefaults.standard.integer(forKey: "selectedSorting")]
            defaultResultDetailType = ResultDetailTypes.list[UserDefaults.standard.integer(forKey: "selectedResultDetailType")]
        }
    }
}
