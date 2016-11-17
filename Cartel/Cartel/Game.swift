
import Foundation

class Game {

    let bankroll = Bankroll()
    let board = BoardData()
    
    private var players: [Player]
    
    init() {
        self.currentPlayer = Player(name: "Me")
        self.players = [currentPlayer]
    }
    
    init(players: [Player]) {
        self.players = players
        self.currentPlayer = players[0]
    }
    
    var numberOfPlayers: Int {
        return players.count
    }
    
    var currentPlayer: Player
    
    func setup(players:[Player]) {
        self.players = players
        self.currentPlayer = players[0]
    }
    
    func startGame() {
        
        board.prepareForNewGame()
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
}
