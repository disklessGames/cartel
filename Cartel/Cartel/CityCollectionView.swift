
import UIKit

class CityCollectionView: UICollectionView {
    
    func contains(point: CGPoint) -> IndexPath? {
        if frame.contains(point) {
            return indexPathForItem(at: point)
        } else {
            return nil
        }
    }
}
