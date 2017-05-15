
import UIKit

class InputView: UIView {
    
    var draggingCard: DraggableCard?
    var isDragging = false
    var initialTouch: CGPoint?
    
    var gameViewController: GameViewController? {
        didSet {
            draggingCard = nil
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: superview?.window)
            initialTouch = location
            let card = gameViewController?.card(at: location)
            startDragging(card: card, at: location)
        }
        super.touchesBegan(touches, with: event)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first,
            let _ = draggingCard {
            let location = touch.location(in: superview?.window)
            if isDragging {
                draggingCard?.animatedShrink()
                
                UIView.animate(withDuration: 0.2) {
                    self.draggingCard?.center = CGPoint(x: location.x,
                                                        y: location.y)
                }
            } else {
                isDragging = shouldStartDragging(point: location)
            }
        }
        super.touchesMoved(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        draggingCard?.animatedShrink()
        
        let location = touches.first!.location(in: superview)
        draggingCard?.dropCard?(location)
        draggingCard = nil
        isDragging = false
    }
    
    func shouldStartDragging(point: CGPoint) -> Bool {
        if let start = initialTouch {
            return abs(start.x - point.x) > 50 ||
                abs(start.y - point.y) > 50
        } else {
            return false
        }
    }
    
    func startDragging(card: Card?, at point: CGPoint) {
        guard let card = card else {
            return
        }
        
        let drag = DraggableCard(card)
        
        drag.dropCard = { point in
            self.gameViewController?.play(card: card, at: point)
            self.gameViewController?.boardData.setPlayableLocations(for: Card(.none))
            self.gameViewController?.cityCollectionView.reloadData()
            self.draggingCard?.removeFromSuperview()
        }
        drag.center = point
        addSubview(drag)
        
        UIView.animate(withDuration: 0.3, animations: {
            drag.center = CGPoint(x: point.x, y: point.y - drag.frame.height/2)
        })
        draggingCard = drag
        drag.animatedEnlarge()
        gameViewController?.boardData.setPlayableLocations(for: card)
        gameViewController?.cityCollectionView.reloadData()
        gameViewController?.handCollectionView.reloadData()
    }
}

