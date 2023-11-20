//
//  ContentView.swift
//  CardSwipeExample
//
//  Created by MacBook Pro on 04/03/23.
//

import SwiftUI


struct ContentView: View {
    
    @State var cards: [ExampleCardView]
    
    var body: some View {
        VStack {
            Text("Swipe Cards")
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
            CardSwiperView(cards: self.$cards , onCardSwiped: { swipeDirection, index in
                
                switch swipeDirection {
                case .left:
                    print("Card swiped Left direction at index \(index)")
                case .right:
                    print("Card swiped Right direction at index \(index)")
                case .top:
                    print("Card swiped Top direction at index \(index)")
                case .bottom:
                    print("Card swiped Bottom direction at index \(index)")
                }
            }, onCardDragged: { swipeDirection, index, offset in
                print("Card dragged \(swipeDirection) direction at index \(index) with offset \(offset)")
            })
            .padding(.vertical, 20)
        }
        .onAppear {
            loadCards()
        }
    }
    
    private func loadCards() {
        let newCards = [
            ExampleCardView(index: 0),
            ExampleCardView(index: 1),
            ExampleCardView(index: 2),
            ExampleCardView(index: 3),
            ExampleCardView(index: 5),
            ExampleCardView(index: 6),
            ExampleCardView(index: 7),
            ExampleCardView(index: 8)
        ]
        // Assigning a new array instance to the @State variable
        cards = newCards
    }
}


struct ExampleCardView: View {
    var index: Int
    var tagId: UUID = UUID()

    var body: some View {

        RoundedRectangle(cornerRadius: 20)
            .fill(Color.white)
            .overlay(
                VStack(spacing: 10) {
                    Image(systemName: "heart.fill")
                        .font(.system(size: 50))
                        .foregroundColor(.pink)
                    Text("Example Card \(index)")
                        .font(.title)
                        .bold()
                    Text("This is an example card with some beautiful UI.")
                        .multilineTextAlignment(.center)
                        .font(.body)
                        .foregroundColor(.gray)
                }
                .padding()
            )
            .shadow(color: .gray, radius: 5)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(cards: [])
    }
}
