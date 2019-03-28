import UIKit

class GameViewController: UIViewController, UICollectionViewDelegate {
    
    @IBOutlet weak var gameInputView: InputView!
    
    @IBOutlet var bankRollButton: UIButton!
    @IBOutlet var handCollectionView: HandCollectionView!
    @IBOutlet weak var cityCollectionView: CityCollectionView!
    
    @IBOutlet weak var actionsLabel: UILabel!
    var game: Game! {
        didSet {
            handData = HandDataSource(player: game.currentPlayer)
            boardData = CityData(players: game.numberOfPlayers)
        }
    }
    var handData: HandDataSource? {
        didSet {
            handCollectionView?.dataSource = handData
            handCollectionView.backgroundColor = game.currentPlayer.color
            handCollectionView.reloadData()
        }
    }
    var boardData = CityData(players: 2) {
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
        gameInputView.gameViewController = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        cityCollectionView.resetView()
    }
    
    @IBAction func exit(_ sender: AnyObject) {
        game = Game()
        game.prepareGame()
    }
    
    @IBAction func drawCard(_ sender: AnyObject) {
        if game.currentPlayerActions > 0 {
            game.currentPlayerActions -= 1
            if let card = game.draw() {
                draw(card)
                actionsLabel.text = "Actions left \(game.currentPlayerActions)"
                
            }
        } else {
            game.endTurn()
            handData = HandDataSource(player: game.currentPlayer)
            actionsLabel.text = "Actions left \(game.currentPlayerActions)"
            
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
    
}

extension GameViewController {
    
    func card(at point: CGPoint) -> Card? {
        if handCollectionView.frame.contains(point),
            let index = handCollectionView.contains(point: view.convert(point, to: handCollectionView)) {
            return handData?.playCard(at: index.item)
        }
        if let index = cityCollectionView.contains(point: point) {
            return boardData.getTopCard(at: index)
        }
        return nil
    }
    
    func play(card: Card, at point: CGPoint) {
        if game.currentPlayerActions > 0,
            let index = cityCollectionView.contains(point: point),
            self.boardData.canPlay(card: card, at: index.item) {
            game.currentPlayerActions -= 1
            actionsLabel.text = "Actions left \(game.currentPlayerActions)"
            
            self.boardData.play(card: card, at: index.row, playerId: game.currentPlayerIndex )
            self.cityCollectionView.reloadData()
            
        } else {
            handData?.add(card: card)
            handCollectionView.reloadData()
        }
    }
    
    fileprivate func draw(_ cardDrawn: Card) {
        
        let cardDrawnView = UIImageView(image: cardDrawn.image)
        cardDrawnView.frame.size = Card.bigSize
        let duration = 0.5
        let delay = 1.0
        let options = UIView.AnimationOptions()
        let damping = CGFloat(0.7)
        let velocity = CGFloat(0.7)
        
        cardDrawnView.center = bankRollButton.center
        view.addSubview(cardDrawnView)
        
        UIView.animate(withDuration: duration,
                       delay: 0, usingSpringWithDamping: damping, initialSpringVelocity: 0.7, options: options,
                       animations: {
                        
                        let center = self.view.convert(self.view.center, from: self.view.superview)
                        cardDrawnView.center = center
                        
        }, completion: { _ in
            cardDrawnView.image = cardDrawn.image
            UIView.animate(withDuration: duration, delay: delay, usingSpringWithDamping: damping, initialSpringVelocity: velocity, options: options, animations: {
                cardDrawnView.center = self.handCollectionView.center
                
            }, completion: { _ in
                self.cleanUpDrawAnimation(cardDrawn, cardView: cardDrawnView)
            })
        })
    }
}
