import 'package:flutter/material.dart';

import '../constants/dimens.dart';

class CardContainer extends StatelessWidget {
  const CardContainer({
    super.key,
    required this.child,
    this.isTopRounded = false,
    this.isBottomRounded = false,
    this.color = Colors.white,
  });

  final Widget child;
  final bool isTopRounded;
  final bool isBottomRounded;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(Dimens.extraLarge),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.only(
          topLeft: isTopRounded
              ? const Radius.circular(Dimens.large)
              : const Radius.circular(0),
          topRight: isTopRounded
              ? const Radius.circular(Dimens.large)
              : const Radius.circular(0),
          bottomLeft: isBottomRounded
              ? const Radius.circular(Dimens.large)
              : const Radius.circular(0),
          bottomRight: isBottomRounded
              ? const Radius.circular(Dimens.large)
              : const Radius.circular(0),
        ),
      ),
      child: child,
    );
  }
}
