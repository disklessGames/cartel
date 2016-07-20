

import UIKit

class BoardCollectionViewDataSource: NSObject, UICollectionViewDataSource {

    let identifier = "CardCell"
    var city: [Card]
    var pocket: [PocketCard]
    
    init(city: [Card]? = nil, pocket: [PocketCard]? = nil) {
        self.city = city ?? [Card]()
        self.pocket = pocket ?? [PocketCard]()
    }
    
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
