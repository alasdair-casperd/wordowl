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
    
    var dismiss: DismissAction
                    
    @StateObject var aggregateInput: AggregateInput = AggregateInput()
    @State var tool: Tool
    
    var addFilter: (Tool, AggregateInput) -> Void
    
    @State private var showingWarning = false
    
    var body: some View {
        ZStack {
            Form {
                Section(footer: Text(tool.description)) {
                    ToolInputView(tool: tool, aggregateInput: aggregateInput)
                }
                
                ToolSettingsView(tool: tool, aggregateInput: aggregateInput)
                
                // Done button
                /*
                Section {
                    HStack {
                        Spacer()
                        Button("Add") { dismiss() }
                        .disabled(doneDisabled)
                        .alert("No Words Found", isPresented: $showingWarning) {
                            Button("Ok", role: .cancel) { }
                        }
                        Spacer()
                    }
                }
                */
            }
        }
        .navigationTitle(tool.shortName)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            
            // Add to the current compound search
            
            ToolbarItem() {
                Button(action: {addFilter(tool, aggregateInput); dismiss()}) {
                    Text("Add")
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
                return styledAggregateInput(aggregateInput, tool: tool) == "None"
            case .characterQuantities:
                return styledAggregateInput(aggregateInput, tool: Tools.containsOnlyTool) == "None"
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
