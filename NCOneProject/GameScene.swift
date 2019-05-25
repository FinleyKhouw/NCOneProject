//
//  GameScene.swift
//  NCOneProject
//
//  Created by Finley Khouwira on 20/05/19.
//  Copyright © 2019 Finley Khouwira. All rights reserved.
//

import SpriteKit
import GameplayKit

var BallName = "Ball"
var YellowFinishName = "FinishLine"

var ball = SKSpriteNode()
var yellowFinish = SKSpriteNode()

struct PhysicsCategory {
    static let BallCategory    : UInt32 = 0x1 << 0
    static let PadCategory     : UInt32 = 0x1 << 1
    static let FinishCategory  : UInt32 = 0x1 << 2
}

class GameScene: SKScene {
    var smallCircle = SKShapeNode()
    var anotherSmallCircle = SKShapeNode()
    var finishedNode: Bool? = false
    var doneScene: Bool? = false
    
    var blueCircle = SKShapeNode(circleOfRadius: 30)
    var yellowCircle = SKShapeNode(circleOfRadius: 30)
    var redCircle = SKShapeNode(circleOfRadius: 30)
    
    let colorCollection: [UIColor] = [#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)]
    
    override func didMove(to view: SKView) {
        // for border and background color
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: CGRect(x: 0, y: 0, width: self.frame.width, height: 4000))
        self.backgroundColor = .white
        
        // starting ball
        
        yellowCircle.fillColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        yellowCircle.position = CGPoint(x: Int.random(in: 0...414), y: 1200)
        yellowCircle.name = "initial node"
        addChild(yellowCircle)
        
        yellowCircle.physicsBody = SKPhysicsBody(circleOfRadius: 30)
        yellowCircle.physicsBody?.affectedByGravity = true
        
        // generate balls
        for _ in 0...90 {
            let smallCircle = SKShapeNode(circleOfRadius: 30)
            smallCircle.position = CGPoint(x: CGFloat.random(in: 100...300), y: CGFloat.random(in: 1000...1500))
            smallCircle.fillColor = colorCollection[Int.random(in: 0...1)]
            smallCircle.physicsBody = SKPhysicsBody(circleOfRadius: 30)
            smallCircle.physicsBody?.affectedByGravity = true

            addChild(smallCircle)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let fixedPosition = CGPoint(x: CGFloat(self.view!.center.x), y: (self.view!.center.y))
            
            let touchedNode = atPoint(location)
            
            /* if (touchedNode.name == "initial node") {
                if finishedNode == false {
                    // move yellow circle to center
                    let moveToPoint = SKAction.move(to: fixedPosition, duration: 1)
                    moveToPoint.timingMode = .easeInEaseOut
                    yellowCircle.run(moveToPoint)
                    yellowCircle.physicsBody = nil
                    physicsWorld.gravity = CGVector(dx: 0, dy: 3)
                    
                    finishedNode = true
                } else if finishedNode == true {
                    // drop yellow circle
                    let wait = SKAction.wait(forDuration: 2)
                    let spawn = SKAction.run {
                        self.removeAllChildren()
                        
                        self.addChild(self.yellowCircle)
                    }
                    let sequence = SKAction.sequence([spawn, wait])
                    run(sequence)
                
                    self.physicsBody = SKPhysicsBody(edgeLoopFrom: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
                    self.physicsWorld.gravity = CGVector(dx: 0, dy: -9.8)
                
                    yellowCircle.physicsBody = SKPhysicsBody(circleOfRadius: 30)
                    yellowCircle.physicsBody?.affectedByGravity = true
                    
                    self.finishedNode = nil
                } else */ if doneScene == false {
                    // move again and gone
                    let moveYellowCircle = SKAction.run {
                        let moveToPoint = SKAction.move(to: fixedPosition, duration: 1)
                        moveToPoint.timingMode = .easeInEaseOut
                        self.yellowCircle.run(moveToPoint)
                        self.yellowCircle.physicsBody = nil
                    }
                    let ballIsGone = SKAction.fadeAlpha(to: 0, duration: 2)
                    let wait = SKAction.wait(forDuration: 1)
                    let spawn = SKAction.run {
                        self.removeAllChildren()
                        self.removeFromParent()
                    }
                    let changeScene = SKAction.run {
                        let transition = SKTransition.crossFade(withDuration: 1)
                        let scene = LevelOne(fileNamed: "LevelOne")
                        scene?.scaleMode = .aspectFill
                        self.scene?.view?.presentScene(scene!, transition: transition)
                    }
                    let sequence = SKAction.sequence([moveYellowCircle, wait, ballIsGone, wait, spawn, changeScene])
                    run(sequence)
                    
                    doneScene = nil
                }
            } /* else {
                // click to generate ball and balls
                if finishedNode == false {
                anotherSmallCircle = SKShapeNode(circleOfRadius: 30)
                anotherSmallCircle.position = location
                anotherSmallCircle.fillColor = colorCollection[Int.random(in: 0...1)]
                anotherSmallCircle.physicsBody = SKPhysicsBody(circleOfRadius: 30)
                anotherSmallCircle.physicsBody?.affectedByGravity = true
                self.addChild(anotherSmallCircle)
                }
        }
    }*/
    }
}
