
import UIKit

class GameViewController: UIViewController, UICollectionViewDelegate {
    
    @IBOutlet var bankRollButton: UIButton!
    @IBOutlet var handCollectionView: HandCollectionView!
    @IBOutlet weak var cityCollectionView: CityCollectionView!
    var movingIndexPath: IndexPath?
    
    var game: Game! {
        didSet {
            handData = HandDataSource(player: game.currentPlayer)
            boardData = BoardData()
        }
    }
    var handData: HandDataSource? {
        didSet {
            handCollectionView?.dataSource = handData
        }
    }
    var boardData = BoardData() {
        didSet {
            cityCollectionView.dataSource = boardData
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        game = Game()
        game.prepareGame()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        cityCollectionView.resetView()
    }
    
    @IBAction func exit(_ sender: AnyObject) {
        game = Game()
        game.prepareGame()
    }
    
    @IBAction func drawCard(_ sender: AnyObject) {
        if let cardDrawn = game.draw() {
            self.draw(cardDrawn)
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let card = handData?.playCard(at: (indexPath as NSIndexPath).row) {
            
            let floater = DraggableCard(card)
            floater.cancel = {
                self.handData?.add(card: card)
                collectionView.reloadData()
                floater.removeFromSuperview()
            }
            floater.dropCard = { point in
                self.play(floater, at: point)
                self.boardData.setPlayableLocations(for: Card(.none))
                self.cityCollectionView.reloadData()
            }
            floater.center = handCollectionView.convert(handCollectionView.cellForItem(at: indexPath)!.center, to: view)
            
            UIView.animate(withDuration: 0.3, animations: {
                floater.center = self.view.center
            })
            view.addSubview(floater)
            boardData.setPlayableLocations(for: card)
            cityCollectionView.reloadData()
            handCollectionView.reloadData()
        }
    }
}


extension GameViewController {
    
    fileprivate func play(_ movingCard: DraggableCard, at point: CGPoint) {
        
        if let index = self.cityCollectionView.contains(point: point) {
            if self.boardData.canPlay(card: movingCard.card, at: index.item) {
                self.boardData.play(card: movingCard.card, at: index.row )
                self.cityCollectionView.reloadData()
                movingCard.removeFromSuperview()
            } else {
                movingCard.cancel()
            }
        } else {
            self.handData?.add(card: movingCard.card)
            self.handCollectionView.reloadData()
            movingCard.removeFromSuperview()
        }
    }
    
    fileprivate func draw(_ cardDrawn: Card) {
        
        let cardDrawnView = UIImageView(image: cardDrawn.image)
        cardDrawnView.frame.size = Card.bigSize
        let duration = 0.5
        let delay = 1.0
        let options = UIViewAnimationOptions()
        let damping = CGFloat(0.7)
        let velocity = CGFloat(0.7)
        
        cardDrawnView.center = bankRollButton.center
        view.addSubview(cardDrawnView)
        
        UIView.animate(withDuration: duration,
                       delay: 0, usingSpringWithDamping: damping, initialSpringVelocity: 0.7, options: options,
                       animations: {
                        
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
