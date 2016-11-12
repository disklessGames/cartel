
import XCTest
@testable import Cartel

class GameViewControllerTests: XCTestCase {

    let sut = GameViewController(coder: TestableCoder())!
    let collectionView = TestableCollectionView(frame: CGRect.null, collectionViewLayout: UICollectionViewFlowLayout())
    
    override func setUp() {
        super.setUp()
        sut.handCollectionView = collectionView
    }

    func testViewDidLoad() {
        
        sut.viewDidLoad()
        
        XCTAssertNotNil(sut.gameData)
        
    }

    func testDrawCard() {
        sut.bankRollButton = UIButton()
//        XCTAssertEqual(sut.game.bankroll.cardsLeft(), 69)

        sut.drawCard(sut.bankRollButton)
        
//        XCTAssertEqual(sut.game.bankroll.cardsLeft(), 68)
    }
    
    func testCleanupDrawAnimation() {
        
        let card = Card(type: .road)
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
