

import UIKit

class BoardCollectionViewDataSource: NSObject, UICollectionViewDataSource {

    var cards: [Card]?
    
    init(cards: [Card]?) {
        self.cards = cards
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
}
