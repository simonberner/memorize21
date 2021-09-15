# Memorize 2021

This is a work in progress learning project for my personal endeavours of becoming an iOS Developer one day.
Memorize is a [Memory Game](https://en.wikipedia.org/wiki/Matching_game) and runs on iOS and iPadOS (version >=14). Its purpose is to practice the MVVM paradigm, Swift and SwiftUI.

![Memorize21](Memorize21/memorize21.png)

## Tech Stack
- Xcode 12.5.1
- Swift 5.4
- SwiftUI 

## Learnings
### MVVM
#### View
- Is completely decoupled from the Model
- Is reactive and always reflects the current state of the model
- (The struct) Is created and thrown away all the time. Only the 'var body' sticks around for a very long time
- Don't need any state of their own
- Supposed to be "stateless" and drawing what the current state of the Model is
- Is a Self-referencing protocol and cannot be used as a normal type
- Use @State purposely and sparingly
- @State is a "source of truth" so it is better not something which belongs to the Model
- @State is only used to give temporary state to a var
- @State vars are marked private because no one else can access them anyway
- @State var will cause the View to rebuild its body anytime the data where the @State var is pointing to, changes.
(This is like an @ObservedObject but on a random piece of data (instead of a ViewModel).)
In the new version of the body, the @State var will continue to point the the data in the heap.
- @State makes a space for the var in the heap because the View struct is read-only
#### ViewModel
- Interoperates the Model for the View
#### Model
- Holds the permanent state of the app
### Gradient
- [SwiftUI has a built-in way to apply gradient color](https://sarunw.com/posts/gradient-in-swiftui/)
### Dates
- [Date](https://developer.apple.com/documentation/foundation/date)
- [Working with dates](https://www.hackingwithswift.com/books/ios-swiftui/working-with-dates)
- [Dates, DateComponents and Formatting](https://learnappmaking.com/swift-date-datecomponents-dateformatter-how-to/)
- [Dates in Swift](https://medium.com/codex/working-with-dates-in-swift-9f50390bbc81)
### Access Control
- [Swift Access Control](https://docs.swift.org/swift-book/LanguageGuide/AccessControl.html)
- Make things private by default and change them afterwards when you see that you need to access them from other place in your code
- internal (this is default): it can be accessed from anywhere in your code
### @escaping
- [Escaping Closures](https://docs.swift.org/swift-book/LanguageGuide/Closures.html#ID546)
- [What is @escaping in Swift?](https://www.donnywals.com/what-is-escaping-in-swift/#:~:text=In%20short%2C%20%40escaping%20is%20used,compiler%20that%20this%20is%20intentional.)
### Shape
- All shapes are also Views, they inherit from the View protocol
- [SwiftUI Doc with examples](https://swiftontap.com/shape)
- [Built-in shapes](https://www.hackingwithswift.com/quick-start/swiftui/swiftuis-built-in-shapes)
- The func fill() is a generic function where the 'S' is a don't care (but since there's a 'where S: ShapeStyle', it becomes a "care a little bit").
### Markdown comments
- [How to add Markdown comments to your code](https://www.hackingwithswift.com/example-code/language/how-to-add-markdown-comments-to-your-code)
- [Documentation Comment Syntax](https://github.com/apple/swift/blob/main/docs/DocumentationComments.md)
### Animation
- Only changes can be animated. This includes the following three things:
    - ViewModifier arguments
    - Shapes
    - The comings and goings (existence or not) of Views in the UI
- Animation is showing the user changes that have already happened
- Implicit Animations
    - All ViewModifier arguments that precede the animation modifier will always be animated.
    - Eg. whenever scary and upsideDown changes, the opacity/rotationEffect will be animated:
    - Without .animation(), the changes to opacity/rotation would appear instantly (not animated) on screen.
    - Important: ViewModifiers after the animation modifier, will NOT be animated!
    - .animation modifier does not work on containers

```swift
Text("Hello World")
    .opacity(scary ? 1 : 0)
    .rotationEffect(Angle.degrees(upsideDown ? 180 : 0))
    .animation(Animation.easeInOut)
```

- Explicit Animations
    - We don't attach a modifier to a view, instead we ask SwiftUI to animate the precise change we want to make.
- References:
    - [How to create an explicit animation](https://www.hackingwithswift.com/quick-start/swiftui/how-to-create-an-explicit-animation)
    - [Implicit and explicit animations](https://sirkif.hashnode.dev/explore-animation-in-swiftui-part-1)
