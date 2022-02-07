//
//  CardView.swift
//  Memorize21
//
//  Created by Simon Berner on 06.02.22.
//

import SwiftUI

// every view in SwiftUI is immutable (can't be modified)
// 'self' here is the whole CardView
// the view is constantly rebuild when something changes in view
struct CardView: View {
    let card: EmojiMemoryGameViewModel.Card
    let gameViewModel: EmojiMemoryGameViewModel

    // causes the Pie to redraw ever time this var changes
    @State private var animatedBonusRemaining: Double = 0

    var body: some View {
        // GeometryReader offers space to its sub-views by telling them
        // how much space they have
        GeometryReader(content: { geometry in
            ZStack {
                // 0 degrees is to the right of the iOS coordinate system (x:0/y:0 in the upper left)
                // that is why we have to subtract 90 degrees (when thinking
                // in compass rose https://en.wikipedia.org/wiki/Compass_rose)
                // endAngle: as we want to go backwards, we have to do 'one minus' the bonusRemaining
                Group {
                    if card.isConsumingBonusTime {
                        Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: (1-animatedBonusRemaining)*360-90))
                        // every time the pie appears on the screen, this animation kicks in
                            .onAppear {
                                animatedBonusRemaining = card.bonusRemaining
                                withAnimation(.linear(duration: card.bonusTimeRemaining)) {
                                    animatedBonusRemaining = 0
                                }
                            }
                    } else {
                        Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: (1-card.bonusRemaining)*360-90))
                    }
                }
                .padding(DrawingConstants.piePadding)
                .opacity(DrawingConstants.pieOpacity)
                Text(card.content)
                //                    .font(font(in: geometry.size)) // font is NOT animatable
                // animations animate changes on screen
                // the arguments to a view modifier need to change in order that
                // the view modifier can be animated
                // it is already rotating when coming on screen
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0)) // this is now animatable
                // implicit animation which only animates the view modifier above
                // so the placement of implicit animation modifiers is important
                // this animation animates the change of the above var card.isMatched
                    .animation(.linear(duration: 1).repeatForever(autoreverses: false), value: card.isMatched)

                // fixed font size which does not have to animate
                    .font(Font.system(size: DrawingConstants.fontSize))
                    .scaleEffect(scale(thatFits: geometry.size))
            }
            // the ZStack is passed as content to the Cardify ViewModifier
            .cardify(isFaceUp: card.isFaceUp, cardColor: gameViewModel.emojiThemeColorGradient)
        })
    }

    private func scale(thatFits size: CGSize) -> CGFloat {
        min(size.width, size.height) / (DrawingConstants.fontSize / DrawingConstants.fontScale)
    }

    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }

    // for drawing we use CGFloat, not Int or Double!
    private struct DrawingConstants {
        static let fontScale: CGFloat = 0.7
        static let circleOpacity = 0.5 // inferred type is Double here
        static let piePadding: CGFloat = 5
        static let pieOpacity = 0.5 // inferred type is Double here
        static let fontSize: CGFloat = 32
    }
}

// struct CardView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardView()
//    }
// }
