//
//  WelcomeView.swift
//  WordOwl
//
//  Created by Alasdair Casperd on 23/06/2022.
//

import SwiftUI

struct WelcomeView: View {
    
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack(alignment: .leading) {
            
            Spacer()
                        
            HStack {
                Spacer()
                VStack {
                    Text("Welcome to")
                        .foregroundColor(.white)
                    Text("WordOwl")
                        .font(.largeTitle.weight(.bold))
                        .foregroundColor(.white)
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
                        .foregroundColor(.accentColor)
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
