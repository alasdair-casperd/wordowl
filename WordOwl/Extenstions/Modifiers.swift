//
//  Modifiers.swift
//  WordOwl
//
//  Created by Alasdair Casperd on 30/03/2023.
//

import SwiftUI

struct Icon: ViewModifier {
    
    enum Style {
        case small
        case large
        case bold
    }
    
    var systemName: String
    var color: Color
    var style: Style = .small
    
    func body(content: Content) -> some View {
        switch style {
        case .small:
            HStack {
                Image(systemName: systemName)
                    .font(.body)
                    .frame(width: 20)
                    .padding(.trailing, 5)
                    .foregroundColor(color)
                content
            }
        case .large:
            HStack {
                Image(systemName: systemName)
                    .foregroundColor(color)
                    .font(.title2)
                    .frame(width: 30, height: 50, alignment: .center)
                    .padding(.trailing, 12)
                content
            }
        case .bold:
            HStack {
                Image(systemName: systemName)
                    .foregroundColor(.white)
                    .font(.title2)
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(color)
                            .frame(width: 40, height: 40, alignment: .center)
                    }
                .frame(width: 30, height: 50, alignment: .center)
                .padding(.trailing, 8)
                content
            }
        }
    }
}

struct PanelBackground: ViewModifier {
    
    func body(content: Content) -> some View {
        HStack{
            content
            
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
    func icon(_ systemName: String, color: Color = .accentColor, style: Icon.Style = .small) -> some View {
        modifier(Icon(systemName: systemName, color: color, style: style))
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
