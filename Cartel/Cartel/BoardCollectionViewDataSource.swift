
import UIKit

class BoardData: NSObject {
    
    let identifier = "CardCell"
    var city = [Int: [Card]]()
    var pocket = [Card]()
    
    override init() {
        super.init()
        for x in 0..<1024 {
                city[x] = [Card(.none)]
        }
    }
    
    func play(card: Card, at index: Int) {
        city[index]?.append(card)
    }
    
    func playPocket(_ card: Card) {
        pocket.append(card)
    }
    
    func cards(at index: Int) -> [Card]? {
        return city[index]
    }
    
    func prepareForNewGame() {
        play(card: Card(.straight), at: 0)
        play(card: Card(.straight), at: 1)
    }
}

extension BoardData: UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return city.count
        } else {
            return pocket.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCell
        if let card = city[indexPath.row]?.last {
            cell.imageView.image = card.image
        }
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2;
    }
}
