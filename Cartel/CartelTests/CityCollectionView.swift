
import XCTest
@testable import Cartel

class CityCollectionViewTests: XCTestCase {
    
    override func setUp() {
        super.setUp()

    }
    
    override func tearDown() {
    
        super.tearDown()
    }
    
    func testCanCreate() {
    
        _ = CityCollectionView(frame: CGRect.null, collectionViewLayout: UICollectionViewFlowLayout())
        
    }
}
