
import Foundation

class Game {

    let bankroll = Bankroll()
    let board = BoardData(players: 2)
    var currentPlayerIndex = 0
    var currentPlayer: Player {
        return players[currentPlayerIndex]
    }
    var numberOfPlayers: Int {
        return players.count
    }
    
    private var players: [Player]
    
    init() {
        self.players = [Player(name: "Me", color: .green), Player(name: "Nemesis", color: .red)]
    }
    
    init(players: [Player]) {
        self.players = players
    }
    
    func prepareGame() {
        shuffle()
        deal()
    }
    
    func deal() {
        for _ in 1...4 {
            for player in players {
                if let card = bankroll.drawCard(){
                    player.add(card: card)
                }
            }
        }
    }
    
    func shuffle(){
        bankroll.shuffle()
    }
    
    func draw()->Card?{
        return self.bankroll.drawCard()
    }
    
    func flip(){
        bankroll.flip()
    }
    
    func beginTurn(){
        if let card = bankroll.drawCard() {
            players[currentPlayerIndex].add(card: card)
        }
    }
    
    func cardsLeft() -> Int {
        return bankroll.cardsLeft()
    }
}
