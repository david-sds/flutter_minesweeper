import 'package:flutter/material.dart';
import 'package:flutter_minesweeper/components/minesweeper/board/board.dart';
import 'package:flutter_minesweeper/components/minesweeper/minesweeper_controller.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

enum Difficulty {
  classic(
    x: 8,
    y: 8,
    bombNumber: 9,
  ),
  easy(
    x: 9,
    y: 9,
    bombNumber: 10,
  ),
  medium(
    x: 16,
    y: 16,
    bombNumber: 40,
  ),
  expert(
    x: 30,
    y: 16,
    bombNumber: 99,
  );

  const Difficulty({
    required this.x,
    required this.y,
    required this.bombNumber,
  });

  final int x;
  final int y;
  final int bombNumber;
}

class Minesweeper extends StatefulWidget {
  const Minesweeper({
    this.difficulty = Difficulty.classic,
    super.key,
  });

  final Difficulty difficulty;

  @override
  State<Minesweeper> createState() => _MinesweeperState();
}

class _MinesweeperState extends State<Minesweeper> {
  final ctrl = MinesweeperController();

  @override
  void initState() {
    ctrl.setDifficulty(widget.difficulty);
    ctrl.initBoard();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          onPressed: () {
            ctrl.initBoard();
          },
          icon: const Icon(Symbols.face),
        ),
        Observer(builder: (context) {
          return Expanded(
            child: Board(
              difficulty: widget.difficulty,
              boardState: ctrl.boardState,
              onGetNeighborCells: ctrl.getNeighborCells,
              onChangeState: (state) {
                ctrl.updateCellState(state);
              },
              onClearSurroundingCells: (state) {
                ctrl.clearSurroundingCells(state);
              },
            ),
          );
        })
      ],
    );
  }
}
