import SwiftUI

// creating a ViewModifier is similar to creating a View but with the difference
// that the body is a function
// any view can now be modified and put as a cards content
// ViewModifiers can be animated
struct Cardify: ViewModifier {
    var isFaceUp: Bool
    var cardColor: Gradient
    
    func body(content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
            } else {
                shape.fill(LinearGradient(
                            gradient: cardColor,
                            startPoint: .leading,
                            endPoint: .topTrailing))
            }
            // in order to be animated, the content (ZStack) has be always on screen
            // with opacity we can only show it to the user when the content isFaceUp=true
            content
                .opacity(isFaceUp ? 1 : 0)
        }
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
