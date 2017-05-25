
import UIKit


class BoardData: NSObject {
    
    let identifier = "CardCell"
    let width = 15
    var city = [Int: [Card]]()
    var agents = [Int: Int]()
    var cardRotations = [CGAffineTransform]()
    var pocket = [Int: [Card]]()
    var playableLocation = [Bool]()
    
    init(players: Int) {
        super.init()
        for i in 0..<players {
            pocket[i] = [Card]()
        }
        for x in 0..<width*width {
            city[x] = [Card(.none)]
            agents[x] = 0
            cardRotations.insert(.identity, at: x)
            playableLocation.append(false)
        }
        play(card: Card(RoadCardType.straight), at: width*width/2, playerId: nil)
        play(card: Card(RoadCardType.straight), at: width*width/2 + width, playerId: nil)
    }
    
    func setPlayableLocations(for card: Card){
        for y in 0..<width {
            for x in 0..<width {
                playableLocation[x*width + y] = canPlay(card: card, x: x, y: y)
            }
        }
    }
    
    func play(card: Card, at index: Int, playerId: Int?) {
        
        switch card.type {
        case .road:
            city[index]?.append(card)
        case .building:
            switch card.building! {
            case .anniewares, .topTech:
                agents[index]! += 1
            case .groundhogCoffees:
                if city[index]!.count == 1 {
                    agents[index]! += 1
                }
            case .privateSecurity:
                agents[index] = 0
            case .mannedManagement:
                if agents[index]! > 0 {
                    agents[index]! += 1
                }
            case .neueNewsNetwork:
                if pocket[playerId!]!.count > 0 {
                    agents[index]! += 1
                }
            case .doubleDown:
                agents[index]! += doubleDownBonus(index: index)
            case
            .lucyLaundromat,
            .shelfCorp,
            .skyline,
            .efficientConsulting:
                break
            }
            city[index]?.append(card)
        case .pocket:
            pocket[playerId!]!.append(card)
        default:
            break
        }
    }
    
    
    func cards(at index: Int) -> [Card]? {
        return city[index]
    }
    
    func getTopCard(at index: IndexPath) -> Card? {
        if let block = cards(at: index.item),
            let card = block.last,
            card.type != .none {
            city[index.item]!.remove(at: block.count - 1)
            return card
        } else {
            return nil
        }
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
                return true
            }
        case .pocket:
            return true
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

    private func doubleDownBonus(index: Int) -> Int {
        if let under = city[index]?.last?.building {
            if case .doubleDown = under {
                return 1
            }
        } else if let left = city[index - 1]?.last?.building {
            if case .doubleDown = left {
                return 1
            }
        } else if let right = city[index + 1]?.last?.building {
            if case .doubleDown = right {
                return 1
            }
        } else if let top = city[index - width]?.last?.building {
            if case .doubleDown = top {
                return 1
            }
        } else if let bottom =  city[index + width]?.last?.building {
            if case .doubleDown = bottom {
                return 1
            }
        }
        return 0

    }

    func cardsToDraw(for player: Player) -> Int {
        return 4
    }
}
