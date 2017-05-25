import XCTest
@testable import Cartel

class GameTests: XCTestCase {
    var sut: Game!

    override func setUp() {
        let player1 = Player(id: 1, name: "Piet", color: .red)
        let player2 = Player(id: 2, name: "Koos", color: .blue)

        sut = Game(players: [player1, player2])
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testStartingRoadsCreated() {

        sut.prepareGame()

        XCTAssertEqual(sut.board.cards(at: 112)?.last?.type, CardType.road)
        XCTAssertEqual(sut.board.cards(at: 127)?.last?.type, CardType.road)
    }

    func testStartGame_Shuffles() {
        sut.prepareGame()

        XCTAssertTrue(sut.bankroll.shuffled)
    }

    func testStartGame_Deals() {
        sut.prepareGame()

        XCTAssertEqual(sut.cardsLeft(), 65)
    }

    func testNewGameWith2Players() {
        XCTAssertEqual(sut.numberOfPlayers, 2)
    }

    func testPlayerHas4CardsAfterDeal() {

        sut.deal()

        XCTAssertEqual(sut.currentPlayer.handSize, 4)
    }

    func testShuffle() {

        sut.shuffle()

        XCTAssertTrue(sut.bankroll.shuffled)
    }

    func testFlip() {

        sut.flip()

        XCTAssertTrue(sut.bankroll.flipped)
    }

    func testBeginTurn() {

        sut.beginTurn()

        XCTAssertEqual(sut.currentPlayer.handSize, 1)
    }

    func testEndTurn_drawsCards() {

        let player = sut.currentPlayer

        sut.endTurn()

        XCTAssertEqual(player.handSize, 4)
    }

    func testEndTurn_ChangesPlayer() {

        let player = sut.currentPlayer

        sut.endTurn()

        XCTAssertNotEqual(sut.currentPlayer.id, player.id)

        sut.endTurn()

        XCTAssertEqual(sut.currentPlayer.id, player.id)
    }
}
