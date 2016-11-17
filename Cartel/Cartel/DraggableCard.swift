
import UIKit

class DraggableCard: UIImageView {
    var dragCenterOffset = CGPoint(x: 0, y: 0)
    var card: Card
    var shrinkTimer: Timer?
    
    init(_ card: Card!) {
        self.card = card
        super.init(image: card.image)
        
        isUserInteractionEnabled = true
        enlarge()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        enlarge()
        super.touchesBegan(touches, with: event)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: superview?.window)
            enlarge()
            startShrinkTimer()
            UIView.animate(withDuration: 0.4) {
                            self.center = CGPoint(x: location.x,
                                                  y: location.y)
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // TODO: implement card drop
        // check if destination valid
        //  add to new position
        // else return to hand
        super.touchesEnded(touches, with: event)
        shrink()
        let offset = dragCenterOffset
        
        let location = touches.first!.location(in: superview)
        center = CGPoint(x: location.x + offset.x,
                         y: location.y + offset.y)
    }
    
    private func startShrinkTimer() {
        shrinkTimer?.invalidate()
        shrinkTimer = nil
        shrinkTimer = Timer.scheduledTimer(withTimeInterval: 1,
                                           repeats: false) { [weak self] (timer) in
                                self?.shrink()
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
