//
//  CardView.swift
//  TinderCardSwiperSwiftUI_Example
//
//  Created by MacBook Pro on 28/02/23.
//


import SwiftUI

@available(iOS 13.0, *)
@available(macOS 10.15, *)
@available(tvOS 13.0, *)
@available(watchOS 6.0, *)

public struct CardView<Content: View>: View {
    
    // MARK: - Properties
    
    @State public var offset = CGSize.zero
    @State public var color: Color = .black
    @State public var isRemoved = false
    @State public var tagId: UUID = UUID()
    public var onCardRemoved: (() -> Void)?
    public var onCardAdded: (() -> Void)?
    public var content: () -> Content
    
    // MARK: - Initializer
    
    public init(tagId: UUID, onCardRemoved: (() -> Void)? = nil, onCardAdded: (() -> Void)? = nil, @ViewBuilder content: @escaping () -> Content) {
        self.onCardRemoved = onCardRemoved
        self.onCardAdded = onCardAdded
        self.content = content
        self.tagId = tagId
    }
    
    // MARK: - Body
    
    public var body: some View {
        ZStack {
            content()
                .frame(width: 320, height: 420)
            
        }
        .offset(x: offset.width * 1, y: offset.height * 0.4)
        .rotationEffect(.degrees(Double(offset.width / 40)))
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    offset = gesture.translation
                    withAnimation {
                        updateCardColor(width: offset.width)
                    }
                }
                .onEnded { _ in
                    withAnimation {
                        handleSwipe(width: offset.width)
                        updateCardColor(width: offset.width)
                    }
                }
        )
        .opacity(isRemoved ? 0 : 1) // add this modifier to handle card removal
    }
    
    // MARK: - Methods
    
    public func handleSwipe(width: CGFloat) {
        switch width {
        case -500...(-150):
            onCardRemoved?()
            offset = CGSize(width: -500, height: 0)
            isRemoved = true // set isRemoved to true
        case 150...500:
            onCardAdded?()
            offset = CGSize(width: 500, height: 0)
            isRemoved = true // set isRemoved to true
        default:
            offset = .zero
        }
    }
    
    
    public func updateCardColor(width: CGFloat) {
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
