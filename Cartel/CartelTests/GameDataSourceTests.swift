
import XCTest
@testable import Cartel

class HandDataSourceTests: XCTestCase {

    let sut = HandDataSource(player: Player(name: "me"))
    let cv = TestableCollectionView(frame: CGRect.null, collectionViewLayout: UICollectionViewFlowLayout())
    
    override func setUp() {
        super.setUp()
        let player = Player(name: "Me")
        player.add(card: Card(.road))
        sut.player = player
    }

    func testNumberOfSections() {
        
        XCTAssertEqual(sut.numberOfSections(in: cv), 1)
    }
    func testNumberOfItems() {
        
        let items = sut.collectionView(cv, numberOfItemsInSection: 0)
        
        XCTAssertEqual(items, 1)
    }
    
    func testCellForItem() {
        
        let cell = sut.collectionView(cv, cellForItemAt: IndexPath(row: 0, section: 0))
        
        XCTAssertNotNil(cell)
    }

}
