//
//  ToolsView.swift
//  WordOwl
//
//  Created by Alasdair Casperd on 17/01/2022.
//

import SwiftUI
import StoreKit

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
            .overlay {
                if #available(iOS 16, *) {
                    AskForReviewView()
                }
            }
            .navigationTitle("Search")
        }
    }
}

@available(iOS 16.0, *)
struct AskForReviewView: View {
    @Environment(\.requestReview) var requestReview
    var body: some View {
        VStack {}
            .onAppear {
                print(UserDefaults.standard.integer(forKey: "totalSearches"))
                let reviewKey = "userHasBeenAskedForReview"
                if !UserDefaults.standard.bool(forKey: reviewKey) && UserDefaults.standard.integer(forKey: "totalSearches") > 4 {
                    UserDefaults.standard.set(true, forKey: reviewKey)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                        requestReview()
                    }
                }
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
            if iPadVersion {
                Text(tool.shortName)                
            }
            else {
                Text(tool.shortName)
                Text(tool.shortDescription)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .icon(tool.symbolName ?? "magnifyingglass", color: simpleIcons ? .accentColor : tool.color, style: simpleIcons ? (iPadVersion ? .small : .large) : (iPadVersion ? .smallBold : .bold))
        .onAppear {
            simpleIcons = UserDefaults.standard.bool(forKey: SettingsView.simpleIconsKey)
        }
    }
}
