
import XCTest
@testable import Cartel

class GameDataSourceTests: XCTestCase {

    let sut = GameDataSource(game: Game(), players: [Player(name: "me")])
    let cv = TestableCollectionView(frame: CGRect.null, collectionViewLayout: UICollectionViewFlowLayout())
    
    func testNumberOfSections() {
        
        XCTAssertEqual(sut.numberOfSections(in: cv), 1)
    }
    func testNumberOfItems() {
        
        let items = sut.collectionView(cv, numberOfItemsInSection: 0)
        
        XCTAssertEqual(items, 4)
    }
    
    func testCellForItem() {
        
        let cell = sut.collectionView(cv, cellForItemAt: IndexPath(row: 0, section: 0))
        
        XCTAssertNotNil(cell)
    }

}
