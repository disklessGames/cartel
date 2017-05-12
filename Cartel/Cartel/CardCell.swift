
import UIKit

class CardCell: UICollectionViewCell {
    
    @IBOutlet var imageView : DraggableCard!
    @IBOutlet weak var countLabel: UILabel!
 
    func configure(_ block: [Card], rotation: CGAffineTransform) {
        if let last = block.last {
            imageView.image = block.last?.image
            if last.type == .road ||
                last.type == .none {
                countLabel.text = ""
            } else {
                countLabel.text = "\(block.count - 1)"
            }
        }
        layer.borderWidth = 1
        layer.borderColor = UIColor.darkGray.cgColor
        imageView.transform = rotation
    }
}
