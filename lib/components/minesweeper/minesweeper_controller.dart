import 'package:flutter_minesweeper/components/cell.dart';
import 'package:flutter_minesweeper/components/minesweeper/minesweeper.dart';
import 'package:mobx/mobx.dart';

part 'minesweeper_controller.g.dart';

class MinesweeperController extends MinesweeperControllerBase
    with _$MinesweeperController {}

abstract class MinesweeperControllerBase with Store {
  @observable
  List<List<CellState>> _boardState = [];
  @computed
  List<List<CellState>> get boardState => _boardState;

  @observable
  List<List<bool>> _bombs = [];
  @computed
  List<List<bool>> get bombs => _bombs;

  @action
  void initBoard(Difficulty difficulty) {
    final boardState = <List<CellState>>[];
    for (var i = 0; i < difficulty.x; i++) {
      boardState.add([]);
      bombs.add(List.generate(difficulty.y, (i) => false));
      for (var j = 0; j < difficulty.y; j++) {
        boardState[i].add(CellState.default_);
      }
    }
    final bombPositions =
        List<int>.generate(difficulty.x * difficulty.y, (i) => i + 1)
          ..shuffle();
    for (var i = 0; i < difficulty.bombNumber; i++) {
      final bombPos = bombPositions.removeLast();
      final y = (bombPos / difficulty.x).floor();
      final x = (bombPos % difficulty.x);
      bombs[x][y] = true;
    }
    _boardState = boardState;
    _bombs = bombs;
  }

  @action
  void updateCellState(int x, int y, CellState value) {
    final boardState = [..._boardState];
    boardState[x][y] = value;
    _boardState = boardState;
  }
}
