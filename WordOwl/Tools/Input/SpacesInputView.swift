
import SwiftUI
import Combine

struct SpacesInputView: View {
    
    var tool: Tool
    @ObservedObject var aggregateInput: AggregateInput
    @State private var historicalinputStrings = Array(repeating: "", count: 45)
    @FocusState private var textFieldFocused: Int?
    
    @State private var usingVisualInput = true
    
    var body: some View {
        Group {
            if aggregateInput.i < 9 && usingVisualInput {
                HStack {
                    ForEach((1...aggregateInput.i), id: \.self) { i in
                        TextField(tool.prompt[1], text: $aggregateInput.inputStrings[i-1])
                            .disableAutocorrection(true)
                            .autocapitalization(UITextAutocapitalizationType.allCharacters)
                            .textFieldStyle(CompactTextFieldStyle())
                            .multilineTextAlignment(.center)
                            .focused($textFieldFocused, equals: i)
                            .onReceive(Just(aggregateInput.inputStrings[i-1])) { (newValue: String) in
                                
                                let oldValue = historicalinputStrings[i-1]
                                
                                if oldValue != newValue {
                                    
                                    if String(oldValue.prefix(1)) != String(newValue.prefix(1)) {
                                        aggregateInput.inputStrings[i-1] = String(newValue.prefix(1)).letters.uppercased()
                                    }
                                    else {
                                        aggregateInput.inputStrings[i-1] = String(newValue.suffix(1)).letters.uppercased()
                                    }
                                    if (newValue.count > 0) {
                                        if(textFieldFocused == aggregateInput.inputInts[0]) {
                                            textFieldFocused = nil
                                        }
                                        else {
                                            textFieldFocused = (textFieldFocused ?? 0) + 1
                                        }
                                    }
                                    historicalinputStrings[i-1] = aggregateInput.inputStrings[i-1]
                                    
                                }
                            }
                    }
                }
            }
            else {
                if (usingVisualInput) {
                    TextField("e.g. \"c?o?swo?d\"", text: $aggregateInput.inputStrings[9])
                        .textFieldStyle(CompactPaddedTextFieldStyle())
                        .onReceive(Just(aggregateInput.inputStrings[0])) { _ in
                            if (aggregateInput.inputStrings[9].count > 45) {
                                aggregateInput.inputStrings[9] = String(aggregateInput.inputStrings[9].prefix(45))
                            }
                            print(aggregateInput.inputStrings[9])
                            print(aggregateInput.inputStrings[9].lettersOrQuestion)
                            if (aggregateInput.inputStrings[9].lettersOrQuestion != aggregateInput.inputStrings[9]) {
                                aggregateInput.inputStrings[9] = aggregateInput.inputStrings[9].lettersOrQuestion
                            }
                        }
                }
                else {
                    TextField("e.g. \"c?o?swo?d\"", text: $aggregateInput.inputStrings[9])
                        .onReceive(Just(aggregateInput.inputStrings[0])) { _ in
                            if (aggregateInput.inputStrings[9].count > 45) {
                                aggregateInput.inputStrings[9] = String(aggregateInput.inputStrings[9].prefix(45))
                            }
                            if (aggregateInput.inputStrings[9].lettersOrQuestion != aggregateInput.inputStrings[9]) {
                                aggregateInput.inputStrings[9] = aggregateInput.inputStrings[9].lettersOrQuestion
                            }
                        }
                }
            }
            if (usingVisualInput) {
                Stepper{
                    Text(tool.prompt[0])
                } onIncrement: {
                    if aggregateInput.i == 8 {
                        aggregateInput.inputStrings[9] = ""
                    }
                    aggregateInput.i += 1
                    aggregateInput.i = min(aggregateInput.i, 9)
                } onDecrement: {
                    if aggregateInput.i == 9 {
                        aggregateInput.inputStrings[9] = ""
                    }
                    aggregateInput.i -= 1
                    aggregateInput.i = max(aggregateInput.i, 2)
                }
            }
        }
        .onAppear {
            if UserDefaults.standard.object(forKey: "visualInput") != nil {
                usingVisualInput = UserDefaults.standard.bool(forKey: "visualInput")
            }
            else {
                usingVisualInput = true
            }
            if (!usingVisualInput) { aggregateInput.inputStrings[9] = "" }
        }
    }
}
