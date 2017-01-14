
import UIKit

class GameViewController: UIViewController, UICollectionViewDelegate {
    
    @IBOutlet var bankRollButton: UIButton!
    @IBOutlet var handCollectionView: UICollectionView!
    @IBOutlet weak var cityCollectionView: UICollectionView!
    
    var movingCard: DraggableCard?
    
    var game = Game() {
        didSet {
            handData = HandDataSource(player: game.currentPlayer)
        }
    }
    var handData: HandDataSource? {
        didSet {
            handCollectionView?.dataSource = handData
        }
    }
    var boardData: BoardData? {
        didSet {
            cityCollectionView.dataSource = boardData
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
        game = Game()
        game.startGame()
    }
    
    @IBAction func drawCard(_ sender: AnyObject) {
        if let cardDrawn = game.draw() {
            self.playerDraw(cardDrawn)
        } else {
            print("No more cards !")
        }
    }
    
    func cardsLeft() -> Int {
        return game.cardsLeft()
    }
    
    func cleanUpDrawAnimation(_ cardDrawn: Card, cardView: UIView) {
        cardView.removeFromSuperview()
        handData?.add(card: cardDrawn)
        handCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        
        if let card = handData?.playCard(at: (indexPath as NSIndexPath).row) {
            
            let floater = DraggableCard(card)
            floater.dropCard = { [unowned self] (point) in
                self.play(floater.card, at: point)
                floater.removeFromSuperview()
            }
            floater.center = handCollectionView.convert(handCollectionView.cellForItem(at: indexPath)!.center, to: view)

            view.addSubview(floater)
            handCollectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension GameViewController {
    
    fileprivate func play(_ card: Card, at point: CGPoint) {
        if self.cityCollectionView.frame.contains(point) {
            self.boardData?.playCity(x: 0, y: 0, card: card)
            self.cityCollectionView.reloadData()
        } else {
            self.handData?.add(card: card)
            self.handCollectionView.reloadData()
        }
    }
    
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
