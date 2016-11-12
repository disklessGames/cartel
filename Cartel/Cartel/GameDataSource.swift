
import UIKit

class GameDataSource: NSObject, UICollectionViewDataSource {

    let game: Game
    
    init(game: Game) {
        self.game = game
        super.init()
        setupGame()
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

    func setupGame() {
        let player = Player(name: "Me")
        let opponent = Player(name: "You")
        game.setup(players: [player, opponent])
        game.shuffle()
        game.deal()
    }
}
