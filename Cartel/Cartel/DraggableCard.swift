
import UIKit

class DraggableCard: UIImageView {
    var card: Card
    var dropCard: ((CGPoint) -> Void)!
    var cancel: (() -> Void)!
    var hasMoved = false
    
    init(_ card: Card) {
        self.card = card
        super.init(image: card.image)
        
        isUserInteractionEnabled = true
        animatedEnlarge()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        animatedEnlarge()
        super.touchesBegan(touches, with: event)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: superview?.window)
            animatedShrink()
            hasMoved = true
            UIView.animate(withDuration: 0.2) {
                self.center = CGPoint(x: location.x,
                                      y: location.y)
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        shrink()

        if hasMoved {
            let location = touches.first!.location(in: superview)
            dropCard?(location)
        } else {
            cancel()
        }
    }
    
    private func animatedShrink() {
        UIView.animate(withDuration: 0.3) {
            self.shrink()
        }
    }
    
    private func shrink() {
        let oldCenter = center
        self.frame.size = Card.smallSize
        center = oldCenter
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 2
    }
    
    private func animatedEnlarge() {
        UIView.animate(withDuration: 0.1) {
            self.enlarge()
        }
    }
    
    private func enlarge() {
        if self.frame.size != Card.bigSize {
            self.frame.size = Card.bigSize
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOffset = CGSize(width: 0, height: 20)
            layer.shadowOpacity = 0.3
            layer.shadowRadius = 6
        }
    }
}
