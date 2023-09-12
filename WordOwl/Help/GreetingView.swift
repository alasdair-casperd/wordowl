//
//  WelcomeView.swift
//  WordOwl
//
//  Created by Alasdair Casperd on 23/06/2022.
//

import SwiftUI

struct Greeting {

    struct Item: Identifiable {
        var id: UUID = UUID()
        var icon: String
        var iconColor: Color
        var title: String
        var description: String
    }
    
    var title: String
    var items: [Greeting.Item]
    
    static func updateGreeting(_ versionNumber: Int) -> Greeting {
        
        if versionNumber == 4 {
            return Greeting(
                title: "What's New in this Update?", items: [
                    Item(
                        icon: "ipad.and.iphone",
                        iconColor: Color("WordOwl Cold Blue"),
                        title: "WordOwl on iPad",
                        description: "We hope you'll love using our new iPad app!"
                    ),
                    Item(
                        icon: "circle.hexagongrid",
                        iconColor: Color("WordOwl Yellow"),
                        title: "3 New Search Tools",
                        description: "Solve Wordles, word wheels and Domingo puzzles with new tools!"
                    ),
                    Item(
                        icon: "character.textbox",
                        iconColor: Color("WordOwl Purple"),
                        title: "Plain Text Character Selection",
                        description: "We've added a new, faster way to select characters in several tools."
                    ),
                    Item(
                        icon: "wand.and.stars.inverse",
                        iconColor: Color("WordOwl Red"),
                        title: "UI Improvements",
                        description: "We've cleaned up our UI with bolder buttons and clearer instructions."
                    ),
                ]
            )
        }
        
        else if versionNumber == 3 {
            return Greeting(
                title: "What's New in this Update?", items: [
                    Item(
                        icon: "text.magnifyingglass",
                        iconColor: Color("WordOwl Cold Blue"),
                        title: "New Definition Function",
                        description: "Not sure what one of your results means? Long-press it to find out!"
                    ),
                    Item(
                        icon: "speaker.wave.2",
                        iconColor: Color("WordOwl Purple"),
                        title: "Improved VoiceOver Support",
                        description: "We've improved existing support for VoiceOver users."
                    ),
                    Item(
                        icon: "book.closed",
                        iconColor: Color("WordOwl Yellow"),
                        title: UIDevice.current.userInterfaceIdiom == .pad ? "Dictionary View" : "Dictionary Tab",
                        description: "You can now enable a Dictionary \(UIDevice.current.userInterfaceIdiom == .pad ? "view" : "tab") from the Settings menu."
                    ),
                    Item(
                        icon: "questionmark.circle",
                        iconColor: Color("WordOwl Green"),
                        title: "Added Help Button",
                        description: "You'll find a new help button on several screens around the app."
                    ),
                    Item(
                        icon: "ant",
                        iconColor: Color("WordOwl Orange"),
                        title: "Bug Fixes",
                        description: "We've fixed various bugs surrounding Compound Search."
                    ),
                ]
            )
        }
        
        else if versionNumber == 2 {
            return Greeting(
                title: "What's New in this Update?", items: [
                    Item(
                        icon: "ellipsis.curlybraces",
                        iconColor: Color("WordOwl Cold Blue"),
                        title: "Matches Pattern Tool",
                        description: "Perform more advanced searches than ever with this powerful tool."
                    ),
                    Item(
                        icon: "square.3.layers.3d.down.backward",
                        iconColor: Color("WordOwl Purple"),
                        title: "Result Pages",
                        description: "Long lists of results are now spread over multiple pages, improving performance."
                    ),
                    Item(
                        icon: HelpView.icon,
                        iconColor: Color("WordOwl Yellow"),
                        title: "User Guide",
                        description: "Confused by any of our tools? We've added a comprehensive manual."
                    ),
                    Item(
                        icon: "square.and.pencil",
                        iconColor: Color("WordOwl Green"),
                        title: "Editable Filters",
                        description: "Compound search filters can now be edited after creation."
                    ),
                    Item(
                        icon: "circle.lefthalf.filled",
                        iconColor: Color("WordOwl Warm Blue"),
                        title: "Inverted Searches",
                        description: "Compound search filters can be inverted to search with negated criteria."
                    ),
                    Item(
                        icon: "paintbrush",
                        iconColor: Color("WordOwl Red"),
                        title: "Visual Overhaul",
                        description: "We've updated our app icon and added new visual customisation options."
                    ),
                ]
            )
        }
        
        else {
            return welcomeToWordOwl
        }
    }
    
    static let welcomeToWordOwl = Greeting(
        title: UIDevice.current.userInterfaceIdiom == .pad ? "Welcome to WordOwl for iPad" : "Welcome to\nWordOwl", items: [
            Item(
                icon: ToolsView.icon,
                iconColor: Color("WordOwl Cold Blue"),
                title: "Simple Search",
                description: "Search for words using one of our numerous pre-made search tools."
            ),
            Item(
                icon: CompoundSearchView.icon,
                iconColor: Color("WordOwl Purple"),
                title: "Compound Search",
                description: "Craft your own search function for the ultimate customisable experience."
            ),
            Item(
                icon: HelpView.icon,
                iconColor: Color("WordOwl Yellow"),
                title: "User Guide",
                description: "Confused by any of our tools? You'll find help in our comprehensive manual."
            ),
        ]
    )
}

struct GreetingView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var greeting: Greeting
    
    var scroller: some View {
        ScrollView {
            Spacer()
            HStack {
                Spacer()
                VStack {
                    Text(greeting.title).foregroundColor(.primary)
                        .multilineTextAlignment(.center)
                        .font(.system(size: 40, weight: .heavy))
                }
                Spacer()
            }
            .padding(.vertical, 50)
            
            VStack{
                ForEach(greeting.items) {
                    GreetingViewDetailView(item: $0)
                }
            }
            .frame(maxWidth: 600)
            .padding(.bottom, 100)
            
            Spacer()
        }
        .overlay {
            LinearGradient(colors: [Color("Inverse Primary").opacity(0), Color("Inverse Primary")], startPoint: UnitPoint(x: 0.5, y: 0.8), endPoint: .bottom)
                .allowsHitTesting(false)
            
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            if #available(iOS 16.0, *) {
                scroller
                    .scrollIndicators(.hidden)
            } else {
                scroller
            }
            
            Button(action: {presentationMode.wrappedValue.dismiss()}) {
                HStack {
                    Spacer()
                    Text("Continue")
                        .padding()
                        .foregroundColor(.white)
                    Spacer()
                }
                .background {
                    RoundedRectangle(cornerRadius: 14)
                        .foregroundColor(.accentColor)
                }
            }
            .padding()            
                        
        }
    }
}

struct GreetingView_Previews: PreviewProvider {
    static var previews: some View {
        GreetingView(greeting: Greeting.updateGreeting(4))
        GreetingView(greeting: Greeting.welcomeToWordOwl)
    }
}

struct GreetingViewDetailView: View {
    
    var item: Greeting.Item
    
    var body: some View {
        HStack {
            Image(systemName: item.icon)
                .font(.title.weight(.semibold))
                .frame(width: 50, alignment: .center)
                .foregroundColor(item.iconColor)
                    .padding(.trailing)
            VStack(alignment: .leading, spacing: 3) {
                Text(item.title)
                    .font(.body.weight(.bold))
                Text(item.description)
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
        .padding()
    }
}
