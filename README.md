# TinderCardSwiperSwiftUI

## Tinder Card Swiper is a SwiftUI class that allows you to create a card swiping interface similar to the one used in the popular dating app, Tinder.

With Tinder Card Swiper, you can easily create a stack of cards that users can swipe left or right on. Each card can contain any SwiftUI view, giving you complete control over the content of your swiping interface.

![ezgif com-resize](https://user-images.githubusercontent.com/37996543/222895736-1d0f4bda-c48e-4b1d-9441-9eaf8cb30909.gif)

### Installation
To use Tinder Card Swiper in your project, simply copy the TinderCardSwiper.swift file into your project's source code. You can then import the TinderCardSwiper class into any SwiftUI view where you want to use it.

### Usage
To use Tinder Card Swiper, you'll first need to create a list of cards that you want to display. Each card should be represented as a SwiftUI view, and can contain any type of content you like.

Once you have your list of cards, you can create a TinderCardSwiper instance and pass your list of cards as a parameter:

```ruby
@State var cards: [ExampleCardView] // Assuming ExampleCardView is your custom card view

var body: some View {
    VStack {
        // Your other UI components
        
        // Card Swiper View
        CardSwiperView(cards: self.$cards, onCardSwiped: { swipeDirection, index in
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
        
        // Your other UI components
    }
    .onAppear {
        loadCards()
    }
}


```

Tinder Card Swiper will automatically display your list of cards as a stack that users can swipe left or right on.

### Customization
Tinder Card Swiper provides a number of customization options that allow you to tailor the appearance and behavior of your card swiping interface. These options can be set using the TinderCardSwiper instance's properties:

```ruby

// Set the angle that the cards should be initialOffsetY as they display in stack
cardSwiper.initialOffsetY = 5

// Set the amount that the cards should be display rotated as they display in stack
cardSwiper.initialRotationAngle = 0.5

```

You can also customize the appearance of your cards by applying any SwiftUI modifiers that you like to each card view.

### Conclusion
Tinder Card Swiper provides an easy and flexible way to create a card swiping interface in SwiftUI. With just a few lines of code, you can create a stack of cards that users can swipe left or right on, and customize the appearance and behavior of your interface to suit your needs.
