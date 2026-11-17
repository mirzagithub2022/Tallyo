import XCTest
@testable import Tallyo

@MainActor
final class TallyoViewModelTests: XCTestCase {

    func testIncrementIncreasesCount() {
        let tallyo = TallyoViewModel()
        XCTAssertTrue(tallyo.increment())
        XCTAssertEqual(tallyo.count, 1)
    }

    func testIncrementStopsAtLimit() {
        let tallyo = TallyoViewModel()
        tallyo.limit = .thirty
        for _ in 0..<40 { tallyo.increment() }
        XCTAssertEqual(tallyo.count, 30)
        XCTAssertTrue(tallyo.isAtLimit)
        XCTAssertFalse(tallyo.increment())
    }

    func testResetClearsCount() {
        let tallyo = TallyoViewModel()
        tallyo.increment()
        tallyo.reset()
        XCTAssertEqual(tallyo.count, 0)
    }

    func testLoweringLimitClampsCount() {
        let tallyo = TallyoViewModel()
        tallyo.limit = .hundred
        for _ in 0..<80 { tallyo.increment() }
        tallyo.limit = .sixty
        XCTAssertEqual(tallyo.count, 60)
    }

    func testProgressIsFractionOfLimit() {
        let tallyo = TallyoViewModel()
        tallyo.limit = .sixty
        for _ in 0..<30 { tallyo.increment() }
        XCTAssertEqual(tallyo.progress, 0.5, accuracy: 0.0001)
    }
}
