
import Foundation

class Game{
    var players = [Player]()
    var city = [[Card]]()
    let bankroll = Bankroll()
    
    func setupGame(_ players:[Player]){
        let card1 = RoadCard(roadType:RoadCardType.straight)
        let card2 = RoadCard(roadType:RoadCardType.straight)
        self.city.append([card1])
        self.city.append([card2])
        self.players = players
    }
    
    func deal(){
        for _ in 1...4 {
            for player in players {
                if let card = self.drawCard(){
                    player.hand.append(card)
                }
            }
        }
    }
    func shuffle(){
        bankroll.shuffle()
    }
    
    func drawCard()->Card?{
        return self.bankroll.drawCard()
    }
    
    func flip(){
        bankroll.flip()
    }
}
