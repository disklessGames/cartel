import Foundation

class Game {

    private let bankroll = Bankroll()
    private let board: BoardData
    var currentPlayerIndex = 0
    var currentPlayer: Player {
        return players[currentPlayerIndex]
    }
    var numberOfPlayers: Int {
        return players.count
    }
    var currentPlayerActions = 2

    var players: [Player]

    init() {
        self.players = [Player(id: 1, name: "Me", color: .green),
                        Player(id: 2, name: "Nemesis", color: .red)]
        self.board = BoardData(players: 2)
    }

    init(players: [Player]) {
        self.players = players
        self.board = BoardData(players: players.count)
    }

    func prepareGame() {
        shuffle()
        deal()
    }

    func deal() {
        for _ in 1...4 {
            for player in players {
                if let card = bankroll.drawCard() {
                    player.add(card: card)
                }
            }
        }
    }

    func shuffle() {
        bankroll.shuffle()
    }

    func draw() -> Card? {
        return self.bankroll.drawCard()
    }

    func flip() {
        bankroll.flip()
    }

    func beginTurn() {
        if let card = bankroll.drawCard() {
            players[currentPlayerIndex].add(card: card)
        }
    }

    func endTurn() {
        for _ in 0..<board.cardsToDraw(for: currentPlayer) {
            if let card = draw() {
                currentPlayer.add(card: card)
            }
        }
        currentPlayerIndex += 1
        if currentPlayerIndex + 1 > players.count {
            currentPlayerIndex = 0
        }
        currentPlayerActions = 2
    }

    func cardsLeft() -> Int {
        return bankroll.cardsLeft()
    }
}
