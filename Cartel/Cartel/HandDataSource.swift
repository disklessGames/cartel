import UIKit

class HandDataSource: NSObject {

    fileprivate var player: Player

    init(player: Player) {
        self.player = player
        super.init()
    }

    func add(card: Card) {
        player.add(card: card)
    }

    func playCard(at index: Int) -> Card? {
        return player.playCard(at: index)
    }

    func swop(_ first: Int, _ second: Int) {
        player.swop(first, second)
    }
}

extension HandDataSource: UICollectionViewDataSource {

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
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
}
