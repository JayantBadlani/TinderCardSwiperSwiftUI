//
//  ContentView.swift
//  CardSwipeExample
//
//  Created by MacBook Pro on 04/03/23.
//

import SwiftUI

struct ExampleCardView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(Color.white)
            .overlay(
                VStack(spacing: 10) {
                    Image(systemName: "heart.fill")
                        .font(.system(size: 50))
                        .foregroundColor(.pink)
                    Text("Example Card")
                        .font(.title)
                        .bold()
                    Text("This is an example card with some beautiful UI.")
                        .font(.body)
                        .foregroundColor(.gray)
                }
                .padding()
            )
            .shadow(radius: 10)
    }
}

struct ContentView: View {
    let cards: [CardView<ExampleCardView>] = [
        CardView(content: { ExampleCardView() }),
        CardView(content: { ExampleCardView() }),
        CardView(content: { ExampleCardView() }),
        CardView(content: { ExampleCardView() })
    ]

    var body: some View {
        VStack {
            Text("Swipe left or right")
                .font(.title)
                .foregroundColor(.gray)
            CardStackView(cards: cards, cardAction: {})
                .frame(height: 500)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
