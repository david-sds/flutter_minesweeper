import 'package:flutter/material.dart';
import 'package:flutter_minesweeper/components/minesweeper/cell/cell.dart';
import 'package:flutter_minesweeper/components/minesweeper/cell/cell_shell/cell_shell.dart';
import 'package:flutter_minesweeper/components/minesweeper/cell/cell_state/cell_state.dart';
import 'package:flutter_minesweeper/components/minesweeper/cell/neighbor_cells/neighbor_cells.dart';

class DefaultCell extends StatelessWidget {
  const DefaultCell({
    required this.state,
    required this.neighborCells,
    required this.onChangeState,
    required this.onClearSurroundingCells,
    required this.cellSize,
    super.key,
  });

  final double cellSize;
  final CellState state;
  final NeighborCells neighborCells;
  final void Function(CellState) onChangeState;
  final void Function(CellState) onClearSurroundingCells;

  @override
  Widget build(BuildContext context) {
    return CellShell(
      state: state,
      size: cellSize,
      color: Colors.blue,
      onLeftClick: () {
        if (state.isBomb) {
          onChangeState(
            state.copyWith(
              type: CellStateTypes.exploded,
            ),
          );
        } else {
          if (neighborCells.bombNumber == 0) {
            onClearSurroundingCells(
              state.copyWith(
                type: CellStateTypes.cleared,
              ),
            );
          } else {
            onChangeState(
              state.copyWith(
                type: CellStateTypes.cleared,
              ),
            );
          }
        }
      },
      onRightClick: () => onChangeState(
        state.copyWith(
          type: CellStateTypes.flag,
        ),
      ),
    );
  }
}
