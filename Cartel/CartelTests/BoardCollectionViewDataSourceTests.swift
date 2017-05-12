
import XCTest
@testable import Cartel

class BoardDataTests: XCTestCase {
    
    let sut = BoardData()
    let collectionView = TestableCollectionView(frame: CGRect.null, collectionViewLayout: UICollectionViewFlowLayout())
    
    func testNumberOfSections() {
        
        let sections = sut.numberOfSections(in: collectionView)
        
        XCTAssertEqual(sections, 2)
    }
    
    func testCreate32X32GridOfNone() {
        for x in 0..<(10 * 10) {
                XCTAssertNotNil(sut.cards(at: x))
        }
    }
    
    func testSimplePlay() {
        let board = BoardData()
        
        
        board.play(card: Card(.tJunction), at: 0)
        board.play(card: Card(.anniewares), at: 1)
        
        board.playPocket(Card(.captainJuan))
        
        XCTAssertEqual(board.collectionView(collectionView, numberOfItemsInSection: 0), 100)
        XCTAssertEqual(board.collectionView(collectionView, numberOfItemsInSection: 1), 1)
    }
    
    func testPlayStraightRoad() {
        
        let road = Card(.straight)
        let building = Card(.anniewares)
        
        sut.play(card: road, at: 0)
        sut.play(card: building, at: 1)
        
        XCTAssertEqual(sut.cards(at: 0)?.last, road)
        XCTAssertEqual(sut.cards(at: 1)?.last, building)
    }
    
    func testCorrectCellDequeued() {
        
        let road = Card(.straight)
        
        sut.play(card: road, at: 0)
        
        XCTAssertNotNil(sut.collectionView(collectionView, cellForItemAt: IndexPath(row: 0, section: 0)))
        XCTAssertTrue(collectionView.dequeueCalled)
    }
}

class TestableCollectionView: UICollectionView {
    
    var dequeueCalled = false
    
    override func dequeueReusableCell(withReuseIdentifier identifier: String, for indexPath: IndexPath) -> UICollectionViewCell {
        dequeueCalled = true
        return TestableCell()
    }
}

class TestableCell: CardCell {
    
    private var image = DraggableCard(Card(.none))
    
    override var imageView: DraggableCard! {
        get {
            return image
        }
        set {
            image = newValue
        }
    }
    
    override func configure(_ block: [Card], rotation: CGAffineTransform) {
        
    }
    
}
