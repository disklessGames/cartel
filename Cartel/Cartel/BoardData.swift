
import UIKit

class BoardData: NSObject {
    
    let identifier = "CardCell"
    let size = 9 * 10
    var city = [Int: [Card]]()
    var cardRotations = [CGAffineTransform]()
    var pocket = [Card]()
    
    override init() {
        super.init()
        for x in 0..<size {
            city[x] = [Card(.none)]
            cardRotations.insert(.identity, at: x)
        }
        play(card: Card(RoadCardType.straight), at: 40)
        play(card: Card(RoadCardType.straight), at: 49)
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
        if let block = city[indexPath.row],
            let last = block.last {
            cell.imageView.image = block.last?.image
            if last.type == .road ||
                last.type == .none {
                cell.countLabel.text = ""
            } else {
            cell.countLabel.text = "\(block.count - 1)"
            }
        }
        cell.layer.borderWidth = 3
        cell.layer.borderColor = UIColor.white.cgColor
        cell.imageView.transform = cardRotations[indexPath.row]

            return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2;
    }
}

extension BoardData: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? CardCell {
            cell.imageView.transform = cell.imageView.transform.rotated(by: CGFloat(Double.pi/2))
            cardRotations[indexPath.row] = cell.imageView.transform
        }
    }
}
