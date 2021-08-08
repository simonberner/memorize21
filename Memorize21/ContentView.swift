import SwiftUI

struct ContentView: View {
    // must behave like an Identifiable
    var emojis = ["🚖","🛥","✈️","🚀"]
    
    var body: some View {
        HStack {
            // \.self means: us the emoji String itself as identifier
            ForEach(emojis, id: \.self) { emoji in
                CardView(content: emoji)
            }
        }
        .padding(.horizontal)
        .foregroundColor(.blue)
    }
}

// every view in SwiftUI is immutable (can't be modified)
// 'self' here is the whole CardView
// the view is constantly rebuild when something changes in view
struct CardView: View {
    // @State turns this var in to a pointer to some boolean somewhere in the memory
    // if the boolean in memory changes, SwiftUI will rebuild the body of this
    // CardView
    // (see also the official docu)
    @State var isFaceUp: Bool = true
    var content: String
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.stroke(lineWidth: 3)
                Text(content).font(.largeTitle)
            } else {
                shape.fill()
            }
        }
        // if a function (here a view modifier) takes just one
        // argument, we can leave out the argument name (here 'perform:')
        .onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
}






























struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
        ContentView()
            .preferredColorScheme(.light)
    }
}
