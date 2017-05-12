
import UIKit


class BoardData: NSObject {
    
    let identifier = "CardCell"
    let size = 10 * 10
    var city = [Int: [Card]]()
    var cardRotations = [CGAffineTransform]()
    var pocket = [Card]()
    
    override init() {
        super.init()
        for x in 0..<size {
            city[x] = [Card(.none)]
            cardRotations.insert(.identity, at: x)
        }
        play(card: Card(RoadCardType.straight), at: 45)
        play(card: Card(RoadCardType.straight), at: 55)
    }
    
    func play(card: Card, at index: Int) {
        city[index]?.append(card)
    }
    
    func playPocket(_ card: Card) {
        pocket.append(card)
    }
    
    func cards(at index: Int) -> [Card]? {
        return city[index]
    }
    
    func canPlay(card: Card, x: Int, y: Int) -> Bool {
        return true
    }
}
