import XCTest
@testable import Cartel

class CityCollectionViewTests: XCTestCase {

    override func setUp() {
        super.setUp()

    }

    override func tearDown() {
        super.tearDown()
    }

    func testInitWithFrame() {
        _ = CityCollectionView(frame: .null)
    }
}
