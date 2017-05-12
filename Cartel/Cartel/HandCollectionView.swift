
import UIKit

class HandCollectionView: UICollectionView, UICollectionViewDelegateFlowLayout  {
        
    override func moveItem(at indexPath: IndexPath, to newIndexPath: IndexPath) {
        if let data = dataSource as? HandDataSource {
            data.swop(indexPath.item, newIndexPath.item)
        }
    }
}

