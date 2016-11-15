
import UIKit

class DraggableCard: UIImageView {
    var dragCenterOffset: CGPoint?
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

            let locationInView = touch.location(in: superview)
            let x = locationInView.x - center.x
            let y = locationInView.y - center.y
            dragCenterOffset = CGPoint(x: x, y: y)

            setBigShadow()
            self.frame.size = Card.bigSize
        }
        super.touchesBegan(touches, with: event)
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let locationInView = touch.location(in: superview)

            UIView.animate(withDuration: 0.1) {
                self.center = CGPoint(x: locationInView.x - (self.dragCenterOffset?.x ?? 0),
                                      y: locationInView.y - (self.dragCenterOffset?.y ?? 0))
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

    private func setBigShadow() {
        layer.shadowOffset = CGSize(width: 0, height: 20)
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 6
    }
}
