import 'package:flutter/material.dart';

enum FaceState {
  playing(path: 'assets/images/faces/playing.png'),
  victory(path: 'assets/images/faces/victory.png'),
  gameOver(path: 'assets/images/faces/game_over.png');

  const FaceState({required this.path});

  final String path;
}

class Face extends StatelessWidget {
  const Face({
    required this.state,
    this.size = 30,
    this.padding = const EdgeInsets.all(6),
    this.onTap,
    super.key,
  });

  final FaceState state;
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
          child: Image.asset(state.path),
        ),
      ),
    );
  }
}
