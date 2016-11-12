
import UIKit

class BoardData: NSObject {
    
    let identifier = "CardCell"
    let maxSize = 100
    var city: [Int: Card]
    var pocket: [PocketCard]
    
    override init() {
        self.city = [Int: Card]()
        self.pocket = [PocketCard]()
        super.init()
        play(x: 0, y: 0, card: RoadCard(type: .straight))
        play(x: 0, y: 1, card: RoadCard(type: .straight))
    }
    
    func play(x: Int, y: Int, card: Card) {
        if let card = card as? PocketCard {
            pocket.append(card)
        } else {
            city[x + y * maxSize] = card
        }
    }
    
    func getCard(x: Int, y: Int) -> Card? {
        return city[x + y * maxSize]
    }
}

extension BoardData: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return city.count
        case 1:
            return pocket.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        
        return cell
    }
    
}
