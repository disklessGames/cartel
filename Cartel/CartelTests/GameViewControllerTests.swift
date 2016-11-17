
import XCTest
@testable import Cartel

class GameViewControllerTests: XCTestCase {
    
    let sut = GameViewController(coder: TestableCoder())!
    let collectionView = TestableCollectionView(frame: CGRect.null, collectionViewLayout: UICollectionViewFlowLayout())
    
    override func setUp() {
        super.setUp()
        sut.handCollectionView = collectionView
        sut.cityCollectionView = collectionView
        sut.game = Game()
        sut.bankRollButton = UIButton()

        _ = sut.view
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
        XCTAssertTrue(collectionView.reloadCalled)
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
