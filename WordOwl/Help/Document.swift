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
    let icon: String
    let name: String
    let items: [Item]
}
