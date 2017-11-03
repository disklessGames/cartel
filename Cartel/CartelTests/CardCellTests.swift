
import XCTest
@testable import Cartel

class CardCellTests : XCTestCase {

    let sut = CardCell()

    override func setUp() {
        super.setUp()
        sut.imageView = DraggableCard(Card(.none))
        sut.countLabel = UILabel()
        sut.player2 = UILabel()
    }

    func testPrepareForReuse_removesSubviews() {

        sut.imageView.addSubview(UIView())

        sut.prepareForReuse()

        XCTAssertTrue(sut.imageView.subviews.isEmpty)
    }

    func testShowStackedImagesFor3Cards_Adds2Subviews() {

        let cards = [Card(.groundhogCoffees),
                     Card(.anniewares),
                     Card(.efficientConsulting)]

        sut.showStackedImages(cards)

        XCTAssertEqual(sut.imageView.subviews.count, 2)
    }

    func testConfigureForRoad_ShowsNoText() {

        sut.configure([Card(.leftTurn)], agents: 0, rotation: .identity, isPlayable: false)

        XCTAssertEqual(sut.countLabel.text, "")
        XCTAssertEqual(sut.player2.text, "")
    }

    func testConfigureForNone_ShowsNoText() {

        sut.configure([Card(.none)], agents: 0, rotation: .identity, isPlayable: false)

        XCTAssertEqual(sut.countLabel.text, "")
        XCTAssertEqual(sut.player2.text, "")
    }

    func testConfigureForBuilding_ShowsText() {

        sut.configure([Card(.anniewares)], agents: 0, rotation: .identity, isPlayable: false)

        XCTAssertEqual(sut.countLabel.text, "")
        XCTAssertEqual(sut.player2.text, "")
    }

    func testConfigureForAgents_Shows2() {
        sut.configure([Card(.anniewares)], agents: 5, rotation: .identity, isPlayable: false)

        XCTAssertEqual(sut.countLabel.text, "5")
        XCTAssertEqual(sut.player2.text, "5")
    }

    func testConfigureForPlayable_ShowsBorder() {

        sut.configure([], agents: 0, rotation: .identity, isPlayable: true)

        XCTAssertTrue(sut.layer.borderWidth > 0)
    }

    func testConfigureForNotPlayable_HidesBorder() {

        sut.configure([], agents: 0, rotation: .identity, isPlayable: false)

        XCTAssertTrue(sut.layer.borderWidth == 0)
    }
}
