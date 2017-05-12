
import UIKit


class BoardData: NSObject {
    
    let identifier = "CardCell"
    let width = 15
    var city = [Int: [Card]]()
    var cardRotations = [CGAffineTransform]()
    var pocket = [Card]()
    var playableLocation = [Bool]()
    
    override init() {
        super.init()
        for x in 0..<width*width {
            city[x] = [Card(.none)]
            cardRotations.insert(.identity, at: x)
            playableLocation.append(false)
        }
        play(card: Card(RoadCardType.straight), at: width*width/2)
        play(card: Card(RoadCardType.straight), at: width*width/2 + width)
    }
    
    func setPlayableLocations(for card: Card){
        for y in 0..<width {
            for x in 0..<width {
                playableLocation[x*width + y] = canPlay(card: card, x: x, y: y)
            }
        }
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
    
    func canPlay(card: Card, at index: Int) -> Bool {
        switch card.type {
        case .building:
            if city[index]?.last?.type == .building {
                return true
            } else {
                return city[index]!.last!.type == .none &&
                canPlayBuilding(at: index)
            }
        case .road:
            if city[index]!.last!.type == .none {
                return city[index+1]?.last?.type == .road ||
                    city[index-1]?.last?.type == .road ||
                    city[index+width]?.last?.type == .road ||
                    city[index-width]?.last?.type == .road
            } else {
                return false
            }
        default:
            return false
        }
    }
    
    func canPlay(card: Card, x: Int, y: Int) -> Bool {
        return canPlay(card: card, at: x*width + y)
    }
    
    private func canPlayBuilding(at index: Int) -> Bool {
        return
            city[index+1]?.last?.type == .road ||
                city[index-1]?.last?.type == .road ||
                city[index+width]?.last?.type == .road ||
                city[index-width]?.last?.type == .road
    }
}
