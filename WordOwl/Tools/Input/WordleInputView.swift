//
//  WordleInputView.swift
//  WordOwl
//
//  Created by Alasdair Casperd on 21/05/2023.
//

import SwiftUI
import Combine

struct WordleInputView: View {
    
    var tool: Tool
    @ObservedObject var aggregateInput: AggregateInput
    
    @State private var words = ["", "", "", "", "", ""]
    
    func showTextField(_ i: Int) -> Bool {
        if i == 0 {
            return true
        }
        else {
            return (words[i-1] != "") || words[i] != ""
        }
    }
    
    func ordinalFor(_ i: Int) -> String {
        switch i {
        case 0:
            return "first"
        case 1:
            return "second"
        case 2:
            return "third"
        case 3:
            return "fourth"
        case 4:
            return "fifth"
        case 5:
            return "sixth"
        default:
            return "\(i)"
        }
    }
    
    func letterAt(_ i: Int, _ j: Int) -> String? {
        if j < words[i].count {
            return words[i][j].uppercased()
        }
        else {
            return nil
        }
    }
    
    var inputsEmpty: Bool {
        var output = true
        for word in words {
            if word != "" {
                output = false
            }
        }
        return output
    }
    
    var body: some View {
        Section {
            ForEach(0...(words.count-1), id: \.self) { i in
                if showTextField(i){
                    TextField("Enter \(ordinalFor(i)) guess...", text: $words[i])
                        .onReceive(Just(aggregateInput.inputStrings[0])) { _ in
                            if (words[i].count > 5) {
                                words[i] = String(words[i].prefix(5))
                            }
                            if (words[i].letters != words[i]) {
                                words[i] = words[i].letters
                            }
                        }
                        .onChange(of: words[i]) { _ in
                            if words[i].count < 5 {
                                for j in (words[i].count)...5 {
                                    aggregateInput.inputInts[5*i+j+1] = 1
                                }
                            }
                            aggregateInput.inputStrings[i] = words[i]
                        }
//                        .icon("\(i+1).circle")
                        .disableAutocorrection(true)
                        .keyboardType(.alphabet)
                }
            }
        } header: {
            ToolInstructionsView(tool: tool)
        }
        if !inputsEmpty {
            Section {
                VStack(spacing: 14) {
                    ForEach(0...5, id: \.self) { i in
                        if showTextField(i) && words[i] != "" {
                            HStack(spacing: 14) {
                                ForEach(0...4, id: \.self) { j in
                                    HStack {
                                        Spacer()
                                        if let l = letterAt(i,j) {
                                            Text(l)
                                        } else {
                                            Text("?")
                                                .foregroundColor(.secondary)
                                        }
                                        Spacer()
                                    }
                                    .font(.body.weight(.medium))
                                    .padding(.vertical)
                                    .background {
                                        RoundedRectangle(cornerRadius: 8)
                                            .foregroundColor(aggregateInput.inputInts[5*i+j+1] == 0 ? .green : (aggregateInput.inputInts[5*i+j+1] == 1 ? .backgroundColor : .yellow))
                                    }
                                    .onTapGesture {
                                        if letterAt(i,j) != nil {
                                            aggregateInput.inputInts[5*i+j+1] = (aggregateInput.inputInts[5*i+j+1] + 1) % 3
                                            HapticsController.performHaptic(.light)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            } header: {
                Text("Square Colours")
            } footer: {
                Text("Tap a square to change its colour.")
            }
        }
    }
}

struct WordleInputView_Previews: PreviewProvider {
    static var previews: some View {
        ToolView(tool: .wordleSolver, selectedSorting: .alphabetically, selectedResultDetailType: .none)
    }
}
