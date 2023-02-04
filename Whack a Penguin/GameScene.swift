//
//  GameScene.swift
//  Whack a Penguin
//
//  Created by Aasem Hany on 28/01/2023.
//

import SpriteKit

class GameScene: SKScene {
    
    var whackSlots = [WhackSlot]()
    
    var popupTime = 0.85
    
    var scoreLabel:SKLabelNode!
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    
    override func didMove(to view: SKView) {
        let bg = SKSpriteNode(imageNamed: "whackBackground")
        bg.position = CGPoint(x: 512, y: 384)
        bg.blendMode = .replace
        bg.zPosition = -1
        addChild(bg)
        
        scoreLabel = SKLabelNode(text: "Score: 0")
        scoreLabel.position = CGPoint(x: 8.0, y: 8.0)
        scoreLabel.fontName = "Chalkduster"
        scoreLabel.fontSize = 48.0
        scoreLabel.horizontalAlignmentMode = .left
        addChild(scoreLabel)
        

        for i in 0 ..< 5 { createSlot(at: CGPoint(x: 100 + (i * 170), y: 410)) }
        for i in 0 ..< 4 { createSlot(at: CGPoint(x: 180 + (i * 170), y: 320)) }
        for i in 0 ..< 5 { createSlot(at: CGPoint(x: 100 + (i * 170), y: 230)) }
        for i in 0 ..< 4 { createSlot(at: CGPoint(x: 180 + (i * 170), y: 140)) }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.createEnemy()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    func createSlot(at position:CGPoint) {
        let whackSlot = WhackSlot(at: position)
        addChild(whackSlot)
        whackSlots.append(whackSlot)
    }
    
    
    func createEnemy(){
        // to decrease the popup time for creating an enemy
        popupTime *= 0.991
        
        whackSlots.shuffle()
        
        whackSlots.first?.show(hideTime: popupTime)
        
        if Int.random(in: 0...12) > 4 { whackSlots[1].show(hideTime: popupTime) }
        if Int.random(in: 0...12) > 8 {  whackSlots[2].show(hideTime: popupTime) }
        if Int.random(in: 0...12) > 10 { whackSlots[3].show(hideTime: popupTime) }
        if Int.random(in: 0...12) > 11 { whackSlots[4].show(hideTime: popupTime)  }

        
        let minDelay = popupTime / 2.0
            let maxDelay = popupTime * 2
            let delay = Double.random(in: minDelay...maxDelay)

            DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
                self?.createEnemy()
            }


    }
 }
