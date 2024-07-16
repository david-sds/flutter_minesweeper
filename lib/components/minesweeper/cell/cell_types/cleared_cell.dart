import 'package:flutter/material.dart';
import 'package:flutter_minesweeper/components/minesweeper/cell/cell_shell/cell_shell.dart';
import 'package:flutter_minesweeper/components/minesweeper/cell/cell_state/cell_state.dart';
import 'package:flutter_minesweeper/components/minesweeper/cell/neighbor_cells/neighbor_cells.dart';

class ClearedCell extends StatelessWidget {
  const ClearedCell({
    required this.state,
    required this.neighborCells,
    required this.onClearSurroundingCells,
    required this.cellSize,
    super.key,
  });

  final double cellSize;
  final CellState state;
  final NeighborCells neighborCells;
  final void Function(CellState) onClearSurroundingCells;

  @override
  Widget build(BuildContext context) {
    return CellShell(
      state: state,
      size: cellSize,
      bombNumber: neighborCells.bombNumber,
      bombNumberColor: neighborCells.bombNumberColor,
      onLeftClick: () => onClearSurroundingCells(state),
      color: Colors.grey,
    );
  }
}
