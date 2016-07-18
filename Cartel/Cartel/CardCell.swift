
import UIKit

class CardCell: UICollectionViewCell {
    
    @IBOutlet var imageView : UIImageView!
    var draggable = true
    
    required init?(coder aDecoder: NSCoder) {
        //TODO find the right view
        super.init(coder: aDecoder)
    }
}
