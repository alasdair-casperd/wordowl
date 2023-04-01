//
//  AsynchronousSearchTestView.swift
//  WordOwl
//
//  Created by Alasdair Casperd on 17/02/2022.
//

import SwiftUI

struct AsynchronousSearchTestView: View {
    
    @State private var results = [String]()
    @State private var animationAmount: CGFloat = -150
    var body: some View {
        VStack(spacing: 0) {
            Text("🐝")
            .font(.largeTitle)
                .offset(x: animationAmount, y: 0)
                .animation(
                    .easeInOut(duration: 0.5)
                        .repeatForever(autoreverses: true),
                    value: animationAmount
                )
                .padding(.bottom)
                .padding(.top)
                .onAppear {
                    animationAmount = -animationAmount
                }
            List {
                Button("Test Contains Quantities") {
                    let aggregateInput = AggregateInput()
                    aggregateInput.inputBools[0] = true
                    aggregateInput.inputBools[19] = true
                    aggregateInput.inputBools[14] = true
                    aggregateInput.inputBools[15] = true
                    aggregateInput.inputInts[15] = 2
                    aggregateInput.inputInts[14] = 1
                    aggregateInput.inputInts[0] = 2
                    aggregateInput.inputInts[19] = 1
                    aggregateInput.inputInts[30] = 0
                    aggregateInput.inputBools[31] = true
                    Task {
                        results = await containsQuantities(Dictionaries.list[1].words, aggregateInput)
                    }
                }
                .icon("slider.horizontal.3")
                Button("Test Contains String") {
                    let aggregateInput = AggregateInput()
                    aggregateInput.x = "a"
                    Task {
                        results = await containsString(Dictionaries.list[1].words, aggregateInput)
                    }
                }
                .icon("textformat")
                
//                Section {
                    Button("Clear results", role: .destructive) {
                        results = [String]()
                    }
                    .icon("trash", color: .red)
//                }
                
//                Section {
                    ForEach(results, id: \.self) {
                        Text($0)
                    }
//                }.id(UUID())
            }
            .id(UUID())
            .navigationTitle("Async Debugging")
        }
    }
}

struct AsynchronousSearchTestView2: View {
    @State var items = Word.exampleItems

    var body: some View {
        Form {
            Button("Shuffle") {
                self.items.shuffle()
            }
            Section {
                ForEach(items) {
                    Text("Item \($0.word)")
                }
            }
        }
    }
}

struct Word: Identifiable {
    let id: UUID = UUID()
    let word: String
    
    static var exampleItems: [Word] {
        var output = [Word]()
        for i in 1...4000 {
            output.append(Word(word: "Word \(i)"))
        }
        return output
    }
}

struct AsynchronousSearchTestView_Previews: PreviewProvider {
    static var previews: some View {
        AsynchronousSearchTestView2()
    }
}
