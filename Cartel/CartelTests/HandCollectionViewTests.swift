

import XCTest
@testable import Cartel

class HandCollectionViewTests: XCTestCase {
    
    let sut = HandCollectionView()
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
    
    init() {
        super.init(player: Player(name: "test"))
    }
    var swopCalled = false
}
