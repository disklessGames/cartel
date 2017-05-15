typealias Hand = [Card]
import Foundation
import UIKit

class Player {
    var name: String
    var handSize: Int {
        return hand.count
    }
    var color: UIColor
    
    var hand = Hand()
    
    init(name: String, color: UIColor){
        self.name = name
        self.color = color
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
    
    func swop(_ first: Int, _ second: Int) {
        let temp = hand.remove(at: first)
        hand.insert(temp, at: second)
    }
}
