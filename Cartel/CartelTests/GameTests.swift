
import XCTest
import Cartel

class GameTests: XCTestCase {
    var sut = Game()
    
    override func setUp() {
        let player1 = Player(name: "Piet")
        let player2 = Player(name: "Koos")
        
        sut.setupGame([player1,player2])
        super.setUp()
        
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testBuildingCard(){

        let card = BuildingCard(buildingType: BuildingCardType.anniewares)
        
        XCTAssertEqual(card.type , CardType.building)
    }
    
    func testBankRollSetupCreates71Cards() {
        
        XCTAssertEqual(sut.bankroll.bankrollCards.count, 71)
    }
    
    
    func testCreateCityBoard(){
        
        XCTAssertEqual(sut.city.count, 2)
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
    
        XCTAssertEqual(sut.city[0][0].type, CardType.road)
        XCTAssertEqual(sut.city[1][0].type, CardType.road)
    }
    
    func testNewGameWith2Players(){
        
        XCTAssertEqual(sut.players.count, 2)
    }
    
    
    func testPlayerHas4CardsAfterDeal(){
        
        sut.deal()
        
        XCTAssertEqual(sut.players[0].hand.count, 4)
    }
    
    func testShuffle(){
        
        let firstcard = sut.bankroll.bankrollCards[0];
        sut.shuffle()
        
        XCTAssertNotEqual(sut.bankroll.bankrollCards[0].type, firstcard.type)
    }
    
    func testFlip(){

        sut.flip()
        
        XCTAssertTrue(sut.bankroll.isFlipped)
    }

    
}
