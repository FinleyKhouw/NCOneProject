//
//  GameSceneOne.swift
//  NCOneProject
//
//  Created by Finley Khouwira on 20/05/19.
//  Copyright © 2019 Finley Khouwira. All rights reserved.
//

import SpriteKit
import GameplayKit

class LevelOne: SKScene, SKPhysicsContactDelegate {
    
    var redPad = SKSpriteNode()
    var bluePad = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        
            self.physicsWorld.contactDelegate = self
            
            ball = childNode(withName: BallName) as! SKSpriteNode
            yellowFinish = childNode(withName: YellowFinishName) as! SKSpriteNode
//            bluePad = childNode(withName: BluePadName) as! SKSpriteNode
            
            
            ball.name = BallName
//            bluePad.name = BluePadName
            
            yellowFinishSetting()
//            bluePadSetting()
            ballSetting()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // To run the ball
        for touch in touches {
            let touch: UITouch = touches.first! as UITouch
            let location = touch.location(in: self)
            let touchedNode = self.atPoint(location)
            
            if (touchedNode.name == "BluePad1") {
                let padClicked = SKAction.run {
                    self.bluePad.zRotation += CGFloat(Double.pi / 2)
                }
                bluePad.run(padClicked)
            } else if (touchedNode.name == BallName) {
                    let ballStart = SKAction.run {
                        ball.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 20))
                        self.isUserInteractionEnabled = false
                    }
                    ball.run(ballStart)
                }
            }
        }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let firstBody = contact.bodyA.node as! SKSpriteNode
        let secondBody = contact.bodyB.node as! SKSpriteNode
        
        if ((firstBody.name == "BluePad1") && (secondBody.name == BallName)) || ((firstBody.name == BallName) && (secondBody.name == "BluePad1")){
            print("touched")
        }
        
        if ((firstBody.name == BallName) && (secondBody.name == YellowFinishName)) || ((firstBody.name == YellowFinishName) && (secondBody.name == BallName)) {
            changeSceneOverall()
            print("finished")
        }
    }
    
    func bluePadSetting(pad: SKSpriteNode, nodeName: String) {
        pad.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: pad.size.width, height: 0.1))
        pad.physicsBody?.categoryBitMask = PhysicsCategory.PadCategory
        pad.physicsBody?.collisionBitMask = PhysicsCategory.BallCategory
        pad.physicsBody?.contactTestBitMask = PhysicsCategory.BallCategory
        pad.name = nodeName
        pad.physicsBody?.isDynamic = false
        pad.physicsBody?.affectedByGravity = false
    }
    
    func yellowFinishSetting() {
        yellowFinish.physicsBody?.categoryBitMask = PhysicsCategory.FinishCategory
        yellowFinish.physicsBody?.contactTestBitMask = PhysicsCategory.BallCategory
        yellowFinish.name = YellowFinishName
        yellowFinish.physicsBody = SKPhysicsBody(rectangleOf: yellowFinish.size)
        yellowFinish.physicsBody?.affectedByGravity = false
        yellowFinish.physicsBody?.isDynamic = false
    }
    
    func ballSetting() {
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2)
        ball.physicsBody?.categoryBitMask = PhysicsCategory.BallCategory
        ball.physicsBody?.collisionBitMask = PhysicsCategory.PadCategory
        ball.physicsBody?.contactTestBitMask =
            PhysicsCategory.PadCategory |
            PhysicsCategory.FinishCategory
        ball.name = BallName
        ball.zPosition = -1
        ball.physicsBody?.isDynamic = true
        ball.physicsBody?.affectedByGravity = false
        ball.physicsBody?.allowsRotation = false
        ball.physicsBody?.restitution = 1
        ball.physicsBody?.friction = 0
    }
    
    func changeSceneOverall() {
        ball.removeAllActions()
        let fadeIn = SKAction.scale(to: 0, duration: 0.1)
        let ballIsGone = SKAction.fadeAlpha(to: 0, duration: 2)
        let ballSequence = SKAction.sequence([fadeIn, ballIsGone])
        ball.run(ballSequence)
        
        let changeLineColor = SKAction.colorize(with: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), colorBlendFactor: 0.5, duration: 1)
        yellowFinish.run(changeLineColor)
        
        let wait = SKAction.wait(forDuration: 2)
        let spawn = SKAction.run {
            self.removeAllChildren()
            self.removeFromParent()
        }
        let changeScene = SKAction.run {
            let transition = SKTransition.crossFade(withDuration: 1)
            let scene = LevelTwo(fileNamed: "LevelTwo")
            scene?.scaleMode = .aspectFill
            self.scene?.view?.presentScene(scene!, transition: transition)
        }
        let sequence = SKAction.sequence([wait, spawn, changeScene])
        run(sequence)
    }
}
