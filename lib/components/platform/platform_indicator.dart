import 'package:comfort_confy/themes/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlatformProgressIndicator extends StatelessWidget {
  const PlatformProgressIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (theme.isMaterial) {
      return CircularProgressIndicator(
        color: theme.primaryColor,
      );
    }
    return CupertinoActivityIndicator(
      color: theme.primaryColor,
      radius: 20,
    );
  }
}