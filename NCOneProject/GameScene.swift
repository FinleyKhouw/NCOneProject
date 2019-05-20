//
//  GameScene.swift
//  NCOneProject
//
//  Created by Finley Khouwira on 20/05/19.
//  Copyright © 2019 Finley Khouwira. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var circle = SKShapeNode()
    
    var circleOne = SKShapeNode(circleOfRadius: 50)
    var circleTwo = SKShapeNode(circleOfRadius: 50)
    
    let moveAction = SKAction.moveBy(x: 10, y: 10, duration: 1)
    
    let sprite = SKSpriteNode(color: .gray, size: CGSize(width: 100, height: 100))
    
    override func didMove(to view: SKView) {
        
        circleOne.fillColor = .white
        circleOne.position = self.view!.center
        addChild(circleOne)
        
        circleTwo.fillColor = .blue
        circleTwo.position = CGPoint(x: 414, y: 448)
        addChild(circleTwo)
        
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        circleOne.physicsBody = SKPhysicsBody(circleOfRadius: 50)
        circleOne.physicsBody?.affectedByGravity = true
        
        circleTwo.physicsBody = SKPhysicsBody(circleOfRadius: 50)
        circleTwo.physicsBody?.affectedByGravity = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            let smallCircle = SKShapeNode(circleOfRadius: 50)
            smallCircle.position = location
            smallCircle.fillColor = UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1)
            smallCircle.physicsBody = SKPhysicsBody(circleOfRadius: 50)
            smallCircle.physicsBody?.affectedByGravity = true
            
            self.addChild(smallCircle)
        }
    }
}
