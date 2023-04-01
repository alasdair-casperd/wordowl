//
//  DocumentView.swift
//  WordOwl
//
//  Created by Alasdair Casperd on 01/04/2023.
//

import SwiftUI

struct DocumentView: View {
    
    var document: Document
    
    var scroller: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                ForEach(document.items) { item in
                    DocumentItemView(item: item)
                }
                Spacer()
            }
            .padding()
        }
        .background {
            Color.backgroundColor
                .edgesIgnoringSafeArea(.all)
        }
        .navigationTitle(document.name)
    }
    
    var body: some View {
        if #available(iOS 16.0, *) {
            scroller
                .scrollIndicators(.hidden)
        } else {
            scroller
        }
    }
}

struct DocumentItemView: View {
    
    var item: Document.Item
    
    var body: some View {
        switch item.type {
        case .header:
            Text(item.text ?? "Missing Header")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top)
        case .tool:
            if let tool = item.tool {
                ToolRowItem(tool: tool)
                    .panelled()
            }
            else {
                Text("Missing Tool")
            }
        case .paragraph:
            Text(item.text ?? "Missing paragraph text.")
        case .image:
            if let image = item.image {
                image
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(14)
                    .shadow(color: .black.opacity(0.2), radius: 7)
                    .padding(.top)
            }
            else {
                Text("Missing Image")
            }
        case .filter:
            Group {
                if let filter = item.filter {
                    VStack{
                        DetailsPair(parameter: filter.tool.promptName, value: styledAggregateInput(filter.aggregateInput, tool: filter.tool))
                        ToolResultsDetailsView(tool: filter.tool, aggregateInput: filter.aggregateInput)
                    }
                }
                else {
                    Text("Missing search filter.")
                }
            }
            .panelled()
        case .filterList:
            Text("Work in Progress")
        case .results:
            VStack(alignment: .leading) {
                Text("Search Results")
                    .textCase(.uppercase)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding(.leading)
                
                if let results = item.results {
                    VStack(alignment: .leading){
                        ForEach(results, id: \.self) { result in
                            Text(result)
                            Divider()
                        }
                        Text("...")
                    }
                    .panelled()
                    .mask {
                        LinearGradient(colors: [Color.black, Color.clear], startPoint: UnitPoint(x: 0.5, y: 0.5), endPoint: .bottom)
                    }
                }
                else {
                    Text("Missing search results.")
                        .panelled()
                }
            }
        case .continuedResults:
            Text("Work in Progress")
        }
    }
}

struct DocumentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DocumentView(document: Document.crosswordSolverGuide)
        }
    }
}
