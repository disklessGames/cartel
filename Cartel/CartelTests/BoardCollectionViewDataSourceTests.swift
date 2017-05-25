import XCTest
@testable import Cartel

class BoardDataTests: XCTestCase {

    let sut = BoardData(players: 2)
    let collectionView = TestableCollectionView(frame: CGRect.null,
                                                collectionViewLayout: UICollectionViewFlowLayout())

    func testNumberOfSections() {

        let sections = sut.numberOfSections(in: collectionView)

        XCTAssertEqual(sections, 2)
    }

    func testSimplePlay() {
        let board = BoardData(players: 2)

        board.play(card: Card(.tJunction), at: 0, playerId: 0)
        board.play(card: Card(.anniewares), at: 1, playerId: 0)
        board.play(card: Card(.captainJuan), at: 0, playerId: 0)

        XCTAssertEqual(board.city[0]?.last?.road, .tJunction)
        XCTAssertEqual(board.city[1]?.last?.building, .anniewares)
        XCTAssertEqual(board.pocket[0]?.count, 1)
    }

    func testPlayStraightRoad() {

        let road = Card(.straight)
        let building = Card(.anniewares)

        sut.play(card: road, at: 0, playerId: 0)
        sut.play(card: building, at: 1, playerId: 0)

        XCTAssertEqual(sut.cards(at: 0)?.last, road)
        XCTAssertEqual(sut.cards(at: 1)?.last, building)
    }

    func testCorrectCellDequeued() {

        let road = Card(.straight)

        sut.play(card: road, at: 0, playerId: 0)

        let index = IndexPath(item: 0, section: 0)
        XCTAssertNotNil(sut.collectionView(collectionView,
                                           cellForItemAt: index))
        XCTAssertTrue(collectionView.dequeueCalled)
    }
}

class TestableCollectionView: UICollectionView {

    var dequeueCalled = false

    override func dequeueReusableCell(withReuseIdentifier identifier: String, for indexPath: IndexPath) -> UICollectionViewCell {
        dequeueCalled = true
        return TestableCell()
    }
}

class TestableCell: CardCell {

    private var image = DraggableCard(Card(.none))

    override var imageView: DraggableCard! {
        get {
            return image
        }
        set {
            image = newValue
        }
    }

    override func configure(_ block: [Card], agents: Int, rotation: CGAffineTransform, isPlayable: Bool) {

    }
}
