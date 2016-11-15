
import XCTest
@testable import Cartel

class BankrollTests: XCTestCase {

    let sut = Bankroll()

    func testShuffle(){

        let preShuffleDeck = sut.bankrollCards
        
        sut.shuffle()

        let shuffledDards = sut.bankrollCards

        var diff = false
        for i in 1...10 {
            if !diff {
                diff = preShuffleDeck[i].type != shuffledDards[i].type
            }
        }
        
        XCTAssertTrue(diff)
    }
    
    func testFlip(){
        
        sut.flip()
        
        XCTAssertTrue(sut.flipped)
    }
    
    func testDraw2CardsAtATime(){
        
        let cardsDrawn = sut.drawCards(2)
        
        XCTAssertEqual(cardsDrawn.count, 2)
    }
    
    func testNoCardDrawn_bankrollEmpty() {
        sut.bankrollCards = [Card]()
        
        XCTAssertNil(sut.drawCard())
    }
    
    func testBankRollSetupCreates73Cards() {
        XCTAssertEqual(sut.cardsLeft(), 73)
    }
    
    func testPocketCardsAre15(){
        XCTAssertEqual(sut.pocketCardsCount(), 15)
    }
    
    func testRoadCardsAreThereExceptStartingStraights(){
        XCTAssertEqual(sut.roadCardsCount(), 14)
    }
    
    func testBuildingCardsAre44(){
        XCTAssertEqual(sut.buildingCardsCount(), 44)
    }
    
}
