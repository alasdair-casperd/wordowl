import Foundation
import SwiftUI

struct Tool: Identifiable, Equatable, Hashable {
    
    struct Category: Identifiable {
        var id: UUID = UUID()
        var name: String
        var tools: [Tool]
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Tool, rhs: Tool) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id: UUID = UUID()
    let name: String
    let shortName: String
    
    let description: String
    let shortDescription: String    
    
    let searchFunction: ([String], AggregateInput) async -> [String]
    
    let symbolName: String?
    
    let input: InputType
    let prompt: [String]
    let promptName : String
    
    let color: Color
}

enum InputType {
    case character
    case string
    case code
    case number
    case range
    case spaces
    case multipleCharacters
    case characterQuantities
}

