//
//  ToolList.swift
//  WordOwl
//
//  Created by Alasdair Casperd on 19/06/2022.
//

import Foundation

class ToolList: ObservableObject {
    
    struct Filter: Identifiable, Equatable {
        static func == (lhs: ToolList.Filter, rhs: ToolList.Filter) -> Bool {
            return lhs.id == rhs.id
        }
        
        var id: UUID
        var tool: Tool
        var aggregateInput: AggregateInput
    }
    
    func newFilter() {
        let newFilter =
            Filter(
                id: UUID(),
                tool: Tools.lastLetterTool,
                aggregateInput: AggregateInput()
            )
        filters.append(newFilter)
    }
    
    func addFilter(tool: Tool, aggregateInput: AggregateInput) {
        let newFilter =
            Filter(
                id: UUID(),
                tool: tool,
                aggregateInput: aggregateInput
            )
        filters.append(newFilter)
    }
    
    func deleteFilters(at offsets: IndexSet) {
        filters.remove(atOffsets: offsets)
    }
    
    func moveFilter(from source: IndexSet, to destination: Int) {
        filters.move(fromOffsets: source, toOffset: destination)
    }
    
    @Published var filters: [Filter]
    
    init() {
        filters = [Filter]()
    }
}
