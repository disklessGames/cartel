
import XCTest
@testable import Cartel

class BoardCollectionViewDataSourceTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testCreate(){
        let cards = [Card()]
        let sut = BoardCollectionViewDataSource(cards: cards)
        
        XCTAssertNotNil(sut)
    }
}
