
import XCTest
@testable import Cartel

class GameTests: XCTestCase {
    var sut = Game()
    
    override func setUp() {
        let player1 = Player(name: "Piet")
        let player2 = Player(name: "Koos")
        
        sut.setup(players: [player1,player2])
        super.setUp()
        
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testBuildingCard(){

        let card = BuildingCard(buildingType: BuildingCardType.anniewares)
        
        XCTAssertEqual(card.type, BuildingCardType.anniewares)
    }
    
    func testBankRollSetupCreates71Cards() {
        
        XCTAssertEqual(sut.bankroll.cardsLeft(), 71)
    }
    
    func testPocketCardsAre15(){
        
        XCTAssertEqual(sut.bankroll.pocketCardsCount(), 15)
    }
    
    func testRoadCardsAreThereExceptStartingStraights(){
    
        XCTAssertEqual(sut.bankroll.roadCardsCount(), 14)
    }
    
    func testBuildingCardsAre42(){
    
        XCTAssertEqual(sut.bankroll.buildingCardsCount(), 42)
    }
    
    func testStartingRoadsCreated(){
    
        XCTAssertEqual(sut.board.getCard(x: 0, y: 0)?.card, CardType.road)
        XCTAssertEqual(sut.board.getCard(x: 0, y: 1)?.card, CardType.road)
        
    }
    
    func testNewGameWith2Players(){
        
        XCTAssertEqual(sut.playerCount(), 2)
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

    
}
