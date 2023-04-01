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
        if versionNumber == 2 {
            return version2
        }
        else {
            return welcomeToWordOwl
        }
    }
    
    static let welcomeToWordOwl = Greeting(
        title: "Welcome to\nWordOwl", items: [
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
                title: "User Manual",
                description: "Confused by any of our tools? You'll find help in our comphrehensive manual."
            ),
        ]
    )
    
    private static let version2 = Greeting(
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
                title: "User Manual",
                description: "Confused by any of our tools? We've added a comphrehensive manual."
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
            .padding(.bottom, 100)
            
            Spacer()
        }
        .overlay {
            LinearGradient(colors: [.white.opacity(0), .white], startPoint: UnitPoint(x: 0.5, y: 0.8), endPoint: .bottom)
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
        GreetingView(greeting: Greeting.updateGreeting(2))
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
            VStack(alignment: .leading) {
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
