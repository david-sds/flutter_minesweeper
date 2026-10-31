import 'package:flutter/material.dart';
import 'package:flutter_minesweeper/components/minesweeper/cell/cell.dart';
import 'package:flutter_minesweeper/components/minesweeper/cell/cell_state/cell_state.dart';
import 'package:flutter_minesweeper/components/minesweeper/cell/neighbor_cells/neighbor_cells.dart';
import 'package:flutter_minesweeper/components/minesweeper/constants.dart';
import 'package:flutter_minesweeper/components/minesweeper/face/face.dart';
import 'package:flutter_minesweeper/components/minesweeper/minesweeper.dart';
import 'package:mobx/mobx.dart';

part 'minesweeper_controller.g.dart';

class MinesweeperController extends MinesweeperControllerBase
    with _$MinesweeperController {}

typedef BoardState = List<List<CellState>>;

abstract class MinesweeperControllerBase with Store {
  @observable
  Difficulty _difficulty = Difficulty.classic;
  @computed
  Difficulty get difficulty => _difficulty;
  @action
  void setDifficulty(Difficulty difficulty) {
    _difficulty = difficulty;
  }

  List<BoardState> _boardStates = [];

  @observable
  BoardState _boardState = [];
  @computed
  BoardState get boardState => _boardState;
  int get boardHash => Object.hashAll(
        _boardState.map((row) => row.map((cell) => cell.isBomb).toString()),
      );
  int get boardStateHash => Object.hashAll(
      _boardState.map((row) => row.map((cell) => cell.toString())));
  @action
  setBoardState(BoardState state) {
    print(
        "STATE ${state.length}x${state[0].length} $boardHash $boardStateHash");
    _boardState = state;
  }

  @action
  void initBoard(Difficulty difficulty) {
    try {
      _difficulty = difficulty;
      setBoardState(_getBoardState(difficulty));
      _boardStates = [];
      _boardStates.add(_boardState);
      final start = DateTime.now();
      for (int i = 0; i < 100; i++) {
        _boardStates.add(_getBoardState(difficulty));
      }
      final end = DateTime.now();
      print(
          '_initBoardState duration ${end.difference(start).inMilliseconds}ms');
    } catch (e) {
      debugPrint('Error while initing board => $e');
    }
  }

  BoardState _getBoardState(Difficulty difficulty) {
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
          ),
        );
      }
    }

    final bombPositions =
        List<int>.generate(difficulty.x * difficulty.y, (i) => i)..shuffle();
    for (var i = 0; i < difficulty.bombNumber; i++) {
      final bombPos = bombPositions.removeLast();
      final y = (bombPos / difficulty.x).floor();
      final x = (bombPos % difficulty.x);

      boardState[x][y].isBomb = true;
    }

    return boardState;
  }

  @computed
  GameState get gameState {
    final boardState = [..._boardState];
    var isEveryEmptyCellCleared = true;
    var isEveryEmptyCellDefault = true;

    for (final boardRowState in boardState) {
      for (final cellState in boardRowState) {
        if (cellState.type == CellStateTypes.exploded) {
          return GameState.gameOver;
        }
        if (!cellState.isBomb && cellState.type != CellStateTypes.cleared) {
          isEveryEmptyCellCleared = false;
        }
        if (cellState.type != CellStateTypes.default_) {
          isEveryEmptyCellDefault = false;
        }
      }
    }

    if (isEveryEmptyCellDefault) {
      return GameState.ready;
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
      setBoardState(boardState);
    } catch (e) {
      debugPrint('Error while updating cells => $e');
    }
  }

  (BoardState?, CellState?) _getCleanStartByCell(CellState value) {
    for (int i = 0; i < _boardStates.length; i++) {
      final board = _boardStates[i];
      final cell = board[value.x][value.y];

      if (cell.isBomb) {
        continue;
      }

      final neighborCells =
          _getNeighborCells(cellState: cell, boardState: board);

      if (neighborCells.bombNumber != 0) {
        continue;
      }

      return (board, cell.copyWith(type: CellStateTypes.cleared));
    }
    return (null, null);
  }

  @action
  void updateCellState(CellState value) {
    if (gameState == GameState.ready) {
      final (boardState, cellState) = _getCleanStartByCell(value);
      if (boardState != null && cellState != null) {
        _boardState = boardState;
        clearAllSurroundingEmptyCells(value: cellState);
      }
    } else {
      updateCellStates([value]);
    }
  }

  @action
  void clearSurroundingCells(CellState value) {
    try {
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
  }) async {
    final cellsToUpdate = await getClearAllSurroundingEmptyCells(
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

  Future<List<CellState>?> getClearAllSurroundingEmptyCells({
    required CellState value,
    required List<CellState> visitedCells,
    required List<CellState> cellsToVisit,
  }) async {
    cellsToVisit.remove(value);
    visitedCells.add(value);

    if (kClearSlowly) {
      updateCellState(value.copyWith(type: CellStateTypes.cleared));
      await Future.delayed(Duration(milliseconds: 1));
    }
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
      await getClearAllSurroundingEmptyCells(
        value: cell,
        visitedCells: visitedCells,
        cellsToVisit: cellsToVisit,
      );
    }

    return visitedCells;
  }

  NeighborCells _getNeighborCells({
    required CellState cellState,
    required BoardState boardState,
  }) {
    try {
      final isTopmostRow = cellState.y == 0;
      final isBottommostRow = cellState.y == difficulty.y - 1;
      final isLeftmostColumn = cellState.x == 0;
      final isRightmostColumn = cellState.x == difficulty.x - 1;

      final neighborCells = NeighborCells();

      if (!isTopmostRow) {
        neighborCells.top = boardState[cellState.x][cellState.y - 1];
      }
      if (!isTopmostRow && !isRightmostColumn) {
        neighborCells.topRight = boardState[cellState.x + 1][cellState.y - 1];
      }
      if (!isRightmostColumn) {
        neighborCells.right = boardState[cellState.x + 1][cellState.y];
      }
      if (!isBottommostRow && !isRightmostColumn) {
        neighborCells.bottomRight =
            boardState[cellState.x + 1][cellState.y + 1];
      }
      if (!isBottommostRow) {
        neighborCells.bottom = boardState[cellState.x][cellState.y + 1];
      }
      if (!isBottommostRow && !isLeftmostColumn) {
        neighborCells.bottomLeft = boardState[cellState.x - 1][cellState.y + 1];
      }
      if (!isLeftmostColumn) {
        neighborCells.left = boardState[cellState.x - 1][cellState.y];
      }
      if (!isTopmostRow && !isLeftmostColumn) {
        neighborCells.topLeft = boardState[cellState.x - 1][cellState.y - 1];
      }

      return neighborCells;
    } catch (e) {
      debugPrint(
        'Error while getting NeighborCells (${cellState.x}, ${cellState.y})=> $e',
      );
    }
    return NeighborCells();
  }

  NeighborCells getNeighborCells(CellState value) {
    return _getNeighborCells(
      cellState: value,
      boardState: boardState,
    );
  }

  @computed
  int get numberFlagged {
    var flagCount = 0;
    for (final cellList in boardState) {
      for (final cell in cellList) {
        if (cell.type == CellStateTypes.flag) {
          flagCount++;
        }
      }
    }
    return difficulty.bombNumber - flagCount;
  }
}
