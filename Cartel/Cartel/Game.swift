
import Foundation

class Game {

    let bankroll = Bankroll()
    let board = BoardData()
    
    private var currentPlayerIndex = 0
    private var players = [Player]()
    
    func playerCount() -> Int {
        return players.count
    }
    
    var currentPlayer: Player? {
        if currentPlayerIndex < players.count {
            return self.players[currentPlayerIndex]
        }
        return nil
    }
    
    func setup(players:[Player]) {
        self.players = players
    }
    
    func deal() {
        for _ in 1...4 {
            for player in players {
                if let card = drawCard(){
                    player.add(card: card)
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
