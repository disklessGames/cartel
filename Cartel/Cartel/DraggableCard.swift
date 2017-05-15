
import UIKit

class DraggableCard: UIImageView {
    var card: Card
    var dropCard: ((CGPoint) -> Void)!
    var hasMoved = false
    
    init(_ card: Card) {
        
        self.card = card
        super.init(image: card.image)
        
        isUserInteractionEnabled = true
        shrink()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func animatedShrink() {
        UIView.animate(withDuration: 0.2) {
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
    
    func animatedEnlarge() {
        UIView.animate(withDuration: 0.1) {
            self.enlarge()
        }
    }
    
    private func enlarge() {
        if frame.size != Card.bigSize {
            center = CGPoint(x: center.x, y: center.y - Card.bigSize.height/2)
            frame.size = Card.bigSize
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOffset = CGSize(width: 0, height: 20)
            layer.shadowOpacity = 0.3
            layer.shadowRadius = 6
        }
    }
}
