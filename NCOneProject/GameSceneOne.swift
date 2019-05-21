//
//  GameSceneOne.swift
//  NCOneProject
//
//  Created by Finley Khouwira on 20/05/19.
//  Copyright © 2019 Finley Khouwira. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameSceneOne: SKScene, BoxDelegate {
            
            var box = Box()
            var box2 = Box()
            var box3 = Box()
            
            override func didMove(to view: SKView) {
                
                box = Box(color: .white, size: CGSize(width: 200, height: 200))
                box.zPosition = 1
                box.position = CGPoint(x: 0 - 900, y: 400)
                box.name = "white box"
                box.boxDelegate = self
                addChild(box)
                
                box2 = Box(color: .blue, size: CGSize(width: 200, height: 200))
                box2.zPosition = 1
                box2.name = "blue box"
                box2.position = CGPoint(x: 0 - 600, y: 400)
                box2.boxDelegate = self
                addChild(box2)
                
                box3 = Box(color: .red, size: CGSize(width: 200, height: 200))
                box3.zPosition = 1
                box3.name = "red box"
                box3.position = CGPoint(x: -300, y: 400)
                box3.boxDelegate = self
                addChild(box3)
            }
            
            func boxSwiped(box: Box) {
                let currentObject = box
                print("currentObject \(currentObject)")
            }
            
            override func update(_ currentTime: TimeInterval) {
                box.moveWithCamera()
                box2.moveWithCamera()
                box3.moveWithCamera()
            }
}

protocol BoxDelegate: NSObjectProtocol {
    func boxSwiped(box: Box)
}

class Box: SKSpriteNode {
    
    weak var boxDelegate: BoxDelegate!
    private var moveAmtX: CGFloat = 0
    private var moveAmtY: CGFloat = 0
    private let minimum_detect_distance: CGFloat = 100
    private var initialPosition: CGPoint = CGPoint.zero
    private var initialTouch: CGPoint = CGPoint.zero
    private var resettingSlider = false
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        
        super.init(texture: texture, color: color, size: size)
        
        self.isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func moveWithCamera() {
        self.position.x += 5
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let touch = touches.first as UITouch? {
            
            initialTouch = touch.location(in: self.scene!.view)
            moveAmtY = 0
            moveAmtX = 0
            initialPosition = self.position
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let touch = touches.first as UITouch? {
            
            let movingPoint: CGPoint = touch.location(in: self.scene!.view)
            
            moveAmtX = movingPoint.x - initialTouch.x
            moveAmtY = movingPoint.y - initialTouch.y
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        var direction = ""
        if abs(moveAmtX) > minimum_detect_distance {
            
            //must be moving side to side
            if moveAmtX < 0 {
                direction = "left"
            }
            else {
                direction = "right"
            }
        }
        else if abs(moveAmtY) > minimum_detect_distance {
            
            //must be moving up and down
            if moveAmtY < 0 {
                direction = "up"
            }
            else {
                direction = "down"
            }
        }
        
        print("object \(self.name!) swiped " + direction)
        
        self.boxDelegate.boxSwiped(box: self)
    }
}
