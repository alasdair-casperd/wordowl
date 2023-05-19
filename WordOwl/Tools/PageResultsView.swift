//
//  PageResultsView.swift
//  WordOwl
//
//  Created by Alasdair Casperd on 02/04/2023.
//

import SwiftUI

struct PageResultsView: View {
    
    @Environment(\.openURL) var openURL
    
    static let resultsPerPage = 100;
    static let backToTopMinimum = 25;
    
    var results: [String]
    var resultDetailType: ResultDetailType
    var scrollToTop: () -> ()
    var canExport = true
    
    @Binding var showingChecklistView: Bool
    @Binding var textToExport: String
    
    @State private var currentPage = 0
    @State private var selections = [String: Bool]()
    
    @State private var showingDefinition = false
    @State private var wordToDefine = ""
    
    var canEnterChecklistView: Bool {
        return results.count < 500
    }
    
    var resultsOnPage: Int {
        return (min(((currentPage + 1) * PageResultsView.resultsPerPage - 1), results.count - 1)) - (currentPage * PageResultsView.resultsPerPage) + 1
    }
    
    private func selectAll() {
        HapticsController.performHaptic(.medium)
        for result in results {
            selections[result] = true
        }
        setTextToExport()
    }

    private func deselectAll(playHaptic: Bool = false) {
        if playHaptic {
            HapticsController.performHaptic(.medium)
        }
        for result in results {
            selections[result] = false
        }
        setTextToExport()
    }

    private func enterChecklistMode(_ result: String) {
        if canEnterChecklistView && !showingChecklistView {
            deselectAll()
            selections[result] = true
            withAnimation {
                showingChecklistView = true
            }
        }
        setTextToExport()
    }

    private func exitChecklistMode() {
        deselectAll()
        withAnimation {
            showingChecklistView = false
        }
        setTextToExport()
    }

    private func toggleSelectionOf(_ result: String) {
        if showingChecklistView {
            HapticsController.performHaptic(.medium)
            if selections[result] ?? false {
                selections[result] = false
            }
            else {
                selections[result] = true
            }
        }
        setTextToExport()
    }
    
    private func setTextToExport() {

        if canExport {
            var format: (String) -> String {
                let icon = UserDefaults.standard.string(forKey: "selectedExportStyling")
                if icon == "AA" {
                    return {word in return word.uppercased()}
                }
                if icon == "Aa" {
                    return {word in return word.capitalizingFirstLetter()}
                }
                if icon == "aa" {
                    return {word in return word.lowercased()}
                }
                else {
                    return {word in return word}
                }
            }

            let delimeter = UserDefaults.standard.bool(forKey: "addNewLines") ? "\n" : ", "

            var output = ""
            var first = true
            for result in results {
                if !showingChecklistView || (selections[result] ?? false) {
                    if !first {
                        output += delimeter
                    }
                    output += format(result)
                    first = false
                }
            }
            textToExport = output
        }
    }
    
