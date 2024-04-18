

import SpriteKit

// Margaret Hamilton Coloring Animation SKScene
class MargaretHamiltonScene: SKScene {
    
    override func didMove(to view: SKView) {

        view.allowsTransparency = true
        self.backgroundColor = .clear
        self.scaleMode = .aspectFill
        self.size = CGSize(width: 300, height: 300)
        
        runMargaretHamiltonAnimation()
        
    }

    private func runMargaretHamiltonAnimation(){
        
        let margaretHamiltonAnimation: SKAction
        var textures: [SKTexture] = []
        
        // Filling the Array of SKTextures with Margaret Hamilton Animation Frames
        for i in 0...58{
            textures.append(SKTexture(imageNamed: "Margaret Hamilton \(i)"))
        }
        
        // Making Frames Change Fast and Setting the Time per Frame
        margaretHamiltonAnimation = SKAction.animate(with: textures, timePerFrame: 0.07)
        
        let margaretHamilton = SKSpriteNode(imageNamed: "Margaret Hamilton 0")
        
        // Setting the Position of the Animation to Be in the Middle
        let posx = self.frame.width / 2.0
        let posy = self.frame.height / 2.0
        margaretHamilton.position = CGPoint(x: posx, y: posy)
        
        // Making the size of the Animation Equal to the Size of the Scene
        margaretHamilton.size = CGSize(width: self.frame.width, height: self.frame.width)
        
        addChild(margaretHamilton)
        
        // Running the Animation
        margaretHamilton.run(margaretHamiltonAnimation)
    }
    
}
