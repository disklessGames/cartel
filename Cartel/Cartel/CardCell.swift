import UIKit

class CardCell: UICollectionViewCell {

    @IBOutlet var imageView: DraggableCard!
    @IBOutlet var countLabel: UILabel!
    @IBOutlet var player2: UILabel!

    override func prepareForReuse() {
        imageView.subviews.forEach {
            $0.removeFromSuperview()
        }
    }

    func configure(_ block: [Card], agents: Int, rotation: CGAffineTransform, isPlayable: Bool) {
        if let last = block.last,
            last.type == .road || last.type == .none {
            imageView.image = last.image
        } else {
            imageView.image = block.first?.image
            showStackedImages(block)
         }
        if agents > 0 {
            countLabel.text = "\(agents)"
            player2.text = "\(agents)"
        } else {
            countLabel.text = ""
            player2.text = ""
        }
        if isPlayable {
            layer.borderWidth = 1
            layer.borderColor = UIColor.green.cgColor
        } else {
            layer.borderWidth = 0
        }
        clipsToBounds = false
        imageView.transform = rotation
    }

    func showStackedImages(_ cards: [Card]) {
        for (index, card) in cards.enumerated() {
            let newLevel = UIImageView(image: card.image)
            if index > 0 {
                newLevel.frame = CGRect(x: CGFloat(-12 * (index - 1)),
                                        y: CGFloat(-20 * (index - 1)),
                                        width: frame.width,
                                        height: frame.height)
                imageView.addSubview(newLevel)
            }
        }
    }
}
