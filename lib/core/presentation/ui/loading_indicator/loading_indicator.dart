import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    return Center(
      child: CircularProgressIndicator(
        color: _theme.primaryColor,
      ),
    );
  }
}
