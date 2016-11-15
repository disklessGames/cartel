
import UIKit

class BoardData: NSObject {
    
    let identifier = "CardCell"
    let maxSize = 100
    var city = [Int: [Card]]()
    var pocket = [Card]()
    
    override init() {
        super.init()
        for x in 0..<16 {
            for y in 0..<16 {
                city[x + y * maxSize] = [Card(.none)]
            }
        }
    }
    
    func playCity(x: Int, y: Int, card: Card) {
        city[x + y * maxSize]?.append(card)
    }
    
    func playPocket(_ card: Card) {
        pocket.append(card)
    }
    
    func topCardAt(x: Int, y: Int) -> Card? {
        return city[x + y * maxSize]?.last
    }
    
    func prepareForNewGame() {
        playCity(x: 0, y: 0, card: Card(.straight))
        playCity(x: 0, y: 1, card: Card(.straight))

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
