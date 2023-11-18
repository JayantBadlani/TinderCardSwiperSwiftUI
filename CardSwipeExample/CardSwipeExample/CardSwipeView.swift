//
//  CardView.swift
//  TinderCardSwiperSwiftUI_Example
//
//  Created by MacBook Pro on 28/02/23.
//


import SwiftUI

enum SwipeDirection {
    case left, right, top, bottom
}


public struct CardSwiperView<Content: View>: View {
    
    @Binding var cards: [Content]
    
    var onCardSwiped: ((SwipeDirection, Int) -> Void)?
    var initialOffsetY: CGFloat = 5
    var initialRotationAngle: Double = 0.5
    
    init(
        cards: Binding<[Content]>, // Updated parameter to use Binding
        onCardSwiped: ((SwipeDirection, Int) -> Void)? = nil,
        initialOffsetY: CGFloat = 5,
        initialRotationAngle: Double = 0.5
    ) {
        self._cards = cards // Update to Binding
        self.onCardSwiped = onCardSwiped
        self.initialOffsetY = initialOffsetY
        self.initialRotationAngle = initialRotationAngle
    }
    
    public var body: some View {
        ZStack {
            ForEach(cards.indices, id: \.self) { index in
                CardView(
                    index: index,
                    onCardSwiped: { swipeDirection in
                        onCardSwiped?(swipeDirection, index)
                    },
                    content: {
                        cards[index]
                    },
                    initialOffsetY: initialOffsetY,
                    initialRotationAngle: initialRotationAngle,
                    zIndex: Double(cards.count - index)
                )
                .id(UUID())
            }
        }
    }
    
    private struct CardView<Content: View>: View {
        var index: Int
        var onCardSwiped: ((SwipeDirection) -> Void)?
        var content: () -> Content
        var initialOffsetY: CGFloat
        var initialRotationAngle: Double
        var zIndex: Double
        
        @State private var offset = CGSize.zero
        @State private var color: Color = .black
        @State private var isRemoved = false
        
        var body: some View {
            content()
                .frame(width: 320, height: 420)
                .offset(x: offset.width * 1, y: offset.height * 0.4)
                .rotationEffect(.degrees(Double(offset.width / 40)))
                .zIndex(zIndex)
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            offset = gesture.translation
                            withAnimation {
                                updateCardColor(width: offset.width)
                            }
                        }
                        .onEnded { gesture in
                            withAnimation {
                                handleSwipe(width: offset.width, height: offset.height)
                            }
                        }
                )
                .opacity(isRemoved ? 0 : 1)
        }
        
        func handleSwipe(width: CGFloat, height: CGFloat) {
            var swipeDirection: SwipeDirection = .left
            
            switch (width, height) {
            case (-500...(-150), _):
                swipeDirection = .left
                offset = CGSize(width: -500, height: 0)
                isRemoved = true
                onCardSwiped?(swipeDirection)
            case (150...500, _):
                swipeDirection = .right
                offset = CGSize(width: 500, height: 0)
                isRemoved = true
                onCardSwiped?(swipeDirection)
            case (_, -500...(-150)):
                swipeDirection = .top
                offset = CGSize(width: 0, height: -500)
                isRemoved = true
                onCardSwiped?(swipeDirection)
            case (_, 150...500):
                swipeDirection = .bottom
                offset = CGSize(width: 0, height: 500)
                isRemoved = true
                onCardSwiped?(swipeDirection)
            default:
                offset = .zero
            }
            
            
        }
        
        func updateCardColor(width: CGFloat) {
            switch width {
            case -500...(-130):
                color = .red
            case 130...500:
                color = .green
            default:
                color = .black
            }
        }
    }
}
