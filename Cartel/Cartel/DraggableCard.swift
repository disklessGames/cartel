
import UIKit

class DraggableCard: UIImageView {
    var dragCenterOffset = CGPoint(x: 0, y: 0)
    var card: Card

    init(_ card: Card!) {
        self.card = card
        super.init(image: card.image)

        isUserInteractionEnabled = true
        setSmallShadow()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            enlarge()

            let locationInView = touch.location(in: superview)
            let x = locationInView.x - center.x
            let y = locationInView.y - center.y
            dragCenterOffset = CGPoint(x: x, y: y)

        }
        super.touchesBegan(touches, with: event)
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let locationInView = touch.location(in: superview)
            let offset = dragCenterOffset
            
            UIView.animate(withDuration: 0.1) {
                self.center = CGPoint(x: locationInView.x - offset.x,
                                      y: locationInView.y - offset.y)
            }
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // TODO: implement card drop
        // check if destination valid
        //  add to new position
        // else return to hand
        setSmallShadow()
        frame.size = Card.smallSize
        center = touches.first!.location(in: superview)
        super.touchesEnded(touches, with: event)
    }

    private func setSmallShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 2
    }

    private func enlarge() {
        self.frame.size = Card.bigSize
        layer.shadowOffset = CGSize(width: 0, height: 20)
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 6
    }
}
