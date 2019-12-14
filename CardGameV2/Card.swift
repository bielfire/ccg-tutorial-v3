/**
 * Copyright (c) 2016 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import SpriteKit

final class Card: SKSpriteNode {
    
    var damage = 0
    let damageLabel: SKLabelNode
    let cardType: CardType
    var frontTexture: SKTexture!
    let backTexture: SKTexture
    var faceUp = true
    var enlarged = false
    var savedPosition = CGPoint.zero
    var largeTexture: SKTexture!
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    init(cardType: CardType) {
        self.cardType = cardType
        backTexture = SKTexture(imageNamed: "card_back")
        frontTexture = cardType.texture
        largeTexture = cardType.largeTexture
        
        damageLabel = SKLabelNode(fontNamed: "OpenSans-Bold")
        damageLabel.name = "damageLabel"
        damageLabel.fontSize = 12
        damageLabel.fontColor = SKColor(red: 0.47, green: 0.0, blue: 0.0, alpha: 1.0)
        damageLabel.text = "0"
        damageLabel.position = CGPoint(x: 25, y: 40)
        
        super.init(texture: frontTexture, color: .clear, size: frontTexture.size())
        addChild(damageLabel)
    }
    
    func flip() {
        if faceUp {
            self.texture = backTexture
            damageLabel.isHidden = true
        }
            
        else {
            self.texture = frontTexture
            damageLabel.isHidden = false
        }
        
        faceUp = !faceUp
    }
    
    func enlarge() {
        if enlarged {
            let slide = SKAction.move(to: savedPosition, duration:0.3)
            let scaleDown = SKAction.scale(to: 1.0, duration:0.3)
            run(SKAction.group([slide, scaleDown])) {
                self.enlarged = false
                self.zPosition = CardLevel.board.rawValue
            }
        }
            
        else {
            enlarged = true
            savedPosition = position
            
            texture = largeTexture
            zPosition = CardLevel.enlarged.rawValue
            
            if let parent = parent {
                removeAllActions()
                zRotation = 0
                let newPosition = CGPoint(x: parent.frame.midX, y: parent.frame.midY)
                let slide = SKAction.move(to: newPosition, duration:0.3)
                let scaleUp = SKAction.scale(to: 5.0, duration:0.3)
                run(SKAction.group([slide, scaleUp]))
            }
        }
    }
    
    func toggleWiggle(_ doWiggle: Bool) {
           if doWiggle == false {
               let wiggleIn = SKAction.scaleX(to: 1.0, duration: 0.2)
               let wiggleOut = SKAction.scaleX(to: 1.2, duration: 0.2)
               let wiggle = SKAction.sequence([wiggleIn, wiggleOut])
               
               run(SKAction.repeatForever(wiggle), withKey: "wiggle")
               zPosition = CardLevel.moving.rawValue
               removeAction(forKey: "drop")
               run(SKAction.scale(to: 1.3, duration: 0.25), withKey: "pickup")
            
           } else {
               zPosition = CardLevel.board.rawValue
               removeAction(forKey: "wiggle")
               removeAction(forKey: "pickup")
               run(SKAction.scale(to: 1.0, duration: 0.25), withKey: "drop")
           }
       }
    
}
