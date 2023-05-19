//
//  HelpButton.swift
//  WordOwl
//
//  Created by Alasdair Casperd on 16/05/2023.
//

import SwiftUI

struct HelpButton: View {
    
    var document: Document
    var suffix: String = ""
    
    @State private var showingHelpSheet = false
    @State private var hiding = UserDefaults.standard.bool(forKey: "hideHelpButtons")
    var body: some View {
            
        VStack {
            if !hiding {
                Button(action: {showingHelpSheet.toggle()}) {
                    Image(systemName: "questionmark.circle")
                }
                .sheet(isPresented: $showingHelpSheet) {
                    NavigationView {
                        DocumentView(document: document)
                        .navigationTitle(document.name + suffix)
                        .navigationBarTitleDisplayMode((document.name + suffix).count > 20 ? .inline : .large)
                        .toolbar {
                            ToolbarItem() {
                                Button("Done") {
                                    showingHelpSheet = false
                                }
                            }
                        }
                    }
                    .navigationViewStyle(.stack)
                }
            }
            else {
                EmptyView()
            }
        }
        .onAppear {
            hiding = UserDefaults.standard.bool(forKey: "hideHelpButtons")
        }
    }
}

struct HelpButton_Previews: PreviewProvider {
    static var previews: some View {
        HelpButton(document: .anagramsGuide, suffix: " Guide")
    }
}
