//
//  ToolList.swift
//  WordOwl
//
//  Created by Alasdair Casperd on 03/04/2023.
//

import Foundation

class ToolList: ObservableObject {
    
    static func exampleSimpleSearch() -> [Filter] {
        let aggregateInput = AggregateInput()
        aggregateInput.x = "bling"
        return [Filter(id: UUID(), tool: Tool.containsStringTool, aggregateInput: aggregateInput, inverted: false)]
    }
    
    func newFilter() {
        let newFilter =
            Filter(
                id: UUID(),
                tool: Tool.lastLetterTool,
                aggregateInput: AggregateInput()
            )
        filters.append(newFilter)
    }
    
    func addFilter(filter newFilter: Filter) {
        var added = false
        for i in 0..<filters.count {
            if filters[i].id == newFilter.id {
                filters[i] = newFilter
                added = true
            }
        }
        if !added {
            filters.append(newFilter)
        }
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
