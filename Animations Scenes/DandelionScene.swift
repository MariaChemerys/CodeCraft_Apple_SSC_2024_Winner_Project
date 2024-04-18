
import SpriteKit

// Dandelion Coloring by Number Animation SKScene
class DandelionScene: SKScene {
    
    override func didMove(to view: SKView) {

        view.allowsTransparency = true
        self.backgroundColor = .clear
        self.scaleMode = .aspectFill
        self.size = CGSize(width: 300, height: 300)
        
        runDandelionAnimation()
        
    }

    private func runDandelionAnimation(){
        
        let dandelionAnimation: SKAction
        var textures: [SKTexture] = []
        
        // Filling the Array of SKTextures with Dandelion Animation Frames
        for i in 0...18{
            textures.append(SKTexture(imageNamed: "dandelion \(i)"))
        }
        
        var i = 0
        
        // Adding More Textures to the End to Create the Effect of Pause Between the Repetitions of the Animation
        while i < 10 {
            textures.append(SKTexture(imageNamed: "dandelion 18"))
            i += 1
        }
        
        // Making Frames Change Fast and Setting the Time per Frame
        dandelionAnimation = SKAction.animate(with: textures, timePerFrame: 0.1)
        
        let dandelion = SKSpriteNode(imageNamed: "dandelion 0")
        
        // Setting the Position of the Animation to Be in the Middle
        let posx = self.frame.width / 2.0
        let posy = self.frame.height / 2.0
        dandelion.position = CGPoint(x: posx, y: posy)
        
        // Making the size of the Animation Equal to the Size of the Scene
        dandelion.size = CGSize(width: self.frame.width, height: self.frame.width)
        
        addChild(dandelion)
        
        // Running the Animation
        dandelion.run(SKAction.repeatForever(dandelionAnimation))
    }
    
}

// Dandelion Coloring by Number Animation when High Contrast Mode is ON
class DandelionHCScene: SKScene {
    
    override func didMove(to view: SKView) {
        
        view.allowsTransparency = true
        self.backgroundColor = .clear
        self.scaleMode = .aspectFill
        self.size = CGSize(width: 300, height: 300)
        
        runDandelionAnimation()
        
    }
    
    private func runDandelionAnimation(){
        
        let dandelionAnimation: SKAction
        var textures: [SKTexture] = []
        
        for i in 0...18{
            textures.append(SKTexture(imageNamed: "dandelion HC \(i)"))
        }
        
        var i = 0
        while i < 10 {
            textures.append(SKTexture(imageNamed: "dandelion HC 18"))
            i += 1
        }
        
        dandelionAnimation = SKAction.animate(with: textures, timePerFrame: 0.1)
        
        let dandelion = SKSpriteNode(imageNamed: "dandelion HC 0")
        
        let posx = self.frame.width / 2.0
        let posy = self.frame.height / 2.0
        
        dandelion.position = CGPoint(x: posx, y: posy)
        dandelion.size = CGSize(width: self.frame.width, height: self.frame.width)
        addChild(dandelion)
        dandelion.run(SKAction.repeatForever(dandelionAnimation))
    }
}
