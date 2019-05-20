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
    
    var blueCircle = SKShapeNode(circleOfRadius: 60)
    var yellowCircle = SKShapeNode(circleOfRadius: 60)
    var redCircle = SKShapeNode(circleOfRadius: 60)
    
    let colorCollection: [UIColor] = [#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1), #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)]
    
    override func didMove(to view: SKView) {
        
        blueCircle.fillColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        blueCircle.position = self.view!.center
        addChild(blueCircle)
        
        yellowCircle.fillColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        yellowCircle.position = CGPoint(x: 414, y: 400)
        yellowCircle.name = "initial node"
        addChild(yellowCircle)
        
        redCircle.fillColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        redCircle.position = CGPoint(x: 200, y: 400)
        addChild(redCircle)
        
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: CGRect(x: 0, y: 0, width: self.frame.width, height: 5000))
        
        blueCircle.physicsBody = SKPhysicsBody(circleOfRadius: 60)
        blueCircle.physicsBody?.affectedByGravity = true
        
        yellowCircle.physicsBody = SKPhysicsBody(circleOfRadius: 60)
        yellowCircle.physicsBody?.affectedByGravity = true
        
        redCircle.physicsBody = SKPhysicsBody(circleOfRadius: 60)
        redCircle.physicsBody?.affectedByGravity = true
        
        for i in 0...20{
            let smallCircle = SKShapeNode(circleOfRadius: 60)
            smallCircle.position = CGPoint(x: CGFloat.random(in: 100...300), y: CGFloat.random(in: 1000...1500))
            smallCircle.fillColor = colorCollection[Int.random(in: 0...2)]
            smallCircle.physicsBody = SKPhysicsBody(circleOfRadius: 60)
            smallCircle.physicsBody?.affectedByGravity = true

            addChild(smallCircle)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let fixedPosition = CGPoint(x: CGFloat(self.view!.center.x), y: (self.view!.center.y))
            
            let touchedNode = atPoint(location)
            if (touchedNode.name == "initial node") {
                print("testing yo")
                yellowCircle.position = fixedPosition
                yellowCircle.physicsBody = nil
                physicsWorld.gravity = CGVector(dx: 0, dy: 3)
                
                SKAction.wait(forDuration: 3)
                
                smallCircle.removeAllChildren()
                smallCircle.removeFromParent()
                anotherSmallCircle.removeAllChildren()
                anotherSmallCircle.removeFromParent()
            } else {
                anotherSmallCircle = SKShapeNode(circleOfRadius: 60)
                anotherSmallCircle.position = location
                anotherSmallCircle.fillColor = colorCollection[Int.random(in: 0...2)]
                anotherSmallCircle.physicsBody = SKPhysicsBody(circleOfRadius: 60)
                anotherSmallCircle.physicsBody?.affectedByGravity = true
                self.addChild(anotherSmallCircle)
            }
        }
        
//        for yellowTouch in touches {
//            let location = touches.location(in: self)
//            let touchedNode = atPoint(location)
//
//
//            if touchedNode == "yellowCircle" {
//            yellowCircle.position = fixedPosition
//    }
        
    }
}