    var body: some View {
        Section
        {
            if !results.isEmpty {
                ForEach(results[(currentPage * PageResultsView.resultsPerPage)...(min(((currentPage + 1) * PageResultsView.resultsPerPage - 1), results.count - 1))], id: \.self) {result in
                    HStack {
                        if (showingChecklistView) {
                            Image(systemName: self.selections[result] ?? false ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(selections[result] ?? false ? .green : .secondary)
                        }
                        Text(result.capitalized)
                            .foregroundColor(((selections[result] ?? false) || !showingChecklistView) ? .primary : .secondary)
                        Spacer()
                        Text(resultDetailType.detail(result))
                    }
                    .contentShape(Rectangle())
                    .onTapGesture { toggleSelectionOf(result)}
//                    .onLongPressGesture{ enterChecklistMode(result) }
                    .contextMenu {
                        if !showingChecklistView{
                            Button {
                                let pasteboard = UIPasteboard.general
                                pasteboard.string = result.capitalized
                            } label: {
                                Label("Copy", systemImage: "doc.on.doc")
                            }
                            if canEnterChecklistView {
                                Button {
                                    enterChecklistMode(result)
                                } label: {
                                    Label("Enter Checklist Mode", systemImage: "checkmark.circle")
                                }
                            }
                            Button {
                                if UIReferenceLibraryViewController.dictionaryHasDefinition(forTerm: result) {
                                    wordToDefine = result
                                    showingDefinition = true
                                }
                                else {
                                    openURL(URL(string: "https://www.google.com/search?q=" + result)!)
                                }
                            } label: {
                                Label("Define", systemImage: "text.magnifyingglass")
                            }
                        }
                        if showingChecklistView {
                            Button {
                                let pasteboard = UIPasteboard.general
                                pasteboard.string = textToExport
                            } label: {
                                Label("Copy Selections", systemImage: "doc.on.doc")
                            }
                            Button {
                                selectAll()
                            } label: {
                                Label("Select All", systemImage: "checkmark.circle")
                            }
                            Button {
                                deselectAll()
                            } label: {
                                Label("Deselect All", systemImage: "xmark.circle")
                            }
                            Button {
                                exitChecklistMode()
                            } label: {
                                Label("Exit Checklist Mode", systemImage: "arrow.left")
                            }
                        }
                    }
                }
            }
            else {
                Text("No Results Found")
                    .foregroundColor(.secondary)
            }
        } header: {
            Group {
                if results.count > PageResultsView.resultsPerPage {
                    PageController(resultCount: results.count, resultsPerPage: PageResultsView.resultsPerPage, currentPage: $currentPage)
                }
                else {
                    HStack {
                        Text("\(results.count) Search Results")
                        Spacer()
                        if showingChecklistView {
                            Button("Done", action: exitChecklistMode)
                                .textCase(.none)
                        }
                    }
                }
            }            
            .id(0)
        } footer: {
            if resultsOnPage > PageResultsView.backToTopMinimum {
                Button {
                    scrollToTop()
                } label: {
                    HStack {
                        Spacer()
                        Label("Back to Top", systemImage: "arrow.up")
                        Spacer()
                    }
                    .padding(.vertical)
                }
            }
        }
        .sheet(isPresented: $showingDefinition) {
            DefinitionView(word: $wordToDefine)
        }
        .onAppear {
            setTextToExport()
            wordToDefine = ""
        }
    }
}

struct PageController: View {
    
    var resultCount: Int
    var resultsPerPage: Int
    @Binding var currentPage: Int
    
    var firstResultOnPage: Int {
        return currentPage * resultsPerPage + 1
    }
    
    var lastResultOnPage: Int {
        return min((currentPage + 1) * resultsPerPage, resultCount)
    }
    
    var pages: Int {
        return Int(ceil((Double(resultCount) / Double(resultsPerPage))))
    }
    
    var resultsOnPage: Int {
        return (min(((currentPage + 1) * resultsPerPage - 1), resultCount - 1)) - (currentPage * resultsPerPage) + 1
    }
    
    var caption: String {
        if resultsOnPage > 1 {
            return "Showing \(firstResultOnPage) to \(lastResultOnPage) of \(resultCount) Results"
        }
        else {
            return "Showing Result \(firstResultOnPage) of \(resultCount)"
        }
    }
    
    private func performHaptic(_ style: UIImpactFeedbackGenerator.FeedbackStyle = .rigid) {
        let impactMed = UIImpactFeedbackGenerator(style: style)
        impactMed.impactOccurred()
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Page \(currentPage + 1) of \(pages)")
                    .foregroundColor(.primary)
                    .font(.headline)
                Text(caption)
            }
            Spacer()
            Button {
                currentPage -= 1
                HapticsController.performHaptic(.light)
            } label: {
                Image(systemName: "chevron.left")
            }
                .disabled(currentPage == 0)
                .buttonStyle(BorderedButtonStyle())
//                .frame(width: 80, alignment: .leading)
            Button {
                HapticsController.performHaptic(.light)
                currentPage += 1
            } label: {
                Image(systemName: "chevron.right")
            }
                .disabled(currentPage + 1 == pages)
                .buttonStyle(BorderedButtonStyle())
//                .frame(width: 80, alignment: .trailing)
        }
//        .padding(.horizontal, -14)
        .padding(.vertical)
        .textCase(.none)
    }
}

//struct PageResultsView_Previews: PreviewProvider {
//    static var previews: some View {
//        PageResultsView(results: Dictionaries.small.words, resultDetailType: ResultDetailTypes.none, scrollToTop: {}, )
//    }
//}
