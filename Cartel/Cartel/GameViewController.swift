
import UIKit

class GameViewController: UIViewController, UICollectionViewDelegate {
    
    @IBOutlet var bankRollButton: UIButton!
    @IBOutlet var handCollectionView: HandCollectionView!
    @IBOutlet weak var cityCollectionView: CityCollectionView!
    var longPressGesture: UILongPressGestureRecognizer!
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongGesture))
        handCollectionView.addGestureRecognizer(longPressGesture)

        game = Game()
        game.prepareGame()

    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    @IBAction func exit(_ sender: AnyObject) {
        game = Game()
        game.prepareGame()
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let card = handData?.playCard(at: (indexPath as NSIndexPath).row) {
            
            let floater = DraggableCard(card)
            floater.dropCard = { [unowned self] (point) in
                self.play(floater, at: point)
            }
            floater.center = handCollectionView.convert(handCollectionView.cellForItem(at: indexPath)!.center, to: view)
            
            view.addSubview(floater)
            handCollectionView.reloadData()
        }
    }
    
    
    func handleLongGesture(gesture: UILongPressGestureRecognizer) {
        
        let location = gesture.location(in: handCollectionView)
        movingIndexPath = handCollectionView.indexPathForItem(at: location)
        switch(gesture.state) {
        case .began:
            guard let indexPath = movingIndexPath else { break }
            //            setEditing(true, animated: true)
            let enabled = handCollectionView.beginInteractiveMovementForItem(at: indexPath)
            print("Start : \(String(describing: movingIndexPath?.description))")
            if !enabled {
                print("Whyy ??????")
            }
            //            pickedUpCell()?.stopWiggling()
        //            animatePickingUpCell(pickedUpCell())
        case .changed:
            print("Change : \(String(describing: movingIndexPath?.description))")
            handCollectionView.updateInteractiveMovementTargetPosition(location)
        case .ended:
            print("End: \(String(describing: movingIndexPath?.description))")
            handCollectionView.endInteractiveMovement()
            //            animatePuttingDownCell(pickedUpCell())
            movingIndexPath = nil
        default:
            handCollectionView.cancelInteractiveMovement()
            //            animatePuttingDownCell(pickedUpCell())
            movingIndexPath = nil
        }
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: true)
        //        startWigglingAllVisibleCells()
    }
}


extension GameViewController {
    
    fileprivate func play(_ movingCard: DraggableCard, at point: CGPoint) {
        
        if let index = self.cityCollectionView.contains(point: point) {
            self.boardData.play(card: movingCard.card, at: index.row )
            self.cityCollectionView.reloadData()
            movingCard.removeFromSuperview()
        } else {
            self.handData?.add(card: movingCard.card)
            self.handCollectionView.reloadData()
            movingCard.removeFromSuperview()
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
