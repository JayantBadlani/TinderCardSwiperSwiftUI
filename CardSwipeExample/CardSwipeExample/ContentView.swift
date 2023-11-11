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

typealias Card = CardView<ExampleCardView>

struct ContentView: View {
  
    @State var cards: [Card]
    @State var currentIndex: Int = 0

    var body: some View {
        VStack {
            Text("Swipe left or right")
                .font(.title)
                .foregroundColor(.gray)
          Button {
            print("Resetting...")
            loadCards()
          } label: {
            HStack {
              Image(systemName: "arrow.clockwise.circle.fill")
              Text("Reset Cards")
            }
          }

          // Cards
          ZStack {
            ForEach(cards, id: \.tagId) { card in
              card
                .animation(.spring())
                .zIndex(Double(cards.count))
                .offset(x: 0, y: -10)
                .rotationEffect(.degrees(Double((currentIndex == 0 ? 0 : currentIndex - 1) * 2)))
            }
          }
          .padding(.top, 20)
          .padding(.horizontal, 20.0)
        }
        .onAppear {
          loadCards()
        }
    }
  
  private func loadCards() {
    cards = [
        CardView(tagId: UUID(), content: { ExampleCardView() }),
        CardView(tagId: UUID(), content: { ExampleCardView() }),
        CardView(tagId: UUID(), content: { ExampleCardView() }),
        CardView(tagId: UUID(), content: { ExampleCardView() })
    ]
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
      ContentView(cards: [])
    }
}
