
import SwiftUI

struct NumberInputView: View {
    
    var tool: Tool
    @ObservedObject var aggregateInput: AggregateInput
    
    var body: some View {
        Stepper((tool.prompt.isEmpty ? "" : "\(tool.prompt[0]) ") + "\(aggregateInput.i)", value: $aggregateInput.inputInts[0], in: 1...45)
    }
    
}
