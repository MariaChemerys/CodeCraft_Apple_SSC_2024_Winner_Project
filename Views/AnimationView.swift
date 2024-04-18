
import SwiftUI
import SpriteKit

// View to Run SpriteKit Scenes With Animations
struct AnimationView: UIViewRepresentable {
    typealias UIViewType = SKView

    class Coordinator: NSObject {
        var scene: SKScene?

        init(scene: SKScene?) {
            self.scene = scene
        }
    }

    let scene: SKScene?

    init(scene: SKScene?) {
        self.scene = scene
    }

    func makeUIView(context: Context) -> SKView {
        let skView = SKView()
        skView.presentScene(scene)
        return skView
    }

    func updateUIView(_ uiView: SKView, context: Context) {

    }

    static func dismantleUIView(_ uiView: SKView, coordinator: Coordinator) {

    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(scene: scene)
    }
}
