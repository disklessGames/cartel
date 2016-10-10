
import UIKit

class GameViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet var bankRollButton : UIButton!
    @IBOutlet var handCollectionView : UICollectionView!
    @IBOutlet weak var cityCollectionView: UICollectionView!
    
    var game : Game
    var cardMoving : DraggableCard?
    
    required init?(coder aDecoder: NSCoder) {
        game = Game()
        let player = Player(name: "Me")
        game.setup(players: [player])
        game.shuffle()
        game.deal()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        handCollectionView.allowsSelection = true
        super.viewDidLoad()
    }
    
    @IBAction func exit(_ sender : AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func drawCard(_ sender : AnyObject) {
        if let cardDrawn = self.game.bankroll.drawCard() {
            self.playerDraw(cardDrawn)
        } else {
            print("No more cards !")
        }
    }
    
    func cleanUpDrawAnimation(_ cardDrawn:Card, cardView:UIView){
        cardView.removeFromSuperview()
        self.game.currentPlayer.add(card: cardDrawn)
        self.handCollectionView.reloadData()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return game.currentPlayer.handSize
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath:IndexPath){
        
        let card = game.currentPlayer.playCard(at: (indexPath as NSIndexPath).row)
        let cardMoving = DraggableCard(card)
        
        self.view.addSubview(cardMoving)
        cardMoving.center = collectionView.cellForItem(at: indexPath)!.center
        //remove
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCell
        if let card = game.currentPlayer.peekCard(index: (indexPath as NSIndexPath).row) {
            cell.imageView.image = card.image
        }
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let location = touches.first?.location(in: self.view),
            let cardUnwrapped = cardMoving {
            if location.y > self.view.frame.height-handCollectionView.frame.height {
                self.game.currentPlayer.add(card: cardUnwrapped.card)
                handCollectionView.reloadData()
            }
            cardMoving = nil
        }
        super.touchesEnded(touches, with: event)
    }
    
    func setupGame(){
        let player = Player(name: "Me")
        let opponent = Player(name: "You")
        game = Game()
        game.setup(players: [player,opponent])
        game.shuffle()
        game.deal()
        handCollectionView.reloadData()
    }
}

extension GameViewController {
    
    fileprivate func playerDraw(_ cardDrawn:Card){
        
        let cardDrawnView = UIImageView(image:cardDrawn.image)
        let duration = 1.0
        let delay = 0.0
        let options = UIViewAnimationOptions()
        let damping = CGFloat(0.7)
        let velocity = CGFloat(0.7)
        
        cardDrawnView.center = self.bankRollButton.center
        self.view.addSubview(cardDrawnView)
        
        UIView.animate(withDuration: duration, delay: delay, usingSpringWithDamping: damping, initialSpringVelocity: 0.7, options: options, animations: {
            
            let center = self.view.convert(self.view.center, from: self.view.superview)
            cardDrawnView.center = center
            
            }, completion: {finished in
                cardDrawnView.image = cardDrawn.image
                UIView.animate(withDuration: duration, delay: delay, usingSpringWithDamping: damping, initialSpringVelocity: velocity, options: options, animations: {
                    cardDrawnView.center = self.handCollectionView.center
                    
                    }, completion: {finished in
                        self.cleanUpDrawAnimation(cardDrawn,cardView: cardDrawnView)
                })
        })
    }
    
}
