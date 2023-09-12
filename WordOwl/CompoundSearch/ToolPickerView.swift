//
//  ToolPickerView.swift
//  WordOwl
//
//  Created by Alasdair Casperd on 19/06/2022.
//

import SwiftUI

struct ToolPickerView: View {
    
    // Closure called when finished
    var addFilter: (Filter) -> Void
    
    @Environment(\.presentationMode) var presentationMode
    
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
    
    @State private var colorful = true
    
    var body: some View {
        NavigationView {
            Form {
                ForEach(Tool.categories) { category in
                    if category.compoundable {
                        Section {
                            ForEach(category.tools) { tool in
                                if tool.compoundable {
                                    ToolPickerRowItem(addFilter: addFilter, dismiss: dismiss, tool: tool)
                                }
                            }
                        } header: {
                            Text(category.name)
                        }
                    }
                }
            }
            .navigationTitle("Select Tool")
            .toolbar {
                // Cancel
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { dismiss() }) {
                        Text("Cancel")
                    }
                }
            }
            .onAppear {
                colorful = UserDefaults.standard.bool(forKey: "colorfulIcons")
            }            
        }
    }
}

struct ToolPickerRowItem: View {
    
    var addFilter: (Filter) -> Void
    var dismiss: () -> ()
    
    var tool: Tool
    
    var body: some View {
        NavigationLink(destination: ToolFilterView(dismiss: dismiss, tool: tool, addFilter: addFilter)) {
            ToolRowItem(tool: tool)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ToolPickerView_Previews: PreviewProvider {
    static var previews: some View {
        ToolPickerView(addFilter: {_ in})
    }
}
