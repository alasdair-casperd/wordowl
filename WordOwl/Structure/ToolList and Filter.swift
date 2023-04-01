//
//  ToolList.swift
//  WordOwl
//
//  Created by Alasdair Casperd on 19/06/2022.
//

import Foundation

struct Filter: Identifiable, Equatable {
    static func == (lhs: Filter, rhs: Filter) -> Bool {
        return lhs.id == rhs.id
        && lhs.tool == rhs.tool
        && lhs.aggregateInput == rhs.aggregateInput
        && lhs.inverted == rhs.inverted
    }
    var id: UUID
    var tool: Tool
    var aggregateInput: AggregateInput
    var inverted: Bool = false
    
    static func exampleAnagramsFilter() -> Filter {
        let aggregateInput = AggregateInput()
        aggregateInput.x = "triangle"
        return Filter(id: UUID(), tool: Tool.anagramsTool, aggregateInput: aggregateInput, inverted: false)
    }
    
    static func exampleCrosswordFilter() -> Filter {
        let aggregateInput = AggregateInput()
        aggregateInput.x = "g?a?e??"
        return Filter(id: UUID(), tool: Tool.crosswordSolver, aggregateInput: aggregateInput, inverted: false)
    }
    
    static func exampleContainsStringFilter() -> Filter {
        let aggregateInput = AggregateInput()
        aggregateInput.x = "canoe"
        return Filter(id: UUID(), tool: Tool.containsStringTool, aggregateInput: aggregateInput, inverted: false)
    }
    
    static func exampleFirstLetterFilter() -> Filter {
        let aggregateInput = AggregateInput()
        aggregateInput.a = .U
        return Filter(id: UUID(), tool: Tool.firstLetterTool, aggregateInput: aggregateInput, inverted: false)
    }
    
    static func exampleLastLetterFilter() -> Filter {
        let aggregateInput = AggregateInput()
        aggregateInput.a = .C
        return Filter(id: UUID(), tool: Tool.lastLetterTool, aggregateInput: aggregateInput, inverted: false)
    }
    
    static func exampleStartingStringFilter() -> Filter {
        let aggregateInput = AggregateInput()
        aggregateInput.x = "Histor"
        return Filter(id: UUID(), tool: Tool.startingStringTool, aggregateInput: aggregateInput, inverted: false)
    }
    
    static func exampleEndingStringFilter() -> Filter {
        let aggregateInput = AggregateInput()
        aggregateInput.x = "Bling"
        return Filter(id: UUID(), tool: Tool.endingStringTool, aggregateInput: aggregateInput, inverted: false)
    }
    
    static func exampleContainsOnlyFilter() -> Filter {
        let aggregateInput = AggregateInput()
        // Select A,B,C,D,E
        aggregateInput.inputBools[0] = true
        aggregateInput.inputBools[1] = true
        aggregateInput.inputBools[2] = true
        aggregateInput.inputBools[3] = true
        aggregateInput.inputBools[4] = true
        return Filter(id: UUID(), tool: Tool.containsOnlyTool, aggregateInput: aggregateInput, inverted: false)
    }
    
    static func exampleContainsAtLeastFilter() -> Filter {
        let aggregateInput = AggregateInput()
        // Select A,B,C,D,E
        aggregateInput.inputBools[0] = true
        aggregateInput.inputBools[1] = true
        aggregateInput.inputBools[2] = true
        aggregateInput.inputBools[3] = true
        aggregateInput.inputBools[4] = true
        return Filter(id: UUID(), tool: Tool.containsAtLeastTool, aggregateInput: aggregateInput, inverted: false)
    }
    
    static func exampleContainsQuantitiesFillter() -> Filter {
        let aggregateInput = AggregateInput()
        // Select A,B,C,D,E
        aggregateInput.inputInts[12] = 4
        aggregateInput.inputInts[30] = 0
        aggregateInput.inputBools[31] = true
        return Filter(id: UUID(), tool: Tool.containsQuantitiesTool, aggregateInput: aggregateInput, inverted: false)
    }
}

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
