
import XCTest
@testable import Cartel

class GameViewControllerTests: XCTestCase {
    
    var sut = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! GameViewController
    let hand = TestableHandCollectionView(frame: CGRect(x: 0, y: 0, width: 10, height: 10),
                                          collectionViewLayout: UICollectionViewFlowLayout())
    
    override func setUp() {
        super.setUp()

        _ = sut.loadViewIfNeeded()

        sut.game = Game()
        sut.bankRollButton = UIButton()
        sut.handCollectionView = hand
        
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    
    func testViewDidLoad() {
        
        sut.viewDidLoad()
        
        XCTAssertNotNil(sut.handData)
    }
    
    func testDrawCard() {
        
        sut.drawCard(sut.bankRollButton)
        
        XCTAssertEqual(sut.cardsLeft(), 72)
    }
    
    func testCleanupDrawAnimation() {
        
        let card = Card(.road)
        let cardView = TestableView()
        
        sut.cleanUpDrawAnimation(card, cardView:cardView)
        
        XCTAssertTrue(cardView.removeCalled)
        XCTAssertEqual(hand.reloadCalled, 1)
    }
    
    class TestableView : UIView {
        var removeCalled = false
        
        override func removeFromSuperview() {
            removeCalled = true
        }
    }
    
    class TestableCollectionView : UICollectionView {
        var reloadCalled = false
        
        override func reloadData() {
            reloadCalled = true
        }
    }
    
    class TestableCoder : NSCoder {
        
        override func decodeObject(forKey key: String) -> Any? {
            return nil
        }
        
        override func decodeBool(forKey key: String) -> Bool {
            return false
        }
        
        override func containsValue(forKey key: String) -> Bool {
            return false
        }
    }
}

class TestableHandCollectionView: HandCollectionView {
    
    var reloadCalled = 0
    
    override func reloadData() {
        reloadCalled += 1
    }
}
