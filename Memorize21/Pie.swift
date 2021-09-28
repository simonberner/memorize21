import SwiftUI

struct Pie: Shape {

    var startAngle: Angle
    var endAngle: Angle
    var clockwise = false // default value: counter clockwise

    func path(in rect: CGRect) -> Path {

        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        let start = CGPoint(
            x: center.x + radius * cos(CGFloat(startAngle.radians)), // type conversion works by creating new structs
            y: center.y + radius * sin(CGFloat(startAngle.radians))
        )

        var path = Path()
        path.move(to: center)
        path.addLine(to: start)
        path.addArc(center: center,
                 radius: radius,
                 startAngle: startAngle,
                 endAngle: endAngle,
                    // origin for drawing is not the cartesian coordinate system (bottom left x:0/y:0)
                    // -> https://en.wikipedia.org/wiki/Coordinate_system
                    // we are drawing from the upper left! so all is upside down (180 degrees inverted)
                    // from a user point of view, we kind of auto invert here the clockwise for that reason
                 clockwise: !clockwise,
                 transform: .identity)
        path.addLine(to: center)
        return path
    }

}
