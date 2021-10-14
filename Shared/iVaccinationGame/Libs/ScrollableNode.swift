//
//  ScrollableNode.swift
//  iVaccinationGame
//
//  Created by Kim David Hauser on 14.10.21.
//

import Foundation
import SpriteKit
#if os(iOS)
import UIKit
#endif
//  Your converted code is limited to 2 KB.
//  Refill your credit or upgrade your plan to remove this limitation.
//
//  Converted to Swift 5.5 by Swiftify v5.5.22755 - https://swiftify.com/
//
//  JADSKScrollingNode.m
//  FirstLetters
//
//  Created by Jennifer Dobson on 7/25/14.
//  Copyright (c) 2014 Jennifer Dobson. All rights reserved.
//

private let kScrollDuration: CGFloat = 0.3

func mult(_ v: CGPoint, _ s: CGFloat) -> CGPoint {
    return CGPoint(x: v.x * s, y: v.y * s)
}

class JADSKScrollingNode:SKNode, UIGestureRecognizerDelegate {
    
    var size:CGSize = CGSize(width: 0, height: 0)
//    private var minYPosition: CGFloat = 0.0
//    private var maxYPosition: CGFloat = 0.0
//    private var gestureRecognizer: UIPanGestureRecognizer?
//    private var yOffset: CGFloat = 0.0
    
    private var minYPosition: CGFloat {
        let parentSize = parent!.frame.size


        let minPosition = parentSize.height - calculateAccumulatedFrame().size.height - yOffset

        return minPosition
    }

    private var maxYPosition: CGFloat {
        return 0
    }
    private var gestureRecognizer: UIPanGestureRecognizer?
    private var yOffset: CGFloat = 0.0

    init(size: CGSize) {
        super.init()

        self.size = size
        yOffset = calculateAccumulatedFrame().origin.y

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func addChild(_ node: SKNode?) {
        if let node = node {
            super.addChild(node)
        }
        yOffset = calculateAccumulatedFrame().origin.y
    }

    func scrollToBottom() {
        position = CGPoint(x: 0, y: maxYPosition)

    }

    func scrollToTop() {
        position = CGPoint(x: 0, y: minYPosition)

    }

    func enableScrolling(on view: UIView?) {
        if gestureRecognizer == nil {
            gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan(from:)))
            gestureRecognizer?.delegate = self
            if let gestureRecognizer = gestureRecognizer {
                view?.addGestureRecognizer(gestureRecognizer)
            }
        }
    }

    func disableScrolling(on view: UIView?) {
        if gestureRecognizer != nil {
            if let gestureRecognizer = gestureRecognizer {
                view?.removeGestureRecognizer(gestureRecognizer)
            }
            gestureRecognizer = nil
        }
    }

    @objc func handlePan(from recognizer: UIPanGestureRecognizer?) {
        if recognizer?.state == .began {

        } else if recognizer?.state == .changed {

            var translation = recognizer?.translation(in: recognizer?.view)
            translation = CGPoint(x: translation?.x ?? 0.0, y: -(translation?.y ?? 0.0))
            pan(forTranslation: translation ?? CGPoint.zero)
            recognizer?.setTranslation(CGPoint.zero, in: recognizer?.view)
        } else if recognizer?.state == .ended {

            let velocity = recognizer?.velocity(in: recognizer?.view)
            let pos = position
            let p = mult(velocity ?? CGPoint.zero, kScrollDuration)

            var newPos = CGPoint(x: pos.x, y: pos.y - p.y)
            newPos = constrainStencilNodesContainerPosition(newPos)

            let moveTo = SKAction.move(to: newPos, duration: kScrollDuration)
            //SKAction *moveMask = [SKAction moveTo:[self maskPositionForNodePosition:newPos] duration:kScrollDuration];
            moveTo.timingMode = .easeOut
            //[moveMask setTimingMode:SKActionTimingEaseOut];
            run(moveTo)
            //[self.maskNode runAction:moveMask];
        }

    }

    func pan(forTranslation translation: CGPoint) {
        position = CGPoint(x: position.x, y: position.y + translation.y)
    }

    func constrainStencilNodesContainerPosition(_ position: CGPoint) -> CGPoint {

        var retval = position

        retval.x = self.position.x

        retval.y = CGFloat(max(retval.y, minYPosition))
        retval.y = CGFloat(min(retval.y, maxYPosition))


        return retval
    }

    func mult(_ v: CGPoint, _ s: CGFloat) -> CGPoint {
        return CGPoint(x: v.x * s, y: v.y * s)
    }


    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        var grandParent = parent?.parent

        if grandParent == nil {
            grandParent = parent
        }
        var touchLocation: CGPoint? = nil
        if let grandParent = grandParent {
            touchLocation = touch.location(in: grandParent)
        }

        if !parent!.frame.contains(touchLocation ?? CGPoint.zero) {
            return false
        }

        return true
    }
}
