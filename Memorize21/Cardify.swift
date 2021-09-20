import SwiftUI

// creating a AnimatableModifier is similar to creating a View but with the difference
// that the body is a function
// any view can now be modified and put as a cards content
// by specifying that this is a AnimatableModifier, we take over the responsibility to
// animate all the containing ViewModifiers
struct Cardify: AnimatableModifier {
    var cardColor: Gradient
    var rotation: Double // in degrees
    
    init(isFaceUp: Bool, cardColor: Gradient) {
        self.cardColor = cardColor
        rotation = isFaceUp ? 0 : 180
    }
    
    // this is a computed var which acts as a renaming of the var rotation
    // this is from the protocol'Animatable' an is the required data to be animated
    var animatableData: Double {
        get {rotation}
        set {rotation = newValue}
    }
    

    func body(content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            // isMatched and isFaceUp happen simultaneously
            if rotation < 90 {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
            } else {
                shape.fill(LinearGradient(
                            gradient: cardColor,
                            startPoint: .leading,
                            endPoint: .topTrailing))
            }
            // in order to be animated, the content (ZStack with the card content) has to be always on screen
            // with opacity we can only show it to the user when the content isFaceUp=true
            content
                .opacity(rotation < 90 ? 1 : 0)
        }
        .rotation3DEffect(Angle.degrees(rotation), axis: (0, 1, 0))
    }
    
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
    }
    
}


extension View {
    
    /**
     This function modifies any view into the card content.
     
     - returns:
     The modified view.
     
     - parameters:
        - isFaceUp: The Boolean if the card is facing up.
        - cardColor: The ColorGradient of the cards.
     
     */
    func cardify(isFaceUp: Bool, cardColor: Gradient) -> some View {
        modifier(Cardify(isFaceUp: isFaceUp, cardColor: cardColor))
    }
}
