//
//  ToolsView.swift
//  WordOwl
//
//  Created by Alasdair Casperd on 17/01/2022.
//

import SwiftUI

struct ToolsView: View {
    
    static let icon = "magnifyingglass"
    
    @State private var iconStyle = 0
    
    var body: some View {
        NavigationView {
            List {
                ForEach(Tool.categories) { category in
                    Section {
                        ForEach(category.tools) { tool in
                            SimpleSearchToolRowItem(tool: tool)
                        }                        
                    } header: {
                        Text(category.name)
                    }
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

struct SimpleSearchToolRowItem: View {
        
    var tool: Tool
    
    @State private var defaultSorting = Sorting.allSortings[UserDefaults.standard.integer(forKey: "selectedSorting")]
    @State private var defaultResultDetailType = ResultDetailType.allResultDetailTypes[UserDefaults.standard.integer(forKey: "selectedResultDetailType")]
    
    var body: some View {
        NavigationLink(destination: ToolView(tool: tool, selectedSorting: defaultSorting, selectedResultDetailType: defaultResultDetailType)) {
            ToolRowItem(tool: tool)
        }
        .onAppear {
            defaultSorting = Sorting.allSortings[UserDefaults.standard.integer(forKey: "selectedSorting")]
            defaultResultDetailType = ResultDetailType.allResultDetailTypes[UserDefaults.standard.integer(forKey: "selectedResultDetailType")]
        }
    }
}

struct ToolRowItem: View {
        
    var tool: Tool
    
    @State private var simpleIcons = false
    
    @State private var defaultSorting = Sorting.allSortings[UserDefaults.standard.integer(forKey: "selectedSorting")]
    @State private var defaultResultDetailType = ResultDetailType.allResultDetailTypes[UserDefaults.standard.integer(forKey: "selectedResultDetailType")]
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text(tool.shortName)
            Text(tool.shortDescription)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .icon(tool.symbolName ?? "magnifyingglass", color: simpleIcons ? .accentColor : tool.color, style: simpleIcons ? .large : .bold)
        .onAppear {
            simpleIcons = UserDefaults.standard.bool(forKey: SettingsView.simpleIconsKey)
        }
    }
}
