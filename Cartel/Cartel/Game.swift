
import Foundation

class Game {

    let bankroll = Bankroll()
    let board = BoardData()
    var currentPlayer: Player
    var numberOfPlayers: Int {
        return players.count
    }
    
    private var players: [Player]
    
    init() {
        self.currentPlayer = Player(name: "Me")
        self.players = [currentPlayer]
    }
    
    init(players: [Player]) {
        self.players = players
        self.currentPlayer = players.first ?? Player(name: "Me")
    }
    
    func prepareGame() {
        board.prepareForNewGame()
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
            currentPlayer.add(card: card)
        }
    }
    
    func cardsLeft() -> Int {
        return bankroll.cardsLeft()
    }
}
