import XCTest
@testable import JeuSetMatch

class TieBreakGameTestCase: XCTestCase {
  /* MARK: Delete this test/func when is not necessary anymore
   func testGivenInstanceofTieBreakGame_WhenAccessingIt_ThenItExists() {
        let tieBreakGame = TieBreakGame()
        XCTAssertNotNil(tieBreakGame)
    }  */
    var tieBreakGame: TieBreakGame!

    override func setUp() {
        super.setUp()
        tieBreakGame = TieBreakGame()
    }
    func testGivenScoreIs0_WhenIncremetingScore_ThenScoreIs1() {
        tieBreakGame.incrementScore(forPlayer: .one)
        XCTAssertEqual(tieBreakGame.scores[ .one], 1)
    }
    func testGivenScoreIs6_WhenIncremetingScore_ThenScoreIs7AndGameIsOver() {
        tieBreakGame.scores[ .one] = 6
        tieBreakGame.incrementScore(forPlayer: .one)
        XCTAssertEqual(tieBreakGame.scores[ .one], 7)
        XCTAssertEqual(tieBreakGame.winner, .one)
        XCTAssertTrue(tieBreakGame.isOver)
    }
    func testGivenScoreIs6to6_WhenIncremetingScore_ThenScoreIs7to6AndGameIsNotOver() {
        tieBreakGame.scores[ .one] = 6
        tieBreakGame.scores[ .two] = 6
        tieBreakGame.incrementScore(forPlayer: .one)
        XCTAssertEqual(tieBreakGame.scores[ .one], 7)
        XCTAssertEqual(tieBreakGame.scores[ .two], 6)
        XCTAssertFalse(tieBreakGame.isOver)
    }
}
