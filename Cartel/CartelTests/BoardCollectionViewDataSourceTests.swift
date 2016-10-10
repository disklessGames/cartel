
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
    }
    
    func testPlayStraightRoad() {
        
        let road = RoadCard(type: .straight)
        let building = BuildingCard(buildingType: .anniewares)
        
        sut.play(x: 0, y: 0, card: road)
        sut.play(x: 0, y: 1, card: building)
        
        XCTAssertEqual(sut.getCard(x:0, y:0), road)
        XCTAssertEqual(sut.getCard(x:0, y:1), building)
    }
}

class TestableCollectionView: UICollectionView {
    
}
