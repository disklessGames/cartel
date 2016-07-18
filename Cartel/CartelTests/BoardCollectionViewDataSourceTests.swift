
import XCTest
import Cartel

class BoardCollectionViewDataSourceTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testCreate(){
        let sut = BoardCollectionViewDataSource()
        
        XCTAssertNotNil(sut)
    }
}
