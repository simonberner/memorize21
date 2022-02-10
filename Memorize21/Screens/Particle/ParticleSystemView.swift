//
//  ParticleSystemView.swift
//  Memorize21
//
//  Created by Simon Berner on 02.02.22.
//

import SwiftUI

struct ParticleSystemView: View {

    let font = Font.custom(FontNameManager.luckiestGuy, size: 38)

    var body: some View {
        ZStack {
            EmitterView(image: "ballon",
                        particleCount: 100,
                        creationPoint: .init(x: 0.5, y: -0.1),
                        creationRange: CGSize(width: 1, height: 0),
                        colors: [.red, .yellow, .blue, .green, .white, .orange, .purple],
                        angle: Angle(degrees: 180),
                        angleRange: Angle(degrees: 10),
                        opacityRange: 1,
                        scale: 0.4,
                        scaleRange: 0.4,
                        speed: 1200,
                        speedRange: 1200,
                        animation: Animation.linear(duration: 5).repeatForever(autoreverses: false),
                        animationDelayThreshold: 5)

            Text("Game Over")
                .font(font)
                .foregroundColor(.pink)
                .italic()
                .animation(Animation.easeOut(duration: 2))
        }
        .ignoresSafeArea(.all)
    }
}

private struct EmitterView: View {

    // use the start position when false
    @State private var isActive = false

    // The following properties define the start and end position of every single
    // particle ahead of time

    var image: String
    // how many particles
    var particleCount: Int

    // start of right in the center of the view
    var creationPoint = UnitPoint.center
    // how much variants do we want to have from the above
    var creationRange = CGSize.zero

    var colors = [Color.white]
    var blendMode = BlendMode.normal // no blend mode by default

    // angle to fire the particles from
    var angle = Angle.zero
    var angleRange = Angle.zero

    var opacity = 1.0
    var opacityRange = 0.0
    var opacitySpeed = 0.0

    var rotation = Angle.zero
    var rotationRange = Angle.zero
    var rotationSpeed = Angle.zero

    var scale: CGFloat = 1
    var scaleRange: CGFloat = 0
    var scaleSpeed: CGFloat = 0

    // speed we want
    var speed = 50.0
    // how much variants do we want
    var speedRange = 0.0

    // https://sarunw.com/posts/animation-delay-and-repeatforever-in-swiftui/#repeat-forever
    var animation = Animation.linear(duration: 1).repeatForever(autoreverses: false)
    var animationDelayThreshold = 0.0

    var body: some View {
        // The GeometryReader view will take all the space that is offered to it, and pass the dimensions to the closure, in a variable of type GeometryProxy -> here 'geo'
        GeometryReader { geo in
            ZStack {
                ForEach(0..<particleCount, id: \.self) { _ in
                    ParticleView(isActive: $isActive,
                                 image: Image(image),
                                 position: position(in: geo),
                                 opacity: makeOpacity(),
                                 rotation: makeRotation(),
                                 scale: makeScale())
                        .animation(animation.delay(Double.random(in: 0...animationDelayThreshold)), value: isActive)
                        .colorMultiply(colors.randomElement() ?? .white)
                        .blendMode(blendMode)
                }
            }
        }
    }

    private struct ParticleView: View {

        @Binding var isActive: Bool

        let image: Image
        let position: ParticleState<CGPoint>
        let opacity: ParticleState<Double>
        let rotation: ParticleState<Angle>
        let scale: ParticleState<CGFloat>

        var body: some View {
            image
                .opacity(isActive ? opacity.end : opacity.start)
                .scaleEffect(isActive ? scale.end : scale.start)
                .rotationEffect(isActive ? rotation.end : rotation.start)
                .position(isActive ? position.end : position.start)
                .onAppear { isActive = true } // triggers the animation
        }
    }

    // Defines the start and endpoint (can be a Double, CGFloat, CGPoint, Angle) of a single particle
    // We make it generic by using <T> for Type here (which means any Type)
    private struct ParticleState<T> {
        var start: T
        var end: T

        init(_ start: T, _ end: T) {
            self.start = start
            self.end = end
        }
    }

    // calculate the start and end position for each particle
    private func position(in proxy: GeometryProxy) -> ParticleState<CGPoint> {
        // calculate how much X/Y variants we can give to each particle
        let halfCreationWidth = creationRange.width / 2 // X
        let halfCreationHeight = creationRange.height / 2 // Y

        // random -/+ range of the above
        let creationOffsetX = CGFloat.random(in: -halfCreationWidth...halfCreationWidth)
        let creationOffsetY = CGFloat.random(in: -halfCreationHeight...halfCreationHeight)

        // every particle has a different start point
        // creationPoint = 0.5 (because UnitPoint.center is defined as value 0.5 of 1)
        let startX = Double(proxy.size.width * (creationPoint.x + creationOffsetX))
        let startY = Double(proxy.size.height * (creationPoint.y + creationOffsetY))
        let start = CGPoint(x: startX, y: startY)

        let halfSpeedRange = speedRange / 2
        let actualSpeed = speed + Double.random(in: -halfSpeedRange...halfSpeedRange)

        let halfAngleRange = angleRange.radians / 2
        let actualDirection = angle.radians + Double.random(in: -halfAngleRange...halfAngleRange)

        // in SwiftUI 0 degrees is to the right (left from its coordinate system)
        // with -90 (.pi / 2) we go up
        let finalX = cos(actualDirection - .pi / 2) * actualSpeed
        let finalY = sin(actualDirection - .pi / 2) * actualSpeed
        let end = CGPoint(x: startX + finalX, y: startY + finalY)

        return ParticleState(start, end)
    }

    // Video: 34:20
    private func makeOpacity() -> ParticleState<Double> {
        let halfOpacityRange = opacityRange / 2
        let randomOpacity = Double.random(in: -halfOpacityRange...halfOpacityRange)
        return ParticleState(opacity + randomOpacity, opacity + opacitySpeed + randomOpacity)
    }

    private func makeScale() -> ParticleState<CGFloat> {
        let halfScaleRange = scaleRange / 2
        let randomScale = CGFloat.random(in: -halfScaleRange...halfScaleRange)
        return ParticleState(scaleRange + randomScale, scaleRange + scaleSpeed + randomScale)
    }

    private func makeRotation() -> ParticleState<Angle> {
        let halfRotationRange = (rotationRange / 2).radians
        let randomRotation = Double.random(in: -halfRotationRange...halfRotationRange)
        let randomRotationAngle = Angle(radians: randomRotation)
        return ParticleState(rotation + randomRotationAngle, rotation + rotationSpeed + randomRotationAngle)
    }
}

struct ParticleSystemView_Previews: PreviewProvider {
    static var previews: some View {
        ParticleSystemView()
    }
}
