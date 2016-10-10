
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
                diff = preShuffleDeck[i].card != shuffledDards[i].card
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
}
