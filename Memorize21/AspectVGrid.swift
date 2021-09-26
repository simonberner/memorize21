import SwiftUI

// This struct has the 'don't care' types Item and ItemView in it
struct AspectVGrid<Item, ItemView>: View where ItemView: View, Item: Identifiable {
    var items: [Item]
    var aspectRatio: CGFloat
    var content: (Item) -> ItemView

    // closure (func types) are reference types, they live in the heap and are thus pointed to
    // the swift compiler needs to know that it only needs to inline the passed in closure and
    // not create memory in the heap for it
    // here: the param content gets assigned to self.content and used later on, so it has to
    // "escape" the scope of init
    init(items: [Item], aspectRatio: CGFloat, @ViewBuilder content: @escaping (Item) -> ItemView) {
        self.items = items
        self.aspectRatio = aspectRatio
        self.content = content
    }

    var body: some View {
        // the Geometry Reader takes all the space which is offered to it
        // and offers it to the view inside of it
        GeometryReader { geometry in
            // make the things inside the GeometryReader flexible in size by adding it to a VStack
            VStack {
                let width: CGFloat = widthThatFits(itemCount: items.count, in: geometry.size, itemAspectRatio: aspectRatio)
                // putting the grid a the top of the VStack
                LazyVGrid(columns: [adaptiveGridItem(width: width)]) {
                    ForEach(items) { item in
                        content(item).aspectRatio(aspectRatio, contentMode: .fit)
                    }
                }
                // ...and then a Spacer just to turn the VStack flexible in size
                Spacer(minLength: 0)
            }
        }
    }

    /**
     Returns an adaptive GritItem with the width and a spacing of 0
     
     - returns:
     A GridItem with spacing 0
     
     - parameters:
        - width: The minimum width the GridItem has.
     */
    private func adaptiveGridItem(width: CGFloat) -> GridItem {
        var gridItem = GridItem(.adaptive(minimum: width))
        gridItem.spacing = 0
        return gridItem
    }

    private func widthThatFits(itemCount: Int, in size: CGSize, itemAspectRatio: CGFloat) -> CGFloat {
        var columnCount = 1
        var rowCount = itemCount

        repeat {
            let itemWidth = size.width / CGFloat(columnCount)
            let itemHeight = itemWidth / itemAspectRatio
            if CGFloat(rowCount) * itemHeight < size.height {
                break
            }
            columnCount += 1
            rowCount = (itemCount + (columnCount - 1)) / columnCount
        } while columnCount < itemCount
        if columnCount > itemCount {
            columnCount = itemCount
        }
        return floor(size.width / CGFloat(columnCount))
    }

}

// struct AspectVGrid_Previews: PreviewProvider {
//    static var previews: some View {
//        AspectVGrid()
//    }
// }
