
import XCTest
@testable import Cartel

class DraggableCardTests: XCTestCase {

    let card = Card(.road)
    var sut: DraggableCard!
    let touch = TestableTouch()
    
    override func setUp() {
        sut = DraggableCard(card)
    }
    
    func testCreate() {
        XCTAssertEqual(sut.card, card)
    }
    
    func testCreateBig() {
        XCTAssertTrue(sut.isUserInteractionEnabled)
        XCTAssertEqual(sut.layer.shadowColor, UIColor.black.cgColor)
        XCTAssertEqual(sut.layer.shadowRadius, 2)
        XCTAssertEqual(sut.layer.shadowOffset.height, 3)
        XCTAssertEqual(sut.layer.shadowOpacity, 0.5)
    }
    
    
    class TestableTouch : UITouch {
        
        var viewLocation = CGPoint(x: 0, y: 0)
        
        override func location(in view: UIView?) -> CGPoint {
            return viewLocation
        }
    }
}
