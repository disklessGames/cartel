
import Foundation

class Bankroll {
    var bankrollCards = [Card]()
    var isFlipped = false
    
    init(){
        bankrollCards.append(PocketCard(pocketType: .snitch))
        for _ in 1...2 {
            bankrollCards.append(PocketCard(pocketType:.detectiveTracy))
            bankrollCards.append(PocketCard(pocketType:.informantFivel))
            bankrollCards.append(PocketCard(pocketType:.inspectorFord))
            bankrollCards.append(PocketCard(pocketType:.sneakySven))
            bankrollCards.append(PocketCard(pocketType:.captainJuan))
            bankrollCards.append(PocketCard(pocketType:.wardenSachs))
            bankrollCards.append(PocketCard(pocketType:.congressmanTu))
            bankrollCards.append(RoadCard(roadType:.leftTurn))
            bankrollCards.append(RoadCard(roadType:.tJunction))
            bankrollCards.append(BuildingCard(buildingType: .shelfCorp))
            bankrollCards.append(BuildingCard(buildingType: .lucyLaundromat))
            bankrollCards.append(BuildingCard(buildingType: .neueNewsNetwork))
            bankrollCards.append(BuildingCard(buildingType: .skyline))
            bankrollCards.append(BuildingCard(buildingType: .lucyLaundromat))
            bankrollCards.append(BuildingCard(buildingType: .privateSecurity))
            bankrollCards.append(BuildingCard(buildingType: .mannedManagement))
        }

        for _ in 1...3 {
            bankrollCards.append(RoadCard(roadType:.rightTurn))
        }
        
        for _ in 1...7 {
            bankrollCards.append(RoadCard(roadType:.straight))
            bankrollCards.append(BuildingCard(buildingType: .anniewares))
            bankrollCards.append(BuildingCard(buildingType: .doubleDown))
            bankrollCards.append(BuildingCard(buildingType: .groundhogCoffees))
            bankrollCards.append(BuildingCard(buildingType: .topTech))
        }
    }
    
    func pocketCardsCount()->Int{
        var pocketCount = 0
        for card in bankrollCards {
            if card.type == CardType.pocket {
                pocketCount += 1;
            }
        }
        return pocketCount
    }
    
    func roadCardsCount()->Int{
        var roadCardCount = 0
        for card in bankrollCards {
            if card.type == CardType.road{
                roadCardCount += 1
            }
        }
        return roadCardCount
    }
    
    func buildingCardsCount()->Int{
        var buildingCardCount = 0
        for card in bankrollCards {
            if card.type == CardType.building{
                buildingCardCount += 1
            }
        }
        return buildingCardCount
    }
    
    func drawCard()->Card?{
        if bankrollCards.count > 0 {
            let cardDrawn = bankrollCards[0]
            bankrollCards.remove(at: 0)
            return cardDrawn
        }
        return nil
    }
    
    func drawCards(_ numberOfCardsToDraw: Int)->[Card]{
        var cardsDrawn = [Card]()
        for _ in  1...numberOfCardsToDraw {
            cardsDrawn.append(drawCard()!)
        }
        return cardsDrawn
    }
    
    func countCardsLeft()->Int{
        return bankrollCards.count;
    }
    
    func shuffle() {
        bankrollCards = shuffle(bankrollCards)
    }
    
    func shuffle(_ list: [Card]) -> [Card] {
        var list = list
        for old in 0..<list.count {
            let new = Int(arc4random_uniform(UInt32(list.count - old))) + old
            list.insert(list.remove(at: new), at: old)
        }
        return list
    }
    
    func flip(){
        isFlipped = true
        
    }
}
