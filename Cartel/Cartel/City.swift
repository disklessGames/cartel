
import UIKit

class CityCollectionView: UICollectionView {
    
    override var dataSource: UICollectionViewDataSource? {
        didSet {
            delegate = dataSource as? UICollectionViewDelegate
        }
    }
    
    init(frame: CGRect) {
        super.init(frame: frame, collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = .black
    }
    
    func resetView() {
        if let ds = dataSource {
            let middle = ds.collectionView(self, numberOfItemsInSection: 0)/2
            
            scrollToItem(at: IndexPath(item: middle, section: 0), at: .centeredVertically, animated: false)
            setZoomScale(0.5, animated: true)
            print("Datasource set")
        }
    }
    
    func contains(point: CGPoint) -> IndexPath? {
        if frame.contains(point) {
            let actualPoint = CGPoint(x: point.x + contentOffset.x,
                                      y: point.y + contentOffset.y)
            return indexPathForItem(at: actualPoint)
        } else {
            return nil
        }
    }
}
