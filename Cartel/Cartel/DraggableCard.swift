
import UIKit

class DraggableCard : UIImageView
{
    var dragCenterOffset : CGPoint?
    var card:Card
    let smallSize = CGSize(width: 100, height: 150)
    let bigSize = CGSize(width: 150, height: 225)
    
    init(_ card:Card!) {
        self.card = card
        super.init(image: card.image)
        
        self.isUserInteractionEnabled = true
        
        let black = UIColor.black.cgColor
        layer.shadowColor = black
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 2
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {

            let locationInView = touch.location(in: superview)
            dragCenterOffset = CGPoint(x: locationInView.x - center.x, y: locationInView.y - center.y)
            
            layer.shadowOffset = CGSize(width: 0, height: 20)
            layer.shadowOpacity = 0.3
            layer.shadowRadius = 6
            self.frame.size = bigSize
        }
        super.touchesBegan(touches, with: event)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let locationInView = touch.location(in: superview)
            
            UIView.animate(withDuration: 0.1) {
                self.center = CGPoint(x: locationInView.x - self.dragCenterOffset!.x,
                                      y: locationInView.y - self.dragCenterOffset!.y)
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
        self.frame.size = smallSize
        self.center = touches.first?.location(in: self.superview) ?? CGPoint(x: 0, y: 0)
        super.touchesEnded(touches, with: event)
    }
}
