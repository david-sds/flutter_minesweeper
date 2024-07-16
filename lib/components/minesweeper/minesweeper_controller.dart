import 'package:flutter/material.dart';
import 'package:flutter_minesweeper/components/minesweeper/cell/cell.dart';
import 'package:flutter_minesweeper/components/minesweeper/cell/cell_state/cell_state.dart';
import 'package:flutter_minesweeper/components/minesweeper/cell/neighbor_cells/neighbor_cells.dart';
import 'package:flutter_minesweeper/components/minesweeper/face/face.dart';
import 'package:flutter_minesweeper/components/minesweeper/minesweeper.dart';
import 'package:mobx/mobx.dart';

part 'minesweeper_controller.g.dart';

class MinesweeperController extends MinesweeperControllerBase
    with _$MinesweeperController {}

abstract class MinesweeperControllerBase with Store {
  @observable
  Difficulty _difficulty = Difficulty.classic;
  @computed
  Difficulty get difficulty => _difficulty;
  @action
  void setDifficulty(Difficulty difficulty) {
    _difficulty = difficulty;
  }

  @observable
  List<List<CellState>> _boardState = [];
  @computed
  List<List<CellState>> get boardState => _boardState;

  @action
  void initBoard(Difficulty difficulty) {
    try {
      _difficulty = difficulty;
      final boardState = <List<CellState>>[];

      for (var i = 0; i < _difficulty.x; i++) {
        boardState.add([]);
        for (var j = 0; j < _difficulty.y; j++) {
          boardState[i].add(
            CellState(
              x: i,
              y: j,
              type: CellStateTypes.default_,
              isBomb: false,
            ),
          );
        }
      }

      final bombPositions =
          List<int>.generate(_difficulty.x * _difficulty.y, (i) => i)
            ..shuffle();
      for (var i = 0; i < _difficulty.bombNumber; i++) {
        final bombPos = bombPositions.removeLast();
        final y = (bombPos / _difficulty.x).floor();
        final x = (bombPos % _difficulty.x);

        boardState[x][y].isBomb = true;
      }

      _boardState = boardState;
    } catch (e) {
      debugPrint('Error while initing board => $e');
    }
  }

  @computed
  GameState get gameState {
    final boardState = [..._boardState];
    var isEveryEmptyCellCleared = true;

    for (final boardRowState in boardState) {
      for (final cellState in boardRowState) {
        if (cellState.type == CellStateTypes.exploded) {
          return GameState.gameOver;
        }
        if (!cellState.isBomb && cellState.type != CellStateTypes.cleared) {
          isEveryEmptyCellCleared = false;
        }
      }
    }

    if (isEveryEmptyCellCleared) {
      return GameState.victory;
    }

    return GameState.playing;
  }

  @action
  void updateCellStates(List<CellState> values) {
    try {
      final boardState = [..._boardState];
      for (final value in values) {
        boardState[value.x][value.y] = value;
      }
      _boardState = boardState;
    } catch (e) {
      debugPrint('Error while updating cells => $e');
    }
  }

  @action
  void updateCellState(CellState value) => updateCellStates([value]);

  @action
  void clearSurroundingCells(CellState value) {
    try {
      updateCellState(value);
      final neighborCells = getNeighborCells(value);

      if (neighborCells.bombNumber == 0) {
        clearAllSurroundingEmptyCells(value: value);
      } else {
        clearUnflaggedNeighborCells(neighborCells);
      }
    } catch (e) {
      debugPrint('Error while clearing surrounding cells => $e');
    }
  }

  void clearUnflaggedNeighborCells(NeighborCells neighborCells) {
    final bombNumber = neighborCells.bombNumber;
    final surroundingFlaggedCellsNumber = neighborCells.values
        .where((cell) => cell?.type == CellStateTypes.flag)
        .length;
    if (bombNumber == surroundingFlaggedCellsNumber) {
      for (final neighborCell in neighborCells.values) {
        if (neighborCell == null || neighborCell.type == CellStateTypes.flag) {
          continue;
        }
        if (getNeighborCells(neighborCell).bombNumber == 0) {
          clearAllSurroundingEmptyCells(value: neighborCell);
        }
        final updatedState = neighborCell.copyWith(
          type: neighborCell.isBomb
              ? CellStateTypes.exploded
              : CellStateTypes.cleared,
        );

        updateCellState(
          updatedState,
        );
      }
    }
  }

  void clearAllSurroundingEmptyCells({
    required CellState value,
  }) {
    final cellsToUpdate = getClearAllSurroundingEmptyCells(
      value: value,
      visitedCells: [],
      cellsToVisit: [],
    );
    updateCellStates(
      (cellsToUpdate ?? [])
          .map((e) => e.copyWith(type: CellStateTypes.cleared))
          .toList(),
    );
  }

  List<CellState>? getClearAllSurroundingEmptyCells({
    required CellState value,
    required List<CellState> visitedCells,
    required List<CellState> cellsToVisit,
  }) {
    cellsToVisit.remove(value);
    visitedCells.add(value);

    updateCellState(value.copyWith(type: CellStateTypes.cleared));
    final neighborCells = getNeighborCells(value);

    if (neighborCells.bombNumber > 0) {
      return null;
    }

    cellsToVisit.addAll(
      neighborCells.values.whereType<CellState>().where(
        (cell) {
          final isVisited = visitedCells.any(
            (e) => e.x == cell.x && e.y == cell.y,
          );
          final isToVisit = cellsToVisit.any(
            (e) => e.x == cell.x && e.y == cell.y,
          );
          return !isVisited && !isToVisit;
        },
      ),
    );

    while (cellsToVisit.isNotEmpty) {
      final cell = cellsToVisit.first;
      getClearAllSurroundingEmptyCells(
        value: cell,
        visitedCells: visitedCells,
        cellsToVisit: cellsToVisit,
      );
    }

    return visitedCells;
  }

  NeighborCells getNeighborCells(CellState value) {
    try {
      final isTopmostRow = value.y == 0;
      final isBottommostRow = value.y == difficulty.y - 1;
      final isLeftmostColumn = value.x == 0;
      final isRightmostColumn = value.x == difficulty.x - 1;

      final neighborCells = NeighborCells();

      if (!isTopmostRow) {
        neighborCells.top = boardState[value.x][value.y - 1];
      }
      if (!isTopmostRow && !isRightmostColumn) {
        neighborCells.topRight = boardState[value.x + 1][value.y - 1];
      }
      if (!isRightmostColumn) {
        neighborCells.right = boardState[value.x + 1][value.y];
      }
      if (!isBottommostRow && !isRightmostColumn) {
        neighborCells.bottomRight = boardState[value.x + 1][value.y + 1];
      }
      if (!isBottommostRow) {
        neighborCells.bottom = boardState[value.x][value.y + 1];
      }
      if (!isBottommostRow && !isLeftmostColumn) {
        neighborCells.bottomLeft = boardState[value.x - 1][value.y + 1];
      }
      if (!isLeftmostColumn) {
        neighborCells.left = boardState[value.x - 1][value.y];
      }
      if (!isTopmostRow && !isLeftmostColumn) {
        neighborCells.topLeft = boardState[value.x - 1][value.y - 1];
      }

      return neighborCells;
    } catch (e) {
      debugPrint(
        'Error while getting NeighborCells (${value.x}, ${value.y})=> $e',
      );
    }
    return NeighborCells();
  }
}
