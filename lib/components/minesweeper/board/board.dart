import 'package:flutter/material.dart';
import 'package:flutter_minesweeper/components/minesweeper/cell/cell.dart';
import 'package:flutter_minesweeper/components/minesweeper/cell/cell_state/cell_state.dart';
import 'package:flutter_minesweeper/components/minesweeper/cell/neighbor_cells/neighbor_cells.dart';
import 'package:flutter_minesweeper/components/minesweeper/minesweeper.dart';

class Board extends StatelessWidget {
  const Board({
    required this.difficulty,
    required this.boardState,
    required this.onChangeState,
    required this.onClearSurroundingCells,
    required this.onGetNeighborCells,
    super.key,
  });

  final Difficulty difficulty;
  final List<List<CellState>> boardState;
  final void Function(CellState) onChangeState;
  final void Function(CellState) onClearSurroundingCells;
  final NeighborCells Function(CellState value) onGetNeighborCells;

  double getCellSize(BoxConstraints constraints) {
    var maxCellSizeWidth = 30.0;
    var maxCellSizeHeight = 30.0;

    if (difficulty.x * maxCellSizeWidth > constraints.maxWidth) {
      maxCellSizeWidth = constraints.maxWidth / difficulty.x;
    }

    if (difficulty.y * maxCellSizeHeight > constraints.maxHeight) {
      maxCellSizeHeight = constraints.maxHeight / difficulty.y;
    }

    return maxCellSizeWidth < maxCellSizeHeight
        ? maxCellSizeWidth
        : maxCellSizeHeight;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth;
      final height = constraints.maxHeight;
      return Container(
        color: Colors.grey[600],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            boardState.length,
            (y) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  boardState[y].length,
                  (x) {
                    final cellState = boardState[x][y];
                    return Cell(
                      cellSize: getCellSize(constraints),
                      state: cellState,
                      neighborCells: onGetNeighborCells(cellState),
                      onChangeState: onChangeState,
                      onClearSurroundingCells: onClearSurroundingCells,
                    );
                  },
                ),
              );
            },
          ),
        ),
      );
    });
  }
}
