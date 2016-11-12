
import XCTest
@testable import Cartel

class GameDataSourceTests: XCTestCase {

    let sut = GameDataSource(game: Game())
    let collectionView = TestableCollectionView(frame: CGRect.null, collectionViewLayout: UICollectionViewFlowLayout())
    
    func testNumberOfSections() {
        
        XCTAssertEqual(sut.numberOfSections(in: collectionView), 1)
    }
    func testNumberOfItems() {
        
        let items = sut.collectionView(collectionView, numberOfItemsInSection: 0)
        
        XCTAssertEqual(items, 4)
    }
    
    func testCellForItem() {
        
        let cell = sut.collectionView(collectionView, cellForItemAt: IndexPath(row: 0, section: 0))
        
        XCTAssertNotNil(cell)
    }

}
