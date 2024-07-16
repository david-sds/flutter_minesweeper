import 'package:flutter/material.dart';
import 'package:flutter_minesweeper/components/minesweeper/cell/cell_state/cell_state.dart';
import 'package:flutter_minesweeper/components/minesweeper/cell/cell_types/cleared_cell.dart';
import 'package:flutter_minesweeper/components/minesweeper/cell/cell_types/default_cell.dart';
import 'package:flutter_minesweeper/components/minesweeper/cell/cell_types/exploded_cell.dart';
import 'package:flutter_minesweeper/components/minesweeper/cell/cell_types/flagged_cell.dart';
import 'package:flutter_minesweeper/components/minesweeper/cell/cell_types/question_cell.dart';
import 'package:flutter_minesweeper/components/minesweeper/cell/neighbor_cells/neighbor_cells.dart';
import 'package:flutter_minesweeper/components/minesweeper/face/face.dart';

enum CellStateTypes {
  default_,
  cleared,
  flag,
  question,
  exploded;
}

class Cell extends StatelessWidget {
  const Cell({
    required this.state,
    required this.gameState,
    required this.neighborCells,
    required this.onChangeState,
    required this.onClearSurroundingCells,
    this.cellSize = 30,
    super.key,
  });

  final CellState state;
  final GameState gameState;
  final NeighborCells neighborCells;
  final void Function(CellState) onChangeState;
  final void Function(CellState) onClearSurroundingCells;
  final double cellSize;

  @override
  Widget build(BuildContext context) {
    if (gameState == GameState.gameOver) {
      if (state.isBomb) {
        return ExplodedCell(
          state: state,
          onChangeState: onChangeState,
          cellSize: cellSize,
        );
      } else {
        return ClearedCell(
          state: state,
          neighborCells: neighborCells,
          onClearSurroundingCells: onClearSurroundingCells,
          cellSize: cellSize,
        );
      }
    }

    switch (state.type) {
      case CellStateTypes.default_:
        return DefaultCell(
          state: state,
          neighborCells: neighborCells,
          onChangeState: onChangeState,
          onClearSurroundingCells: onClearSurroundingCells,
          cellSize: cellSize,
        );
      case CellStateTypes.cleared:
        return ClearedCell(
          state: state,
          neighborCells: neighborCells,
          onClearSurroundingCells: onClearSurroundingCells,
          cellSize: cellSize,
        );
      case CellStateTypes.exploded:
        return ExplodedCell(
          state: state,
          onChangeState: onChangeState,
          cellSize: cellSize,
        );
      case CellStateTypes.flag:
        return FlaggedCell(
          state: state,
          onChangeState: onChangeState,
          cellSize: cellSize,
        );
      case CellStateTypes.question:
        return QuestionCell(
          state: state,
          onChangeState: onChangeState,
          cellSize: cellSize,
        );
      default:
        return const SizedBox();
    }
  }
}
