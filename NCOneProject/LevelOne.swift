//
//  GameSceneOne.swift
//  NCOneProject
//
//  Created by Finley Khouwira on 20/05/19.
//  Copyright © 2019 Finley Khouwira. All rights reserved.
//

import SpriteKit
import GameplayKit

let BallCategoryName = "Ball"
let RedPadCategoryName = "RedPad"
let BluePadCategoryName = "BluePad"
let YellowFinishCategoryName = "YellowFinish"

struct PhysicsCategory {
    static let BallCategory    : UInt32 = 0x1 << 0
    static let PadCategory     : UInt32 = 0x1 << 1
    static let FinishCategory  : UInt32 = 0x1 << 2
}


var ball = SKSpriteNode()
var redPad = SKSpriteNode()
var bluePad = SKSpriteNode()
var yellowFinish = SKSpriteNode()

class LevelOne: SKScene, SKPhysicsContactDelegate {
        var hit = 0
    
        override func didMove(to view: SKView) {
        
            self.physicsWorld.contactDelegate = self
            
            ball = childNode(withName: BallCategoryName) as! SKSpriteNode
            yellowFinish = childNode(withName: YellowFinishCategoryName) as! SKSpriteNode
            bluePad = childNode(withName: BluePadCategoryName) as! SKSpriteNode
            
//            yellowFinish.physicsBody = SKPhysicsBody(circleOfRadius: yellowFinish.frame.width / 2)
//            yellowFinish.physicsBody?.affectedByGravity = false
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // To run the ball
        for touch in touches {
            let location = touch.location(in: self)
            
            let ballStart = SKAction.run {
                ball.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 40))
            }
            ball.run(ballStart)
            
            
            
            ball.physicsBody?.categoryBitMask = PhysicsCategory.BallCategory
            yellowFinish.physicsBody?.categoryBitMask = PhysicsCategory.FinishCategory
            ball.physicsBody?.contactTestBitMask = PhysicsCategory.FinishCategory
            ball.name = "Ball"
            ball.physicsBody?.isDynamic = true
        }
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let firstBody = contact.bodyA.node as! SKSpriteNode
        let secondBody = contact.bodyB.node as! SKSpriteNode
        
        
    }
    
    
}
