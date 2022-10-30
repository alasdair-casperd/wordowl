
import SwiftUI
import Combine

struct StringInputView: View {
    
    var tool: Tool
    @ObservedObject var aggregateInput: AggregateInput
    
    var body: some View {        
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
    }
    
}
