typealias Hand = [Card]
import Foundation

class Player {
    var name: String
    var handSize: Int {
        return hand.count
    }
    
    
    private var hand = Hand()
    
    init(name: String){
        self.name = name
    }
    
    func add(card: Card) {
        hand.append(card)
    }
    
    func playCard(at index: Int) -> Card? {
        if handSize > index {
            return hand.remove(at: index)
        }
        return nil
    }
    
    func peekCard(index: Int) -> Card? {
        if index < handSize {
            return hand[index]
        }
        return nil
    }
}
