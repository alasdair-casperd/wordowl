
import SwiftUI
import Combine

struct CharacterInputView: View {
    
    var tool: Tool
    @ObservedObject var aggregateInput: AggregateInput
    
    @State private var usingWheelInput = true
    
    var body: some View {
        Section {
            Group {
                if usingWheelInput {
                    Picker("Pick a character", selection: $aggregateInput.inputCharacters[0]) {
                        ForEach(EnglishAlphabet.allCases, id: \.self) { letter in
                            Text(letter.rawValue).tag(letter)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                }
                else {
                    TextField(tool.prompt[1], text: $aggregateInput.inputStrings[0])
                        .disableAutocorrection(true)
                        .keyboardType(.alphabet)
                        .onReceive(Just(aggregateInput.inputStrings[0])) { _ in
                            if (aggregateInput.x.count > 1) {
                                aggregateInput.x = String(aggregateInput.x.prefix(1))
                            }
                            if (aggregateInput.x.letters != aggregateInput.x) {
                                aggregateInput.x = aggregateInput.x.letters
                            }
                        }
                }
            }
            .onAppear {
                if UserDefaults.standard.object(forKey: "wheelCharacterInput") != nil {
                    usingWheelInput = UserDefaults.standard.bool(forKey: "wheelCharacterInput")
                }
                else {
                    usingWheelInput = true
                }
                if (!usingWheelInput) { aggregateInput.x = "" }
            }
        } header: {
            ToolInstructionsView(tool: tool)
        }
    }
    
}
