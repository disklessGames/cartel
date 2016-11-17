
import UIKit

class HandDataSource: NSObject, UICollectionViewDataSource {

    var player: Player
    
    init(player: Player) {
        self.player = player
        super.init()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return player.handSize
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCell
        if let card = player.peekCard(index: (indexPath as NSIndexPath).row) {
            cell.imageView.image = card.image
        }
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }

    func add(card: Card) {
        player.add(card: card)
    }
    
    func playCard(at index: Int) -> Card? {
        return player.playCard(at: index)
    }
}
