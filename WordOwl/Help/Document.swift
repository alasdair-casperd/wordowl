//
//  Document.swift
//  WordOwl
//
//  Created by Alasdair Casperd on 01/04/2023.
//

import SwiftUI

struct Document: Identifiable {
    
    struct Item: Identifiable {
        
        enum ItemType {
        case header, tool, paragraph, image, filter, filters, results, continuedResults
        }
        
        let id: UUID = UUID()
        let type: ItemType
        var text: LocalizedStringKey?
        var image: Image?
        var results: [String]?
        var filter: Filter?
        var filters: [Filter]?
        var tool: Tool?
    }
    
    let id: UUID = UUID()
    let icon: Icon.VariableIcon
    let name: String
    let items: [Item]
    
    var description: LocalizedStringKey {
        var output: LocalizedStringKey = ""
        for item in items {
            if item.type == .paragraph {
                output = item.text ?? ""
                break
            }
        }
        if output != "" {
            return output
        }
        return "Empty page."
    }
    
    var tool: Tool? {
        var output: Tool? = nil
        for item in items {
            if item.type == .tool {
                output = item.tool
            }
        }
        return output
    }
}
