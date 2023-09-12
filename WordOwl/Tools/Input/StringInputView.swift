
import SwiftUI
import Combine

struct StringInputView: View {
    
    var tool: Tool
    @ObservedObject var aggregateInput: AggregateInput
    
    var body: some View {        
        Section {
            TextField(tool.prompt[0], text: $aggregateInput.inputStrings[0])
                .onReceive(Just(aggregateInput.inputStrings[0])) { _ in
                    if (aggregateInput.x.count > 45) {
                        aggregateInput.x = String(aggregateInput.x.prefix(45))
                    }
                    if (aggregateInput.x.letters != aggregateInput.x) {
                        aggregateInput.x = aggregateInput.x.letters
                    }
                }
                .disableAutocorrection(true)
                .keyboardType(.alphabet)
        } header: {
            ToolInstructionsView(tool: tool)
        }
    }
    
}

struct CodeInputView: View {
    
    var tool: Tool
    @ObservedObject var aggregateInput: AggregateInput
    
    var body: some View {
        Section {
            TextField(tool.prompt[0], text: $aggregateInput.inputStrings[0])
    //            .font(.system(.body, design: .monospaced))
                .onReceive(Just(aggregateInput.inputStrings[0])) { _ in
                    if (aggregateInput.x.count > 45) {
                        aggregateInput.x = String(aggregateInput.x.prefix(45))
                    }
                }
                .disableAutocorrection(true)
                .keyboardType(.alphabet)
        } header: {
            ToolInstructionsView(tool: tool)
        }
    }
    
}

struct DoubleStringInputView: View {
    
    var tool: Tool
    @ObservedObject var aggregateInput: AggregateInput
    
    var body: some View {
        Section {
            TextField(tool.prompt[0], text: $aggregateInput.inputStrings[0])
                .onReceive(Just(aggregateInput.inputStrings[0])) { _ in
                    if (aggregateInput.x.count > 45) {
                        aggregateInput.x = String(aggregateInput.x.prefix(45))
                    }
                    if (aggregateInput.x.letters != aggregateInput.x) {
                        aggregateInput.x = aggregateInput.x.letters
                    }
                }
                .disableAutocorrection(true)
                .keyboardType(.alphabet)
            
            TextField(tool.prompt[1], text: $aggregateInput.inputStrings[1])
                .onReceive(Just(aggregateInput.inputStrings[1])) { _ in
                    if (aggregateInput.y.count > 45) {
                        aggregateInput.y = String(aggregateInput.x.prefix(45))
                    }
                    if (aggregateInput.y.letters != aggregateInput.y) {
                        aggregateInput.y = aggregateInput.y.letters
                    }
                }
                .disableAutocorrection(true)
                .keyboardType(.alphabet)
        } header: {
            ToolInstructionsView(tool: tool)
        }
    }
    
}
