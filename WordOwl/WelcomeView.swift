//
//  WelcomeView.swift
//  WordOwl
//
//  Created by Alasdair Casperd on 23/06/2022.
//

import SwiftUI

struct WelcomeView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State private var rotation = -3.0

    var body: some View {
        VStack(alignment: .leading) {
            
            Spacer()
            
            HStack {
                Spacer()
                VStack {
                    Image("WordOwl Outline")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80)
                        .rotationEffect(Angle(degrees: rotation))
                        .animation(.easeInOut.repeatForever())
                        .onAppear{rotation += 10}
                    Text("Welcome to")
                    Text("WordOwl")
                        .font(.largeTitle.weight(.bold))
                }
                Spacer()
            }
            
            Text("Struggling to solve a crossword? Looking for anagrams of 'triangle'? No matter what words you're looking for, WordOwl has you covered.")
                .multilineTextAlignment(.leading)
                .padding()
            
            WelcomeViewDetailView(symbolName: "magnifyingglass", title: "Simple Search", content: " lets you search for words using one of our numerous pre-made search tools.")
            
            WelcomeViewDetailView(symbolName: "slider.horizontal.3", title: "Compound Search", content: " lets you bulid your own search function for the ultimate customisable experience.")
            
            Spacer()
            
            Button(action: {presentationMode.wrappedValue.dismiss()}) {
                HStack {
                    Spacer()
                    Text("Continue")
                        .padding()
                        .foregroundColor(Color.accentColor)
                    Spacer()
                }
                .background {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(.white)
                }
            }
            .padding()
            .padding(.bottom)
                        
        }
        .foregroundColor(.white)
//        .background(LinearGradient(colors: [Color(red: 43/255, green: 52/255, blue: 90/255),Color(red: 15/255, green: 18/255, blue: 43/255)], startPoint: .top, endPoint: .bottom))
        .background(Color.accentColor)
        .edgesIgnoringSafeArea(.all)
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}

struct WelcomeViewDetailView: View {
    
    var symbolName: String
    var title: String
    var content: String
    
    var body: some View {
        HStack {
            Image(systemName: symbolName)
                .font(.title)
                .frame(width: 50)
            Text(title)
                .font(.body.weight(.bold))
            + Text(content)
            Spacer()
        }
        .padding()
    }
}
