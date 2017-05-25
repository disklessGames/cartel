import Foundation

class Bankroll {
    var bankrollCards = [Card]()
    var flipped = false
    var shuffled = false

    init() {
        bankrollCards.append(Card(.snitch))
        for _ in 1...2 {
            bankrollCards.append(Card(.detectiveTracy))
            bankrollCards.append(Card(.informantFivel))
            bankrollCards.append(Card(.inspectorFord))
            bankrollCards.append(Card(.sneakySven))
            bankrollCards.append(Card(.captainJuan))
            bankrollCards.append(Card(.wardenSachs))
            bankrollCards.append(Card(.congressmanTu))
            bankrollCards.append(Card(.leftTurn))
            bankrollCards.append(Card(.tJunction))
            bankrollCards.append(Card(.shelfCorp))
            bankrollCards.append(Card(.lucyLaundromat))
            bankrollCards.append(Card(.neueNewsNetwork))
            bankrollCards.append(Card(.skyline))
            bankrollCards.append(Card(.lucyLaundromat))
            bankrollCards.append(Card(.privateSecurity))
            bankrollCards.append(Card(.mannedManagement))
            bankrollCards.append(Card(.efficientConsulting))
        }

        for _ in 1...3 {
            bankrollCards.append(Card(.rightTurn))
        }

        for _ in 1...7 {
            bankrollCards.append(Card(.straight))
            bankrollCards.append(Card(.anniewares))
            bankrollCards.append(Card(.doubleDown))
            bankrollCards.append(Card(.groundhogCoffees))
            bankrollCards.append(Card(.topTech))
        }
    }

    func pocketCardsCount() -> Int {
        var pocketCount = 0
        for card in bankrollCards {
            if card.type == .pocket {
                pocketCount += 1
            }
        }
        return pocketCount
    }

    func roadCardsCount() -> Int {
        var CardCount = 0
        for card in bankrollCards {
            if card.type == .road {
                CardCount += 1
            }
        }
        return CardCount
    }

    func buildingCardsCount() -> Int {
        var buildingCardCount = 0
        for card in bankrollCards {
            if card.type == .building {
                buildingCardCount += 1
            }
        }
        return buildingCardCount
    }

    func drawCard() -> Card? {
        if bankrollCards.count > 0 {
            let cardDrawn = bankrollCards[0]
            bankrollCards.remove(at: 0)
            return cardDrawn
        }
        return nil
    }

    func drawCards(_ numberOfCardsToDraw: Int) -> [Card] {
        var cardsDrawn = [Card]()
        for _ in  1...numberOfCardsToDraw {
            cardsDrawn.append(drawCard()!)
        }
        return cardsDrawn
    }

    func cardsLeft() -> Int {
        return bankrollCards.count
    }

    func shuffle() {
        bankrollCards = shuffle(bankrollCards)
        shuffled = true
    }

    func shuffle(_ list: [Card]) -> [Card] {
        var list = list
        for old in 0..<list.count {
            let new = Int(arc4random_uniform(UInt32(list.count - old))) + old
            list.insert(list.remove(at: new), at: old)
        }
        return list
    }

    func flip() {
        flipped = true
    }
}
