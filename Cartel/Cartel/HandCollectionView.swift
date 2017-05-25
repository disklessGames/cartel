import UIKit

class HandCollectionView: UICollectionView, UICollectionViewDelegateFlowLayout {

    override func moveItem(at indexPath: IndexPath, to newIndexPath: IndexPath) {
        if let data = dataSource as? HandDataSource {
            data.swop(indexPath.item, newIndexPath.item)
        }
    }

    func contains(point: CGPoint) -> IndexPath? {
            let actualPoint = CGPoint(x: point.x + contentOffset.x,
                                      y: point.y + contentOffset.y)
            return indexPathForItem(at: actualPoint)
    }

    func add() {

    }
}
