
import XCTest
@testable import Cartel

class DraggableCardTests: XCTestCase {

    let card = Card(.road)
    var sut: DraggableCard!
    let touch = TestableTouch()
    
    override func setUp() {
        sut = DraggableCard(card)
        
        sut.cancel = { }
    }
    
    func testCreate() {
        XCTAssertEqual(sut.card, card)
    }
    
    func testCreateBig() {
        XCTAssertTrue(sut.isUserInteractionEnabled)
        XCTAssertEqual(sut.layer.shadowColor, UIColor.black.cgColor)
        XCTAssertEqual(sut.layer.shadowRadius, 6)
        XCTAssertEqual(sut.layer.shadowOffset.height, 20)
        XCTAssertEqual(sut.layer.shadowOpacity, 0.3)
    }
    
    func testTouchesBegan() {
        
        let touches: Set = [touch]
        
        sut.touchesBegan(touches, with: nil)
        
        XCTAssertEqual(sut.center, CGPoint(x: Card.bigSize.width / 2, y: Card.bigSize.height / 2))
        XCTAssertEqual(sut.frame.size, Card.bigSize)
    }
    
    func testTouchesBeganShadow() {
        
        let touches: Set = [touch]
        
        sut.touchesBegan(touches, with: nil)
        
        XCTAssertEqual(sut.layer.shadowColor, UIColor.black.cgColor)
        XCTAssertEqual(sut.layer.shadowRadius, 6)
        XCTAssertEqual(sut.layer.shadowOffset.height, 20)
        XCTAssertEqual(sut.layer.shadowOpacity, 0.3)
    }
    
    func testTouchMoved() {
        
        touch.viewLocation = CGPoint(x: 10, y: 10)
        let touches: Set = [touch]
        
        sut.touchesMoved(touches, with: nil)
        
        XCTAssertEqual(sut.center, CGPoint(x: 10, y: 10))
    }
    
    func testTouchMovedWithOffset() {
        touch.viewLocation = CGPoint(x: 20, y: 20)
        let touches: Set = [touch]
        
        sut.touchesMoved(touches, with: nil)
        
        XCTAssertEqual(sut.center, CGPoint(x: 20, y: 20))
        
    }
    
    func testTouchesEndedDropsCard_IfMoved() {
        
        let expect = expectation(description: "drop")
        sut.dropCard = { (point) in
            XCTAssertEqual(point, CGPoint(x: 50, y: 100))
            expect.fulfill()
        }
        touch.viewLocation = CGPoint(x: 50, y: 100)
        sut.hasMoved = true
        sut.touchesEnded([touch], with: nil)
        
        waitForExpectations(timeout: 0.1, handler: nil)
        
    }
    
    func testTouchesEndedCancels_IfNotMoved() {
        
        let expect = expectation(description: "drop")
        sut.cancel = {
            expect.fulfill()
        }
        touch.viewLocation = CGPoint(x: 50, y: 100)
        sut.hasMoved = false
        sut.touchesEnded([touch], with: nil)
        
        waitForExpectations(timeout: 0.1, handler: nil)
        
    }
    
    func testTouchesEndedShadow() {
    
        sut.touchesBegan([touch], with: nil)
        sut.touchesMoved([touch], with: nil)
        sut.touchesEnded([touch], with: nil)
        
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
