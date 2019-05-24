//
//  GameSceneOne.swift
//  NCOneProject
//
//  Created by Finley Khouwira on 20/05/19.
//  Copyright © 2019 Finley Khouwira. All rights reserved.
//

import SpriteKit
import GameplayKit

let BallName = "Ball"
let RedPadName = "RedPad"
let BluePadName = "BluePad"
let YellowFinishName = "YellowFinish"

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
    
        override func didMove(to view: SKView) {
        
            self.physicsWorld.contactDelegate = self
            
            ball = childNode(withName: BallName) as! SKSpriteNode
            yellowFinish = childNode(withName: YellowFinishName) as! SKSpriteNode
            bluePad = childNode(withName: BluePadName) as! SKSpriteNode
            
            ball.zPosition = -1
            yellowFinish.zPosition = 4
            
            yellowFinishSetting()
            bluePadSetting()
            ballSetting()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // To run the ball
        for touch in touches {
            let location = touch.location(in: self)
            
            ballSetting()
            
            let ballStart = SKAction.run {
                ball.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 40))
            }
            ball.run(ballStart)
        }
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let firstBody = contact.bodyA.node as! SKSpriteNode
        let secondBody = contact.bodyB.node as! SKSpriteNode
        
        if ((firstBody.name == BluePadName) && (secondBody.name == BallName)) {
            print("touched")
            collisionPadAndBall(Pad: firstBody, Ball: secondBody)
        } else if ((firstBody.name == BallName) && (secondBody.name == BluePadName)) {
            print("touched1")
            collisionPadAndBall(Pad: secondBody, Ball: firstBody)
        }
        
        if ((firstBody.name == BallName) && (secondBody.name == YellowFinishName)) || ((firstBody.name == YellowFinishName) && (secondBody.name == BallName)) {
            print("finished")
        }
    }
    
    func collisionPadAndBall(Pad: SKSpriteNode, Ball: SKSpriteNode) {
        Pad.color = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
//        Ball.physicsBody?.isDynamic = false
        
        Pad.removeAllActions()
    }
    
    func bluePadSetting() {
        bluePad.physicsBody = SKPhysicsBody(rectangleOf: bluePad.size)
        bluePad.physicsBody?.categoryBitMask = PhysicsCategory.PadCategory
        bluePad.physicsBody?.collisionBitMask = PhysicsCategory.BallCategory
        bluePad.physicsBody?.contactTestBitMask = PhysicsCategory.BallCategory
        bluePad.name = BluePadName
//        bluePad.physicsBody?.restitution = 0
//        bluePad.physicsBody?.friction = 0
        bluePad.physicsBody?.isDynamic = false
        bluePad.physicsBody?.affectedByGravity = false
    }
    
    func yellowFinishSetting() {
        yellowFinish.physicsBody?.categoryBitMask = PhysicsCategory.FinishCategory
        yellowFinish.physicsBody?.contactTestBitMask = PhysicsCategory.BallCategory
        yellowFinish.zPosition = 1
        yellowFinish.name = YellowFinishName
        yellowFinish.physicsBody = SKPhysicsBody(circleOfRadius: yellowFinish.frame.width / 2)
        yellowFinish.physicsBody?.affectedByGravity = false
        yellowFinish.physicsBody?.isDynamic = false
    }
    
    func ballSetting() {
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2)
        ball.physicsBody?.categoryBitMask = PhysicsCategory.BallCategory
        ball.physicsBody?.collisionBitMask = PhysicsCategory.PadCategory
        ball.physicsBody?.contactTestBitMask = PhysicsCategory.PadCategory | PhysicsCategory.FinishCategory
        ball.name = "Ball"
        ball.zPosition = -1
        ball.physicsBody?.isDynamic = true
        ball.physicsBody?.affectedByGravity = false
        ball.physicsBody?.allowsRotation = false
        ball.physicsBody?.restitution = 1
        ball.physicsBody?.friction = 0
    }
}
