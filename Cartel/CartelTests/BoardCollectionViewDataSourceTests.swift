
import XCTest
@testable import Cartel

class BoardCollectionViewDataSourceTests: XCTestCase {

    let sut = BoardCollectionViewDataSource()
    let collectionView = TestableCollectionView(frame: CGRect.null, collectionViewLayout: UICollectionViewFlowLayout())

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testCreate(){
        
        XCTAssertNotNil(sut)
    }
    
    func testNumberOfSections() {
        
        let sections = sut.numberOfSections(in: collectionView)
        
        XCTAssertEqual(sections, 2)
    }
    
    func testNumberOfItemsInSection() {
        let city = [RoadCard(roadType: .tJunction), BuildingCard(buildingType: .anniewares)]
        let pocket = [PocketCard(pocketType: .captainJuan)]
        
        let board = BoardCollectionViewDataSource(city: city, pocket: pocket)
        
        XCTAssertEqual(board.collectionView(collectionView, numberOfItemsInSection: 0), 2)
        XCTAssertEqual(board.collectionView(collectionView, numberOfItemsInSection: 1), 1)
    }
}

class TestableCollectionView: UICollectionView {
    
}
