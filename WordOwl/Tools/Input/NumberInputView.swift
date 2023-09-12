
import SwiftUI

struct NumberInputView: View {
    
    var tool: Tool
    @ObservedObject var aggregateInput: AggregateInput
    
    var body: some View {
        Section {
            Stepper((tool.prompt.isEmpty ? "" : "\(tool.prompt[0]) ") + "\(aggregateInput.i)", value: $aggregateInput.inputInts[0], in: 1...45)
        }  header: {
            ToolInstructionsView(tool: tool)
        }
    }
    
}
