import 'package:flutter/material.dart';
import 'package:flutter_minesweeper/components/minesweeper/cell/cell.dart';
import 'package:flutter_minesweeper/components/minesweeper/cell/cell_state/cell_state.dart';
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

  @action
  void initBoard(Difficulty difficulty) {
    try {
      final boardState = <List<CellState>>[];

      for (var i = 0; i < difficulty.x; i++) {
        boardState.add([]);
        for (var j = 0; j < difficulty.y; j++) {
          boardState[i].add(
            CellState(
              x: i,
              y: j,
              type: CellStateTypes.default_,
              isBomb: false,
              closeCells: CloseCells(),
            ),
          );
        }
      }

      final bombPositions =
          List<int>.generate(difficulty.x * difficulty.y, (i) => i + 1)
            ..shuffle();
      for (var i = 0; i < difficulty.bombNumber; i++) {
        final bombPos = bombPositions.removeLast();
        final y = (bombPos / difficulty.x).floor();
        final x = (bombPos % difficulty.x);

        boardState[x][y].isBomb = true;
      }

      for (var i = 0; i < difficulty.x; i++) {
        for (var j = 0; j < difficulty.y; j++) {
          final state = boardState[i][j];

          final isTopmostRow = j == 0;
          final isBottommostRow = j == difficulty.y - 1;
          final isLeftmostColumn = i == 0;
          final isRightmostColumn = i == difficulty.x - 1;

          if (!isTopmostRow) {
            state.closeCells.top = boardState[i][j - 1];
          }
          if (!isTopmostRow && !isRightmostColumn) {
            state.closeCells.topRight = boardState[i + 1][j - 1];
          }
          if (!isRightmostColumn) {
            state.closeCells.right = boardState[i + 1][j];
          }
          if (!isBottommostRow && !isRightmostColumn) {
            state.closeCells.bottomRight = boardState[i + 1][j + 1];
          }
          if (!isBottommostRow) {
            state.closeCells.bottom = boardState[i][j + 1];
          }
          if (!isBottommostRow && !isLeftmostColumn) {
            state.closeCells.bottomLeft = boardState[i - 1][j + 1];
          }
          if (!isLeftmostColumn) {
            state.closeCells.left = boardState[i - 1][j];
          }
          if (!isTopmostRow && !isLeftmostColumn) {
            state.closeCells.topLeft = boardState[i - 1][j - 1];
          }
        }
      }

      _boardState = boardState;
    } catch (e) {
      debugPrint('error while initing board => $e');
    }
  }

  @action
  void updateCellState(int x, int y, CellState value) {
    try {
      final boardState = [..._boardState];
      boardState[x][y] = value;
      _boardState = boardState;
    } catch (e) {
      debugPrint('error while updating cell => $e');
    }
  }

  @action
  void clearSurroundingCell(CellState value) {
    try {
      final bombNumber = value.closeCells.bombNumber;
      final surroundingFlaggedCellsNumber = value.closeCells.values
          .where((cell) => cell?.type == CellStateTypes.flag)
          .length;
      print(surroundingFlaggedCellsNumber);
      print(value.closeCells.values.map((e) => e?.type.toString()).toList());
      if (bombNumber == surroundingFlaggedCellsNumber) {
        print('teste');

        for (final neighborCell in value.closeCells.values) {
          final x = neighborCell?.x;
          final y = neighborCell?.y;
          final updatedState = neighborCell?.copyWith(
            type: neighborCell.isBomb
                ? CellStateTypes.exploded
                : CellStateTypes.empty,
          );

          if (x == null || y == null || updatedState == null) {
            continue;
          }

          updateCellState(
            x,
            y,
            updatedState,
          );
        }
      }
    } catch (e) {
      debugPrint('error while clearing surrounding cells => $e');
    }
  }
}
