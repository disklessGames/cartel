
import UIKit

class GameDataSource: NSObject, UICollectionViewDataSource {

    let game: Game
    
    init(game: Game, players: [Player]) {
        self.game = game
        super.init()
        setup(with: players)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return game.currentPlayer.handSize
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

    func setup(with players: [Player]) {
        game.setup(players: players)
        game.shuffle()
        game.deal()
    }
    
    func draw() -> Card? {
        return game.bankroll.drawCard()
    }
    
    func playCard(at index: Int) -> Card? {
        return game.currentPlayer.playCard(at: index)
    }
    
    func addToCurrentPlayer(card: Card) {
        game.currentPlayer.add(card: card)
    }
}
