import 'package:flutter/material.dart';
import 'package:flutter_minesweeper/components/minesweeper/cell/cell.dart';
import 'package:flutter_minesweeper/components/minesweeper/cell/cell_state/cell_state.dart';
import 'package:flutter_minesweeper/components/minesweeper/cell/neighbor_cells/neighbor_cells.dart';
import 'package:flutter_minesweeper/components/minesweeper/face/face.dart';

class Board extends StatelessWidget {
  const Board({
    required this.boardState,
    required this.gameState,
    required this.cellSize,
    required this.isHorizontalView,
    required this.onGetNeighborCells,
    required this.onUpdateCellState,
    required this.onClearSurroundingCells,
    super.key,
  });

  final List<List<CellState>> boardState;
  final GameState gameState;
  final double cellSize;
  final bool isHorizontalView;
  final NeighborCells Function(CellState state) onGetNeighborCells;
  final void Function(CellState state) onUpdateCellState;
  final void Function(CellState state) onClearSurroundingCells;

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: isHorizontalView ? Axis.horizontal : Axis.vertical,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        boardState.length,
        (x) {
          return Flex(
            direction: isHorizontalView ? Axis.vertical : Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              boardState[x].length,
              (y) {
                final cellState = boardState[x][y];
                return Cell(
                  cellSize: cellSize,
                  state: cellState,
                  gameState: gameState,
                  neighborCells: onGetNeighborCells(cellState),
                  onChangeState: onUpdateCellState,
                  onClearSurroundingCells: onClearSurroundingCells,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
