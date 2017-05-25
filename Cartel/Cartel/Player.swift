typealias Hand = [Card]
import Foundation
import UIKit

class Player {

    var id: Int
    var name: String
    var handSize: Int {
        return hand.count
    }
    var color: UIColor

    var hand = Hand()

    init(id: Int, name: String, color: UIColor) {
        self.id = id
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
        if hand.count > first {
            let temp = hand.remove(at: first)
            hand.insert(temp, at: second)
        }
    }
}
