import SwiftUI

// this is all functional programming
// (there is no shared state, mutable data or other side effects)
// (application state flows through pure functions)
// (see also https://medium.com/javascript-scene/master-the-javascript-interview-what-is-functional-programming-7f218c68b3a0)
struct ContentView: View {
    // must behave like an Identifiable, that is why we use itself \.self as identifier
    var emojis = ["🚖","🛥","✈️","🚀","🚗","🚊","🚟","🛶","🛫","🚜","🏎","🏍","🛵","🚐","🚤","🛴","🚲","⛵️","🚠","🚌","🦽","🛸","🏍","🚢"]
    @State var emojiCount = 4
    
    var body: some View {
        // VStack/HStack/ZStack are view builders
        VStack {
            ScrollView {
                // Lazy about accessing the body vars in the view
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    // \.self means: use the emoji String itself as identifier
                    // the emoji is just the argument to the closure
                    ForEach(emojis[0..<emojiCount], id: \.self) { emoji in
                        CardView(content: emoji).aspectRatio(2/3, contentMode: .fit)
                    }
                }
            }
            .foregroundColor(.red)
        }
        .padding(.horizontal)
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
                shape.strokeBorder(lineWidth: 3)
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
