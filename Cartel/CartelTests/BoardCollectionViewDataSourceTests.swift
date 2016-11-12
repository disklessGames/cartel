
import XCTest
@testable import Cartel

class BoardDataTests: XCTestCase {
    
    let sut = BoardData()
    let collectionView = TestableCollectionView(frame: CGRect.null, collectionViewLayout: UICollectionViewFlowLayout())
    
    func testNumberOfSections() {
        
        let sections = sut.numberOfSections(in: collectionView)
        
        XCTAssertEqual(sections, 2)
    }
    
    func testNumberOfItemsInSection() {
        let board = BoardData()
        board.play(x: 0, y: 0, card: RoadCard(type: .tJunction))
        board.play(x: 0, y: 1, card: BuildingCard(buildingType: .anniewares))
        
        board.play(x: 0, y: 0, card: PocketCard(pocketType: .captainJuan))
        
        XCTAssertEqual(board.collectionView(collectionView, numberOfItemsInSection: 0), 2)
        XCTAssertEqual(board.collectionView(collectionView, numberOfItemsInSection: 1), 1)
        XCTAssertEqual(board.collectionView(collectionView, numberOfItemsInSection: 2), 0)
    }
    
    func testPlayStraightRoad() {
        
        let road = RoadCard(type: .straight)
        let building = BuildingCard(buildingType: .anniewares)
        
        sut.play(x: 0, y: 0, card: road)
        sut.play(x: 0, y: 1, card: building)
        
        XCTAssertEqual(sut.getCard(x:0, y:0), road)
        XCTAssertEqual(sut.getCard(x:0, y:1), building)
    }
    
    func testCorrectCellDequeued() {
        
        let road = RoadCard(type: .straight)
        
        sut.play(x: 0, y: 0, card: road)
        
        XCTAssertNotNil(sut.collectionView(collectionView, cellForItemAt: IndexPath(row: 0, section: 0)))
        XCTAssertTrue(collectionView.dequeueCalled)
    }
}

class TestableCollectionView: UICollectionView {
    
    var dequeueCalled = false
    
    override func dequeueReusableCell(withReuseIdentifier identifier: String, for indexPath: IndexPath) -> UICollectionViewCell {
        dequeueCalled = true
        let cell = CardCell()
        cell.imageView = DraggableCard(Card(type: .road))
        return cell
    }
}
