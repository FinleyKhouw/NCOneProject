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

    
    var smallCircle = SKShapeNode()
    var anotherSmallCircle = SKShapeNode()
    var finishedNode: Bool? = false
    var doneScene: Bool? = false
    
    var blueCircle = SKShapeNode(circleOfRadius: 30)
    var yellowCircle = SKShapeNode(circleOfRadius: 30)
    var redCircle = SKShapeNode(circleOfRadius: 30)
    
    let colorCollection: [UIColor] = [#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)]
    
    override func didMove(to view: SKView) {
        
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: CGRect(x: 0, y: 0, width: self.frame.width, height: 4000))
        self.backgroundColor = .white
        
        blueCircle.fillColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        blueCircle.position = CGPoint(x: 414, y: 1200)
        addChild(blueCircle)
        
        yellowCircle.fillColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        yellowCircle.position = CGPoint(x: Int.random(in: 0...414), y: 1200)
        yellowCircle.name = "initial node"
        addChild(yellowCircle)
        
        redCircle.fillColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        redCircle.position = CGPoint(x: 200, y: 1200)
        addChild(redCircle)
        
        blueCircle.physicsBody = SKPhysicsBody(circleOfRadius: 30)
        blueCircle.physicsBody?.affectedByGravity = true
        
        yellowCircle.physicsBody = SKPhysicsBody(circleOfRadius: 30)
        yellowCircle.physicsBody?.affectedByGravity = true
        
        redCircle.physicsBody = SKPhysicsBody(circleOfRadius: 30)
        redCircle.physicsBody?.affectedByGravity = true
        
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
            let wait = SKAction.wait(forDuration: 2)
            let location = touch.location(in: self)
            let fixedPosition = CGPoint(x: CGFloat(self.view!.center.x), y: (self.view!.center.y))
            
            let touchedNode = atPoint(location)
            if (touchedNode.name == "initial node") {
                if finishedNode == false {
                    let moveToPoint = SKAction.move(to: fixedPosition, duration: 1)
                    moveToPoint.timingMode = .easeInEaseOut
                    yellowCircle.run(moveToPoint)
                    yellowCircle.physicsBody = nil
                    physicsWorld.gravity = CGVector(dx: 0, dy: 3)
                    
                    finishedNode = true
                } else if finishedNode == true {
                    let wait = SKAction.wait(forDuration: 2)
                    let spawn = SKAction.run {
                        self.removeAllChildren()
                        
                        self.addChild(self.yellowCircle)
                    }
                    let sequence = SKAction.sequence([spawn, wait])
//                    let otherSequence = SKAction.sequence([sequence, wait])
                    run(sequence)
                
                    self.physicsBody = SKPhysicsBody(edgeLoopFrom: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
                    self.physicsWorld.gravity = CGVector(dx: 0, dy: -9.8)
                
                    yellowCircle.physicsBody = SKPhysicsBody(circleOfRadius: 30)
                    yellowCircle.physicsBody?.affectedByGravity = true
                    
                    self.finishedNode = nil
                } else if doneScene == false {
                    let moveYellowCircle = SKAction.run {
                        let moveToPoint = SKAction.move(to: fixedPosition, duration: 1)
                        moveToPoint.timingMode = .easeInEaseOut
                        self.yellowCircle.run(moveToPoint)
                        self.yellowCircle.physicsBody = nil
                    }
                    let ballIsGone = SKAction.fadeAlpha(to: 0, duration: 2)
                    let wait = SKAction.wait(forDuration: 3)
                    let spawn = SKAction.run {
                        self.removeAllChildren()
                        self.removeFromParent()
                    }
                    let changeScene = SKAction.run {
                        let transition = SKTransition.crossFade(withDuration: 1)
                        let sceneOne = GameSceneOne()
                        self.view?.presentScene(sceneOne, transition: transition)
                    }
                    let sequence = SKAction.sequence([moveYellowCircle, wait, ballIsGone, wait, spawn, changeScene])
                    run(sequence)
                    
                    doneScene = nil
                }
            } else {
                if finishedNode == false {
                anotherSmallCircle = SKShapeNode(circleOfRadius: 30)
                anotherSmallCircle.position = location
                anotherSmallCircle.fillColor = colorCollection[Int.random(in: 0...1)]
                anotherSmallCircle.physicsBody = SKPhysicsBody(circleOfRadius: 30)
                anotherSmallCircle.physicsBody?.affectedByGravity = true
                self.addChild(anotherSmallCircle)
                }
        }
    }
    }
}
