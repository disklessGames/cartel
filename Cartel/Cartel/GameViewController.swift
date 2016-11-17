
import UIKit

class GameViewController: UIViewController, UICollectionViewDelegate {
    
    @IBOutlet var bankRollButton: UIButton!
    @IBOutlet var handCollectionView: UICollectionView!
    @IBOutlet weak var cityCollectionView: UICollectionView!
    
    var cardMoving: DraggableCard?
    var game = Game() {
        didSet {
            handData = HandDataSource(player: game.currentPlayer)
        }
    }
    var handData: HandDataSource? {
        didSet {
            handCollectionView?.dataSource = handData
            cityCollectionView?.dataSource = handData
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        handData = HandDataSource(player: game.currentPlayer)
        print("will appear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("did appear")
    }
    
    @IBAction func exit(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func drawCard(_ sender: AnyObject) {
        if let cardDrawn = game.draw() {
            self.playerDraw(cardDrawn)
        } else {
            print("No more cards !")
        }
    }
    
    func cardsLeft() -> Int {
        return game.bankroll.cardsLeft()
    }
    
    func cleanUpDrawAnimation(_ cardDrawn: Card, cardView: UIView) {
        cardView.removeFromSuperview()
        handData?.add(card: cardDrawn)
        handCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        
        let newCenter =  collectionView.cellForItem(at: indexPath)!.center
        if let card = handData?.playCard(at: (indexPath as NSIndexPath).row) {
            
            let floater = DraggableCard(card)
            
            view.addSubview(floater)
            floater.center = newCenter
            // remove
            collectionView.reloadData()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let location = touches.first?.location(in: self.view),
            let card = cardMoving {
            if location.y > handCollectionView.frame.maxY {
                
                handData?.add(card: card.card)
                handCollectionView.reloadData()
            }
            cardMoving = nil
        }
        super.touchesEnded(touches, with: event)
    }
}

extension GameViewController {
    
    fileprivate func playerDraw(_ cardDrawn: Card) {
        
        let cardDrawnView = UIImageView(image: cardDrawn.image)
        cardDrawnView.frame.size = Card.bigSize
        let duration = 1.0
        let delay = 0.0
        let options = UIViewAnimationOptions()
        let damping = CGFloat(0.7)
        let velocity = CGFloat(0.7)
        
        cardDrawnView.center = bankRollButton.center
        view.addSubview(cardDrawnView)
        
        UIView.animate(withDuration: duration, delay: delay, usingSpringWithDamping: damping, initialSpringVelocity: 0.7, options: options, animations: {
            
            let center = self.view.convert(self.view.center, from: self.view.superview)
            cardDrawnView.center = center
            
        }, completion: { finished in
            cardDrawnView.image = cardDrawn.image
            UIView.animate(withDuration: duration, delay: delay, usingSpringWithDamping: damping, initialSpringVelocity: velocity, options: options, animations: {
                cardDrawnView.center = self.handCollectionView.center
                
            }, completion: { finished in
                self.cleanUpDrawAnimation(cardDrawn, cardView: cardDrawnView)
            })
        })
    }
}
