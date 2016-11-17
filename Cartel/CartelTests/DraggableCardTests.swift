
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
        XCTAssertEqual(sut.image, card.image)
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
        sut.dragCenterOffset = CGPoint(x: 5, y: 5)
        
        sut.touchesMoved(touches, with: nil)
        
        XCTAssertEqual(sut.center, CGPoint(x: 20, y: 20))
        
    }
    
    func testTouchesEnded() {
        touch.viewLocation = CGPoint(x: 50, y: 50)
        
        sut.touchesEnded([touch], with: nil)
        
        XCTAssertEqual(sut.center, CGPoint(x: 50, y: 50))
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
