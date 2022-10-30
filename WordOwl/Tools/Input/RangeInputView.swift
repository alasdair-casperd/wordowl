
import SwiftUI

struct RangeInputView: View {
    
    var tool: Tool
    @ObservedObject var aggregateInput: AggregateInput
    
    var body: some View {
        Stepper {
             Text((tool.prompt.isEmpty ? "" : "\(tool.prompt[0]) ")).foregroundColor(.secondary) + Text("\(aggregateInput.j)")
        } onIncrement: {
            if aggregateInput.j < 45 {
                aggregateInput.j += 1
                if aggregateInput.j > aggregateInput.i {
                    aggregateInput.i = aggregateInput.j
                }
            }
        } onDecrement: {
            if aggregateInput.j > 1 {
                aggregateInput.j -= 1
            }
        }
        Stepper {
            Text((tool.prompt.isEmpty ? "" : "\(tool.prompt[1]) ")).foregroundColor(.secondary) + Text("\(aggregateInput.i)")
        } onIncrement: {
            if aggregateInput.i < 45 {
                aggregateInput.i += 1
            }
        } onDecrement: {
            if aggregateInput.i > 1 {
                aggregateInput.i -= 1
                if aggregateInput.i < aggregateInput.j {
                    aggregateInput.j = aggregateInput.i
                }
            }
        }
    }
    
}
