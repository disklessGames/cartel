

import XCTest
@testable import Cartel

class HandCollectionViewTests: XCTestCase {
    
    let sut = HandCollectionView(frame: CGRect.null, collectionViewLayout: UICollectionViewFlowLayout())
    let data = TestableHandDataSource()
    
    override func setUp() {
        super.setUp()
        
        sut.dataSource = data

    }
    
    override func tearDown() {
    
        super.tearDown()
    }
    
    func testSwop() {
        
        sut.moveItem(at: IndexPath(item: 1, section: 0), to: IndexPath(item: 2, section: 0))
        
        XCTAssertTrue(data.swopCalled)
    }
}

class TestableHandDataSource: HandDataSource {
    
    var swopCalled = false
    
    init() {
        super.init(player: Player(name: "test", color: .red))
    }
    
    override func swop(_ first: Int, _ second: Int) {
        swopCalled = true
    }
}
