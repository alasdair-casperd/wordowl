//
//  Modifiers.swift
//  WordOwl
//
//  Created by Alasdair Casperd on 30/03/2023.
//

import SwiftUI

struct Icon: ViewModifier {
    
    var systemName: String
    var color: Color
    
    func body(content: Content) -> some View {
        HStack {
            Image(systemName: systemName)
                .frame(width: 20)
                .padding(.trailing, 5)
                .foregroundColor(color)
            content
        }
    }
}

struct PanelBackground: ViewModifier {
    
    func body(content: Content) -> some View {
        HStack{
            content
            Spacer()
        }
            .padding()
            .background {
                Rectangle()
                    .foregroundColor(Color.panelColor)
                    .cornerRadius(14)
            }
    }
}

extension View {
    func icon(_ systemName: String, color: Color = .accentColor) -> some View {
        modifier(Icon(systemName: systemName, color: color))
    }
    
    func panelled() -> some View {
        modifier(PanelBackground())
    }
}


extension ShapeStyle where Self == Color {
    static var random: Color {
        Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}
