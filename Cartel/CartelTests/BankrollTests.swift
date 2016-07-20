
import XCTest
@testable import Cartel

class BankrollTests: XCTestCase {

    let sut = Bankroll()

    func testShuffle(){

        let first2cards = [sut.bankrollCards[0], sut.bankrollCards[1]];
        
        sut.shuffle()

        let shuffled2cards = [sut.bankrollCards[0], sut.bankrollCards[1]];

        XCTAssertNotEqual(shuffled2cards[0].type, first2cards[0].type)
        XCTAssertNotEqual(shuffled2cards[1].type, first2cards[1].type)
    }
    
    func testFlip(){
        
        sut.flip()
        
        XCTAssertEqual(sut.isFlipped, true)
    }
    func testDraw2CardsAtATime(){
        
        let cardsDrawn = sut.drawCards(2)
        
        XCTAssertEqual(cardsDrawn.count, 2)
    }



}
