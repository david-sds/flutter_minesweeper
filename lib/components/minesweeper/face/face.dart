import 'package:flutter/material.dart';

enum GameState {
<<<<<<< HEAD
  playing(faceImagePath: 'assets/images/playing.png'),
  victory(faceImagePath: 'assets/images/victory.png'),
  gameOver(faceImagePath: 'assets/images/game_over.png');
=======
  ready(faceImagePath: 'assets/images/faces/playing.png'),
  playing(faceImagePath: 'assets/images/faces/playing.png'),
  victory(faceImagePath: 'assets/images/faces/victory.png'),
  gameOver(faceImagePath: 'assets/images/faces/game_over.png');
>>>>>>> 2e7235c317888203b161cb5778ed06a2cdcfa87a

  const GameState({required this.faceImagePath});

  final String faceImagePath;
}

class Face extends StatelessWidget {
  const Face({
    required this.state,
    this.size = 30,
    this.padding = const EdgeInsets.all(6),
    this.onTap,
    super.key,
  });

  final GameState state;
  final double size;
  final EdgeInsetsGeometry padding;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(size),
      onTap: onTap,
      child: Padding(
        padding: padding,
        child: SizedBox(
          height: size,
          width: size,
          child: Image.asset(state.faceImagePath),
        ),
      ),
    );
  }
}
