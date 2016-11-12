
import XCTest
@testable import Cartel

class PlayerTests: XCTestCase {
    
    let sut = Player(name: "tester")
    let card = Card(type: .road)
    
    func testCreate() {
        
        XCTAssertEqual(sut.name, "tester")
    }
    
    func testAddCard() {
        
        sut.add(card: card)
        
        XCTAssertEqual(sut.handSize, 1)
    }
    
    func testPlayCard() {
        
        sut.add(card: card)
        
        let playedCard = sut.playCard(at: 0)
        
        XCTAssertEqual(playedCard, card)
    }
    
    func testPlayCard_EmptyHand() {
        
        XCTAssertNil(sut.playCard(at: 0))
    }
    
    func testPeekCard() {
        
        sut.add(card: card)
        
        let peekCard = sut.peekCard(index: 0)
        
        XCTAssertNotNil(peekCard)
        XCTAssertEqual(sut.handSize, 1)
        
    }
    
    func testEmptyPeekCard() {
        
        sut.add(card: card)
        
        let peekCard = sut.peekCard(index: 7)
        
        XCTAssertNil(peekCard)
        XCTAssertEqual(sut.handSize, 1)
        
    }
    
}
