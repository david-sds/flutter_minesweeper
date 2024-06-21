import 'package:flutter/material.dart';
import 'package:flutter_minesweeper/components/cell.dart';
import 'package:flutter_minesweeper/components/minesweeper/minesweeper_controller.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

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
    ctrl.initBoard(widget.difficulty);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: List.generate(
          widget.difficulty.y,
          (y) {
            return Row(
              children: List.generate(
                widget.difficulty.x,
                (x) {
                  return Observer(builder: (context) {
                    return Cell(
                      isBomb: ctrl.bombs[x][y],
                      state: ctrl.boardState[x][y],
                      onChangeState: (state) {
                        ctrl.updateCellState(x, y, state);
                      },
                    );
                  });
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
