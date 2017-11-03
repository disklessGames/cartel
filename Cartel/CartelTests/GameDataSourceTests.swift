import XCTest
@testable import Cartel

class HandDataSourceTests: XCTestCase {

    var sut: HandDataSource!
    let cv = TestableCollectionView(frame: CGRect.null, collectionViewLayout: UICollectionViewFlowLayout())
    let player = Player(id: 1, name: "Me", color: .red)

    override func setUp() {
        super.setUp()
        sut = HandDataSource(player: player)
    }

    func testNumberOfSections() {

        XCTAssertEqual(sut.numberOfSections(in: cv), 1)
    }

    func testNumberOfItems() {

        sut.add(card: Card(.road))

        let items = sut.collectionView(cv, numberOfItemsInSection: 0)

        XCTAssertEqual(items, 1)
    }

    func testCellForItem() {

        sut.add(card: Card(.road))

        let cell = sut.collectionView(cv, cellForItemAt: IndexPath(row: 0, section: 0))

        XCTAssertNotNil(cell)
    }

    func testSwop() {

        sut.add(card: Card(.anniewares))
        sut.add(card: Card(.snitch))

        sut.swop(0, 1)

        XCTAssertEqual(player.peekCard(index: 0)?.pocket, PocketCardType.snitch)
        XCTAssertEqual(player.peekCard(index: 1)?.building, BuildingCardType.anniewares)
    }

    func testCanMove_AlwaysTrue() {

        let canMove = sut.collectionView(cv, canMoveItemAt: IndexPath(item: 10, section: 10))

        XCTAssertTrue(canMove)
    }

    func testPlayCard_PlaysFromCurrentPlayersHand() {

        let cardToPlay = Card(.snitch)
        player.hand.append(cardToPlay)

        let cardPlayed = sut.playCard(at: 0)

        XCTAssertEqual(cardToPlay, cardPlayed)
    }
}
