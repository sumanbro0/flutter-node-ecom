import 'package:flutter/cupertino.dart';
import 'package:frontend/core/ui.dart';

class LinkButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final Color? color;
  const LinkButton({super.key, required this.text, this.onPressed, this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(color: color ?? AppColors.accent),
        ),
      ),
    );
  }
}
