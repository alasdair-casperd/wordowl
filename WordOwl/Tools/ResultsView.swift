//
//  ResultsView.swift
//  WordOwl
//
//  Created by Alasdair Casperd on 18/01/2022.
//

import SwiftUI

struct ResultsView: View {
    
    var results: [String]
    
    var filters: [Filter]
    var dictionary: Dictionary
    var sorting: Sorting
    var resultDetailType: ResultDetailType
    
    @State private var showingExporter = false
    @State private var showingChecklistView = false
    @State private var textToExport = ""
    
    var compoundSearch: Bool {
        return filters.count > 1
    }
    
    var body: some View {
        ScrollViewReader { scroller in
            Form {
                if compoundSearch {
                    Section(header: Text("Filters")) {
                        
                        ForEach(filters) { filter in
                            DetailsPair(parameter: filter.tool.shortName + (filter.inverted ? " (Inverted)" : ""), value: filter.inputDescription)
                        }
                    }
                }
                
                Section(header: Text("Search Details")) {
                    
                    if !compoundSearch {
                        DetailsPair(parameter: "Tool", value: filters[0].tool.shortName + (filters[0].inverted ? " (Inverted)" : ""))
                    }
                    DetailsPair(parameter: "Dictionary", value: dictionary.shortName)
                    
                    if !compoundSearch {
                        DetailsPair(parameter: filters[0].tool.promptName, value: filters[0].inputDescription)
                        ToolResultsDetailsView(tool: filters[0].tool, aggregateInput: filters[0].aggregateInput)
                    }
                }
                
                PageResultsView(results: results, resultDetailType: resultDetailType, scrollToTop: {scroller.scrollTo(0, anchor: .bottom)}, showingChecklistView: $showingChecklistView, textToExport: $textToExport)
            }
            .navigationTitle("Results")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    if #available(iOS 16.0, *) {
                        ShareLink(item: textToExport) {
                            Label("Export", systemImage: "square.and.arrow.up")
                        }
                    } else {
                        Button(action: {showShareSheet()})  {
                            Label("Export", systemImage: "square.and.arrow.up")
                        }
                    }
                }
            }
        }
    }

    private func showShareSheet() {
        let text = textToExport
        let activityVC = UIActivityViewController(activityItems: [text], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)
    }

    private func copyToClipboard() {
        let pasteboard = UIPasteboard.general
        pasteboard.string = textToExport
    }
}

struct ResultsView_Previews: PreviewProvider {
    
    static var previews: some View {
        NavigationView {
            ResultsView(
                results: Dictionary.testWords(13),
                filters: ToolList.exampleSimpleSearch(),
                dictionary: Dictionary.mainDictionaries[0],
                sorting: Sorting.randomly,
                resultDetailType: ResultDetailType.allResultDetailTypes[1])
        }
    }
}
