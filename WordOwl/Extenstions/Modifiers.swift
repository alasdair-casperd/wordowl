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
        case smallBold
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
                    .accessibilityHidden(true)
                content
            }
        case .large:
            HStack {
                Image(systemName: systemName)
                    .foregroundColor(color)
                    .font(.title2)
                    .frame(width: 30, height: 50, alignment: .center)
                    .padding(.trailing, 12)
                    .accessibilityHidden(true)
                content
            }
        case .smallBold:
            HStack {
                Image(systemName: systemName)
                    .foregroundColor(.white)
                    .font(.body)
                    .background {
                        RoundedRectangle(cornerRadius: 8)
                            .foregroundColor(color)
                            .frame(width: 28, height: 28, alignment: .center)
                    }
                    .accessibilityHidden(true)
                .frame(width: 20, height: 20, alignment: .center)
                .padding(.trailing, 8)
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
                    .accessibilityHidden(true)
                .frame(width: 30, height: 50, alignment: .center)
                .padding(.trailing, 8)
                content
            }
        }
    }
}

struct Extensions_Previews: PreviewProvider {
    static var previews: some View {
        List {
            Text("Small")
                .icon("person", style: .small)
            Text("Large")
                .icon("person", style: .large)
            Text("Small Bold")
                .icon("person", style: .smallBold)
            Text("Bold")
                .icon("person", style: .bold)
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
    
    var iPadVersion: Bool {        
        return UIDevice.current.userInterfaceIdiom == .pad
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
