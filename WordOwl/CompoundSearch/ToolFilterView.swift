//
//  ToolFilterView.swift
//  WordOwl
//
//  Created by Alasdair Casperd on 23/02/2022.
//
//
// Used to confugure a filter used in a compound search

import SwiftUI

struct ToolFilterView: View {
    
    var id: UUID = UUID()
    var dismiss: () -> ()
    var buttonText = "Add"
    var tool: Tool    
    var preloadingFilter: Filter? = nil
    @State private var filterLoaded = false // used to prevent overriding filter again when navigating back to this view
    
    @StateObject var aggregateInput: AggregateInput = AggregateInput()
    @State var inverted: Bool = false
    var addFilter: (Filter) -> ()
    
    @State private var showingWarning = false
    @State private var showingHelpSheet = false
    
    var body: some View {
        Form {
            ToolInputView(tool: tool, aggregateInput: aggregateInput)
            ToolSettingsView(tool: tool, aggregateInput: aggregateInput)
            if (
                tool == Tool.anagramsTool
                || tool == Tool.containsStringTool
                || tool == Tool.crosswordSolver
                || tool == Tool.endingStringTool
                || tool == Tool.firstLetterTool
                || tool == Tool.lastLetterTool
                || tool == Tool.startingStringTool
                || tool == Tool.wordLengthRangeTool
                || tool == Tool.wordLengthTool
                || tool == Tool.matchesPatternTool
            ) {
                Section(header: Text("Further Options"), footer: Text("Inverted filters return the opposite of their usual results.")) {
                    Toggle("Invert Filter", isOn: $inverted)
                }
            }
        }        
        .onAppear {
            if let filter = preloadingFilter {
                if !filterLoaded {
                    print("Preloading Filter")
                    aggregateInput.inputInts = filter.aggregateInput.inputInts
                    aggregateInput.inputBools = filter.aggregateInput.inputBools
                    aggregateInput.inputStrings = filter.aggregateInput.inputStrings
                    aggregateInput.inputCharacters = filter.aggregateInput.inputCharacters
                    inverted = filter.inverted
                    filterLoaded = true
                }
            }
        }
        .navigationTitle(tool.shortName)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            
            // Help Button
            
            ToolbarItem() {
                if let guide = Document.documentForTool(tool) {
                    HelpButton(document: guide, suffix: " Guide")
                }
            }
            
            // Add Button
            
            ToolbarItem() {
                Button(action: {addFilter(Filter(id: id, tool: tool, aggregateInput: aggregateInput, inverted: inverted)); dismiss()}) {
                    Text(buttonText)
                        .disabled(doneDisabled)
                }
            }
        }
    }
    
    // Is the search valid?
    
    var doneDisabled: Bool {
        get {
            switch tool.input {
            case .string:
                return aggregateInput.inputStrings[0] == ""
            case .spaces:
                var output = aggregateInput.inputStrings[9] != ""
                for i in 1...(aggregateInput.i) {
                    output = output || aggregateInput.inputStrings[i-1] != ""
                }
                return !output
            case .multipleCharacters:
                return aggregateInput.styledFor(tool: tool) == "None"
            case .characterQuantities:
                return aggregateInput.styledFor(tool: tool) == "None"
            case .code:
                return aggregateInput.inputStrings[0] == ""
            default:
                return false
            }
        }
    }
}

//struct ToolFilterView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//            ToolFilterView(tool: Tools.lastLetterTool)
//        }
//    }
//}
