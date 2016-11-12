
import UIKit

class GameViewController: UIViewController, UICollectionViewDelegate {
    
    @IBOutlet var bankRollButton: UIButton!
    @IBOutlet var handCollectionView: UICollectionView!
    @IBOutlet weak var cityCollectionView: UICollectionView!
    
    var cardMoving: DraggableCard?
    
    var gameData: GameDataSource? {
        didSet {
            handCollectionView.dataSource = gameData
//            cityCollectionView.dataSource = gameData
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        let me = Player(name: "Me")
        gameData = GameDataSource(game: Game(), players: [me])
        super.viewDidLoad()
    }
    @IBAction func exit(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func drawCard(_ sender: AnyObject) {
        if let cardDrawn = gameData?.draw() {
            self.playerDraw(cardDrawn)
        } else {
            print("No more cards !")
        }
    }
    
    func cleanUpDrawAnimation(_ cardDrawn: Card, cardView: UIView) {
        cardView.removeFromSuperview()
        gameData?.addToCurrentPlayer(card: cardDrawn)
        handCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        
        let newCenter =  collectionView.cellForItem(at: indexPath)!.center
        if let card = gameData?.playCard(at: (indexPath as NSIndexPath).row) {
            
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
            let cardUnwrapped = cardMoving {
            if location.y > handCollectionView.frame.maxY {
                
                gameData?.addToCurrentPlayer(card: cardUnwrapped.card)
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
