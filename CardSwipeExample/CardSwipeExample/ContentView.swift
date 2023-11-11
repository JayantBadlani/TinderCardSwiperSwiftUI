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
              updateCard(card)
            }
          }
          .padding(.top, 20)
          .padding(.horizontal, 20.0)
        }
        .onAppear {
          loadCards()
        }
    }
  
  private func updateCard(_ card: Card) -> some View {
    card
      .animation(.spring(), value: UUID())
      .zIndex(Double(cards.count - card.index))
      .offset(x: 0, y: 10 + CGFloat(card.index) * 10)
      .rotationEffect(.degrees(-(Double(card.index)) * 0.7))
  }
  
  private func loadCards() {
    cards = [
      CardView(index: 0, tagId: UUID(), content: { ExampleCardView() }),
      CardView(index: 1, tagId: UUID(), content: { ExampleCardView() }),
      CardView(index: 2, tagId: UUID(), content: { ExampleCardView() }),
      CardView(index: 3, tagId: UUID(), content: { ExampleCardView() })
    ]
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
      ContentView(cards: [])
    }
}
