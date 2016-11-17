
import XCTest
@testable import Cartel

class GameTests: XCTestCase {
    var sut: Game!
    
    override func setUp() {
        let player1 = Player(name: "Piet")
        let player2 = Player(name: "Koos")
        
        sut = Game(players: [player1,player2])
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testStartingRoadsCreated(){
    
        sut.startGame()
        
        XCTAssertEqual(sut.board.topCardAt(x: 0, y: 0)?.type, CardType.road)
        XCTAssertEqual(sut.board.topCardAt(x: 0, y: 1)?.type, CardType.road)
    }
    
    func testStartGame_Shuffles() {
        sut.startGame()
        
        XCTAssertTrue(sut.bankroll.shuffled)
    }
    
    func testStartGame_Deals() {
        sut.startGame()
        
        XCTAssertEqual(sut.cardsLeft(), 65)
    }
    
    func testNewGameWith2Players(){
        XCTAssertEqual(sut.numberOfPlayers, 2)
    }
    
    func testPlayerHas4CardsAfterDeal(){
        
        sut.deal()
        
        XCTAssertEqual(sut.currentPlayer.handSize, 4)
    }
    
    func testShuffle(){
        
        sut.shuffle()
        
        XCTAssertTrue(sut.bankroll.shuffled)
    }
    
    func testFlip(){

        sut.flip()
        
        XCTAssertTrue(sut.bankroll.flipped)
    }
    
    func testBeginTurn() {
        
        sut.beginTurn()
        
        XCTAssertEqual(sut.currentPlayer.handSize, 1)
    }
}
