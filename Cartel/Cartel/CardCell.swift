
import UIKit

class CardCell: UICollectionViewCell {
    
    @IBOutlet var imageView : DraggableCard!
    var draggable = true
    
    required init?(coder aDecoder: NSCoder) {
        //TODO find the right view
        super.init(coder: aDecoder)
    }
}
