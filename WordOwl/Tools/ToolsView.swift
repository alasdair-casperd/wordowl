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
    
    @State private var defaultSorting = Sortings.list[UserDefaults.standard.integer(forKey: "selectedSorting")]
    @State private var defaultResultDetailType = ResultDetailTypes.list[UserDefaults.standard.integer(forKey: "selectedResultDetailType")]
    
    var body: some View {
        NavigationLink(destination: ToolView(tool: tool, selectedSorting: defaultSorting, selectedResultDetailType: defaultResultDetailType)) {
            ToolRowItem(tool: tool)
        }
        .onAppear {
            defaultSorting = Sortings.list[UserDefaults.standard.integer(forKey: "selectedSorting")]
            defaultResultDetailType = ResultDetailTypes.list[UserDefaults.standard.integer(forKey: "selectedResultDetailType")]
        }
    }
}

struct ToolRowItem: View {
        
    var tool: Tool
    
    @State private var simpleIcons = false
        
    var background: some View {
        RoundedRectangle(cornerRadius: 10)
            .foregroundColor(tool.color)
            .frame(width: 40, height: 40, alignment: .center)
    }
    
    @State private var defaultSorting = Sortings.list[UserDefaults.standard.integer(forKey: "selectedSorting")]
    @State private var defaultResultDetailType = ResultDetailTypes.list[UserDefaults.standard.integer(forKey: "selectedResultDetailType")]
    
    var body: some View {
        
        HStack {
            Image(systemName: tool.symbolName ?? "doc.text.magnifyingglass")
                .foregroundColor(!simpleIcons ? .white : .accentColor)
                .font(.title2)
                .background {
                    if !simpleIcons {
                        background
                    }
                }
            .frame(width: 30, height: 50, alignment: .center)
            .padding(.trailing, !simpleIcons ? 12 : 8)
            VStack(alignment: .leading) {
                Text(tool.shortName)
                Text(tool.shortDescription)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .onAppear {
            simpleIcons = UserDefaults.standard.bool(forKey: SettingsView.simpleIconsKey)
        }
    }
}
