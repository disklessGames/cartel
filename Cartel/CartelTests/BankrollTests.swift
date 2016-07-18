
import XCTest

class BankrollTests: XCTestCase {

    let sut = Bankroll()

    func testShuffle(){

        let first2cards = [sut.bankrollCards[0], sut.bankrollCards[1]];
        
        sut.shuffle()
        
        XCTAssertNotEqual([sut.bankrollCards[0], sut.bankrollCards[1]], first2cards)
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
