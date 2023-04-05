//
//  Example Filters.swift
//  WordOwl
//
//  Created by Alasdair Casperd on 03/04/2023.
//

import Foundation


extension Filter {
    
    static func exampleAnagramsFilter() -> Filter {
        let aggregateInput = AggregateInput()
        aggregateInput.x = "triangle"
        return Filter(id: UUID(), tool: Tool.anagramsTool, aggregateInput: aggregateInput, inverted: false)
    }
    
    static func exampleCrosswordFilter() -> Filter {
        let aggregateInput = AggregateInput()
        aggregateInput.inputStrings[0] = "g"
        aggregateInput.inputStrings[2] = "a"
        aggregateInput.inputStrings[4] = "e"
        aggregateInput.i = 7
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
    
    static func exampleContainsQuantitiesFilter() -> Filter {
        let aggregateInput = AggregateInput()
        // Select A,B,C,D,E
        aggregateInput.inputBools[11] = true
        aggregateInput.inputInts[11] = 4
        aggregateInput.inputInts[30] = 0
        aggregateInput.inputBools[31] = true
        return Filter(id: UUID(), tool: Tool.containsQuantitiesTool, aggregateInput: aggregateInput, inverted: false)
    }
    
    static func exampleWordLengthFilter() -> Filter {
        let aggregateInput = AggregateInput()
        aggregateInput.i = 10
        return Filter(id: UUID(), tool: Tool.wordLengthTool, aggregateInput: aggregateInput, inverted: false)
    }
    
    static func exampleWordLengthRangeFilter() -> Filter {
        let aggregateInput = AggregateInput()
        aggregateInput.i = 12
        aggregateInput.j = 10
        return Filter(id: UUID(), tool: Tool.wordLengthRangeTool, aggregateInput: aggregateInput, inverted: false)
    }
    
    static func exampleMatchesPatternFilter1() -> Filter {
        let aggregateInput = AggregateInput()
        aggregateInput.x = "???e"
        return Filter(id: UUID(), tool: Tool.matchesPatternTool, aggregateInput: aggregateInput, inverted: false)
    }
    
    static func exampleMatchesPatternFilter2() -> Filter {
        let aggregateInput = AggregateInput()
        aggregateInput.x = "ex-ble"
        return Filter(id: UUID(), tool: Tool.matchesPatternTool, aggregateInput: aggregateInput, inverted: false)
    }
    
    static func exampleMatchesPatternFilter3() -> Filter {
        let aggregateInput = AggregateInput()
        aggregateInput.x = "-t?n-ing"
        return Filter(id: UUID(), tool: Tool.matchesPatternTool, aggregateInput: aggregateInput, inverted: false)
    }
    
    static func exampleMatchesPatternFilter4() -> Filter {
        let aggregateInput = AggregateInput()
        aggregateInput.x = "1-22-1"
        return Filter(id: UUID(), tool: Tool.matchesPatternTool, aggregateInput: aggregateInput, inverted: false)
    }
    
    static func exampleMatchesPatternFilter5() -> Filter {
        let aggregateInput = AggregateInput()
        aggregateInput.x = "-112233-"
        return Filter(id: UUID(), tool: Tool.matchesPatternTool, aggregateInput: aggregateInput, inverted: false)
    }
    
    static func exampleCompoundSearchFilters1() -> [Filter] {
        
        let a1 = AggregateInput()
        a1.x = "se"
        let f1 = Filter(id: UUID(), tool: Tool.startingStringTool, aggregateInput: a1, inverted: false)
        
        let a2 = AggregateInput()
        a2.x = "ke"
        let f2 = Filter(id: UUID(), tool: Tool.endingStringTool, aggregateInput: a2, inverted: false)
        
        return [f1, f2]
    }
    
    static func exampleCompoundSearchFilters2() -> [Filter] {
        
        let a1 = AggregateInput()
        a1.a = .A
        let f1 = Filter(id: UUID(), tool: Tool.firstLetterTool, aggregateInput: a1, inverted: false)
        
        let a2 = AggregateInput()
        a2.x = "ing"
        let f2 = Filter(id: UUID(), tool: Tool.endingStringTool, aggregateInput: a2, inverted: true)
        
        let a3 = AggregateInput()
        a3.x = "-11-"
        let f3 = Filter(id: UUID(), tool: Tool.matchesPatternTool, aggregateInput: a3, inverted: false)
        
        let a4 = AggregateInput()
        a4.i = 8
        let f4 = Filter(id: UUID(), tool: Tool.wordLengthTool, aggregateInput: a4, inverted: false)
        
        let a5 = AggregateInput()
        a5.x = "pro"
        let f5 = Filter(id: UUID(), tool: Tool.containsStringTool, aggregateInput: a5, inverted: false)
        
        return [f1, f2, f3, f4, f5]
    }
}
