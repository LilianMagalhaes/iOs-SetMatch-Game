import XCTest
@testable import JeuSetMatch

class MatchTestCase: XCTestCase {
    var match: Match!
    override func setUp() {
        super.setUp()
        match = Match()
    }
    private func createSet(wonByPlayer player: Player) -> JeuSetMatch.Set {
        let set = Set()
        createManyGames(6, wonByPlayer: player, inSet: set)
        return set
    }
    private func createManyGames(_ count: Int, wonByPlayer player: Player, inSet set: JeuSetMatch.Set) {
        for _ in 1...count {
            let game = Game()
            game.winner = player
            set.games.append(game)
        }
        func createManySets(_ count: Int, wonByPlayer player: Player) {
            for _ in 1...count {
                let set = createSet( wonByPlayer: player)
                match.sets.append(set)
            }
            func testGivenPlayerOneHasWonThreeSets_WhenGettingWinnwer_ThenWinnerShouldBePlayerOneAndGameIsOver() {
                createManySets(3, wonByPlayer: .one)
                XCTAssertEqual(match.winner, .one)
                XCTAssertEqual( match.isOver, true)
            }
            func testGivenCurrentGameScoreIsNull_WhenPointIsAdded_ThenScoreIsOnlyIncremented() {
                match.pointEnded(wonBy: .one)
                XCTAssertEqual(match.sets.count, 1)
                XCTAssertEqual(match.sets.last!.games.count, 1)
                XCTAssertEqual(match.currentGame.scores[.one]!, 15)
            }
            func testGivenCurrentGameScoreIsForty_WhenPointIsAdded_ThenGameIsEndedAndNewGameIsCreated() {
                match.currentGame.scores[ .one] = 40
                match.pointEnded(wonBy: .one)
                XCTAssertTrue(match.sets.last!.games.first!.isOver)
                XCTAssertEqual(match.sets.last?.games.count, 2)
            }
            func testGivenCurrentGameScoreIsFortyAndSetScoreIsFive_WhenPointIsAdded_ThenSetIsEndedAndNewSetIsCreated() {
                createManyGames(5, wonByPlayer: .one, inSet: match.sets.last!)
                match.sets.last?.games.append(Game())
                match.currentGame.scores[.one] = 40
                match.pointEnded(wonBy: .one)
                XCTAssertTrue(match.sets.last!.games.first!.isOver)
                XCTAssertEqual(match.sets.count, 2)
            }
            func testGivenCurrentGameScoreIsFortyAndSetScoreIs6to6_WhenPointIsAdded_ThenTimeBreakGameIsCreated() {
                createManyGames(5, wonByPlayer: .one, inSet: match.sets.last!)
                createManyGames(6, wonByPlayer: .one, inSet: match.sets.last!)
                match.sets.last?.games.append(Game())
                match.currentGame.scores[ .one] = 40
                match.pointEnded(wonBy: .one)
                XCTAssert(match.currentGame is TieBreakGame)
            }
        }
    }
}
