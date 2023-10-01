import 'package:flutter/material.dart';

class DialogButton extends StatelessWidget {
  const DialogButton({super.key, required this.btnText});
  final String btnText;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Container(
        height: 40,
        width: MediaQuery.of(context).size.width * 0.5,
        decoration: BoxDecoration(
            color: theme.colorScheme.primary,
            borderRadius: const BorderRadius.all(Radius.circular(8))
        ),
        child: Center(
            child: Text(
              btnText,
              style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onPrimary,
                  fontWeight: FontWeight.bold
              ),
            )
        ),
      ),
    );
  }
}
