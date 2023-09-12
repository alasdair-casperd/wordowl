//
//  Modifiers.swift
//  WordOwl
//
//  Created by Alasdair Casperd on 30/03/2023.
//

import SwiftUI

struct Icon: ViewModifier {
    
    enum VariableIcon {
        case image(String)
        case character(String)
    }
    
    enum Style {
        case small
        case large
        case smallBold
        case mediumBold
        case bold
    }
      
    var icon: VariableIcon
    var color: Color
    var style: Style = .small
    
    var imageFontSize: Font {
        switch style {
        case .small:
            return .body
        case .large:
            return .title2
        case .smallBold:
            return .body
        case .mediumBold:
            return .title3
        case .bold:
            return .title2
        }
    }
    
    var textFontSize: Font {
        switch style {
        case .small:
            return .title2
        case .large:
            return .title
        case .smallBold:
            return .title2
        case .mediumBold:
            return .title
        case .bold:
            return .title
        }
    }
    
    var iconForeground: some View {
        Group {
            switch icon {
            case .image(let systemName):
                Image(systemName: systemName)
                    .font(imageFontSize)
            case .character(let text):
                Text(text.prefix(1))
                    .font(textFontSize)
            }
        }
    }
    
    func body(content: Content) -> some View {
        switch style {
        case .small:
            HStack {
                iconForeground
                .frame(width: 20)
                .padding(.trailing, 5)
                .foregroundColor(color)
                .accessibilityHidden(true)
                
                content
            }
        case .large:
            HStack {
                iconForeground
                    .foregroundColor(color)
                    .frame(width: 30, height: 50, alignment: .center)
                    .padding(.trailing, 12)
                    .accessibilityHidden(true)
                content
            }
        case .smallBold:
            HStack {
                iconForeground
                    .foregroundColor(.white)
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
        case .mediumBold:
            HStack {
                iconForeground
                    .foregroundColor(.white)
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(color)
                            .frame(width: 35, height: 35, alignment: .center)
                    }
                    .accessibilityHidden(true)
                .frame(width: 25, height: 50, alignment: .center)
                .padding(.trailing, 8)
                content
            }
        case .bold:
            HStack {
                iconForeground
                    .foregroundColor(.white)
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
            Text("Medium Bold")
                .icon("person", style: .mediumBold)
            Text("Bold")
                .icon("person", style: .bold)
            
            Text("Small")
                .icon(.character("❖"), style: .small)
            Text("Large")
                .icon(.character("❖"), style: .large)
            Text("Small Bold")
                .icon(.character("❖"), style: .smallBold)
            Text("Medium Bold")
                .icon(.character("❖"), style: .mediumBold)
            Text("Bold")
                .icon(.character("❖"), style: .bold)
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
        modifier(Icon(icon: Icon.VariableIcon.image(systemName), color: color, style: style))
    }
    
    func icon(character: String, color: Color = .accentColor, style: Icon.Style = .small) -> some View {
        modifier(Icon(icon: Icon.VariableIcon.character(character), color: color, style: style))
    }
    
    func icon(_ icon: Icon.VariableIcon, color: Color = .accentColor, style: Icon.Style = .small) -> some View {
        modifier(Icon(icon: icon, color: color, style: style))
    }
    
    func panelled() -> some View {
        modifier(PanelBackground())
    }
    
    var iPadVersion: Bool {        
        return UIDevice.current.userInterfaceIdiom == .pad
    }
}

extension EdgeInsets {
    static let none = EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
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
