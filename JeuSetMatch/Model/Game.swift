import Foundation

enum Player {
    case one, two
}

class Game {

    // MARK: - Properties
    private static let points = [0, 15, 30, 40]
    var scores = [Player.one: 0, Player.two: 0]
    var winner: Player?
    var advantagedPlayer: Player?
    var isOver: Bool {
        return winner != nil
    }
    var isEquality: Bool {
        return scores[.one] == 40 && scores[.two] == 40 && advantagedPlayer == nil
    }

    // MARK: - Methods
    func incrementScore(forPlayer player: Player) {
        if scores[player]! < 40 {
            addPoint(toPlayer: player)
        } else if isEquality {
            setAdvantage(toPlayer: player)
        } else if let advtgdPlayer = advantagedPlayer {
            if advtgdPlayer == player {
                end(withWinner: player)
            } else {
                advantagedPlayer = nil
            }
        } else {
            end(withWinner: player)
        }
    }

    private func setAdvantage(toPlayer player: Player) {
        advantagedPlayer = player
    }

    private func addPoint(toPlayer player: Player) {
        if let scoreIndex = Game.points.index(of: scores[player]!) {
            scores[player] = Game.points[scoreIndex + 1]
        }
    }

    fileprivate func end(withWinner winner: Player) {
        self.winner = winner
    }
}

class TieBreakGame: Game {
    private var scoreToReach = 7

    private var isTwoPointsAhead: Bool {
        return abs(scores[.one]! - scores[.two]!) >= 2
    }

    override func incrementScore(forPlayer player: Player) {
        scores[player]! += 1
        if scores[player]! >= scoreToReach && isTwoPointsAhead {
            end(withWinner: player)
        }
    }
}
