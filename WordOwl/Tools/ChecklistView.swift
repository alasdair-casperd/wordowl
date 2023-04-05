//
//  ChecklistView.swift
//  WordOwl
//
//  Created by Alasdair Casperd on 18/02/2022.
//

import SwiftUI

struct ChecklistView: View {
    
    var results: [String]
    @State private var storedSelections: [String: Bool] = [String: Bool]()
    
    func isSelected(_ result: String) -> Bool {
        if let storedBool = storedSelections[result] { return storedBool }
        else {
            storedSelections[result] = false
            return false
        }
    }
    
    func setUniversalSelection(_ value: Bool) {
        for result in results {
            storedSelections[result] = value
        }
    }
    
    func performHaptic(_ style: UIImpactFeedbackGenerator.FeedbackStyle = .rigid) {
        let impactMed = UIImpactFeedbackGenerator(style: style)
        impactMed.impactOccurred()
    }
    
    var body: some View {
        
        Section(header: Text("Checklist Options")) {
            Button(action: {setUniversalSelection(true); performHaptic(.heavy)}) {
                Label("Select All", systemImage: "checkmark.circle")
                    .accentColor(.green)
            }
            Button(action: {setUniversalSelection(false); performHaptic(.heavy)}) {
                Label("Deselect All", systemImage: "xmark.circle")
                    .accentColor(.red)
            }
        }
        Section(header: Text("\(results.count) Search Results")) {
            ForEach(results, id: \.self) { result in
                HStack {
                    Image(systemName: self.isSelected(result) ? "checkmark.circle.fill" : "circle")
                        .foregroundColor(isSelected(result) ? .green : .secondary)
                    Text(result.capitalizingFirstLetter())
                        .foregroundColor(isSelected(result) ? .primary : .secondary)
                    Spacer()
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    performHaptic(.medium)
                    if self.isSelected(result) {
                        storedSelections[result] = false
                    }
                    else {
                        storedSelections[result] = true
                    }
                }
            }
        }
        
    }
}

struct ChecklistView_Previews: PreviewProvider {
    static var previews: some View {
        Form {
            ChecklistView(results: Dictionary.mainDictionaries[1].words)
        }
    }
}
