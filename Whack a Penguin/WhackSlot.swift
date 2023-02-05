//
//  WhackSlot.swift
//  Whack a Penguin
//
//  Created by Aasem Hany on 28/01/2023.
//

import SpriteKit

class WhackSlot: SKNode {
    
    var charNode:SKSpriteNode!
    var isVisible = false
    var isHit = false
    
    private func configure(at position:CGPoint) {
        self.position = position
        let sprite = SKSpriteNode(imageNamed: "whackHole")
        addChild(sprite)
        let cropNode = SKCropNode()
        cropNode.position = CGPoint(x: 0.0, y: 14.0)
        cropNode.zPosition = 1
        cropNode.maskNode = SKSpriteNode(imageNamed: "whackMask")
        
        charNode = SKSpriteNode(imageNamed:"penguinGood")
        charNode.position = CGPoint(x: 0.0, y: -90.0)
        charNode.name = "character"
        cropNode.addChild(charNode)
        
        addChild(cropNode)
    }
    
     init(at position:CGPoint) {
         super.init()
         configure(at: position)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func show(hideTime:Double){
        if isVisible {return}
        
        xScale = 1
        yScale = 1
        charNode.run(SKAction.moveBy(x: 0.0, y: 80.0, duration: 0.05))
        isVisible = true
        isHit = false
        
        if Int.random(in: 0...2) == 0 {
            charNode.texture = SKTexture(imageNamed: "penguinGood")
            charNode.name = "charFriend"
        }
        else {
            charNode.texture = SKTexture(imageNamed: "penguinEvil")
            charNode.name = "charEnemy"
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + (hideTime * 3.5)) { [weak self] in
            self?.hide()
        }
    }
    
    func hide() {
        if !isVisible {return}
        charNode.run(SKAction.moveBy(x: 0, y: -80, duration: 0.05))
        isVisible = false
    }
    
    func hit() {
        isHit = true
        let delay = SKAction.wait(forDuration: 0.25)
        let hideMovement = SKAction.moveBy(x: 0, y: -80, duration: 0.5)
        let notVisible = SKAction.run {[weak self]in
            self?.isVisible = false
        }
        charNode.run(SKAction.sequence([delay, hideMovement, notVisible]))
    }

}
