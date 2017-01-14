
import XCTest
@testable import Cartel

class BoardDataTests: XCTestCase {
    
    let sut = BoardData()
    let collectionView = TestableCollectionView(frame: CGRect.null, collectionViewLayout: UICollectionViewFlowLayout())
    
    func testNumberOfSections() {
        
        let sections = sut.numberOfSections(in: collectionView)
        
        XCTAssertEqual(sections, 2)
    }
    
    func testCreate64X64GridOfNone() {
        for x in 0..<16 {
            for y in 0..<16 {
                XCTAssertEqual(sut.topCardAt(x: x, y: y)?.type, CardType.none)
            }
        }
    }
    
    func testSimplePlay() {
        let board = BoardData()
        
        
        board.playCity(x: 0, y: 0, card: Card(.tJunction))
        board.playCity(x: 0, y: 1, card: Card(.anniewares))
        
        board.playPocket(Card(.captainJuan))
        
        XCTAssertEqual(board.collectionView(collectionView, numberOfItemsInSection: 0), 256)
        XCTAssertEqual(board.collectionView(collectionView, numberOfItemsInSection: 1), 1)
    }
    
    func testPlayStraightRoad() {
        
        let road = Card(.straight)
        let building = Card(.anniewares)
        
        sut.playCity(x: 0, y: 0, card: road)
        sut.playCity(x: 0, y: 1, card: building)
        
        XCTAssertEqual(sut.topCardAt(x:0, y:0), road)
        XCTAssertEqual(sut.topCardAt(x:0, y:1), building)
    }
    
    func testCorrectCellDequeued() {
        
        let road = Card(.straight)
        
        sut.playCity(x: 0, y: 0, card: road)
        
        XCTAssertNotNil(sut.collectionView(collectionView, cellForItemAt: IndexPath(row: 0, section: 0)))
        XCTAssertTrue(collectionView.dequeueCalled)
    }
}

class TestableCollectionView: UICollectionView {
    
    var dequeueCalled = false
    
    override func dequeueReusableCell(withReuseIdentifier identifier: String, for indexPath: IndexPath) -> UICollectionViewCell {
        dequeueCalled = true
        let cell = CardCell()
        cell.imageView = DraggableCard(Card(.road))
        return cell
    }
}
