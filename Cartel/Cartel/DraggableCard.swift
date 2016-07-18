//
//  DraggableCard.swift
//  Cartel
//
//  Created by Jannie Theron on 2014/08/27.
//  Copyright (c) 2014 Tuism. All rights reserved.
//

import UIKit

class DraggableCard : UIImageView
{
    var dragStartPositionRelativeToCenter : CGPoint?
    var card:Card
    init(_ card:Card!) {
        self.card = card
        super.init(image: card.image)
        
        self.isUserInteractionEnabled = true
        
        layer.shadowColor = UIColor.black().cgColor
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 2
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func handlePan(_ nizer: UIPanGestureRecognizer!) {
        if nizer.state == UIGestureRecognizerState.began {
            return
        }
        
        if nizer.state == UIGestureRecognizerState.ended {
            dragStartPositionRelativeToCenter = nil
            return
        }
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let locationInView = touch.location(in: superview)
            dragStartPositionRelativeToCenter = CGPoint(x: locationInView.x - center.x, y: locationInView.y - center.y)
            
            layer.shadowOffset = CGSize(width: 0, height: 20)
            layer.shadowOpacity = 0.3
            layer.shadowRadius = 6
        }
        super.touchesBegan(touches, with: event)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let locationInView = touch.location(in: superview)
            
            UIView.animate(withDuration: 0.1) {
                self.center = CGPoint(x: locationInView.x - self.dragStartPositionRelativeToCenter!.x,
                                      y: locationInView.y - self.dragStartPositionRelativeToCenter!.y)
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //TODO implement card drop
        //check if destination valid
        //  add to new position
        //else return to hand
        
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 2
        super.touchesEnded(touches, with: event)
    }
}
