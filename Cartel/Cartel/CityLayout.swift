
import UIKit

class CityLayout: UICollectionViewFlowLayout {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        minimumLineSpacing = 1
        minimumInteritemSpacing = 1
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        if let attributes = super.layoutAttributesForElements(in: rect) {
            for i in 0..<attributes.count {
                attributes[i].zIndex = i
            }
            return attributes
        } else {
            return nil
        }
    }
    
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        if let attribute = super.layoutAttributesForItem(at: indexPath) {
            attribute.zIndex = Int(attribute.frame.origin.y)
            return attribute
        }
        else {
            return nil
        }
    }
    
}
