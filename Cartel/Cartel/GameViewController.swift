import UIKit

class GameViewController: UIViewController, UICollectionViewDelegate {

    @IBOutlet weak var gameInputView: InputView!

    @IBOutlet var bankRollButton: UIButton!
    @IBOutlet var handCollectionView: HandCollectionView!
    @IBOutlet weak var cityCollectionView: CityCollectionView!

    var game: Game! {
        didSet {
            handData = HandDataSource(player: game.currentPlayer)
            boardData = BoardData(players: game.numberOfPlayers)
        }
    }
    var handData: HandDataSource? {
        didSet {
            handCollectionView?.dataSource = handData
        }
    }
    var boardData = BoardData(players: 2) {
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
        game.endTurn()
        handData = HandDataSource(player: game.currentPlayer)
        handCollectionView.reloadData()
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

        if let index = self.cityCollectionView.contains(point: point) {
            if self.boardData.canPlay(card: card, at: index.item) {
                self.boardData.play(card: card, at: index.row, playerId: game.currentPlayerIndex )
                self.cityCollectionView.reloadData()
            }
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
