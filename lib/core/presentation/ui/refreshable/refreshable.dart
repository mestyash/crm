import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

typedef RefreshCallback = Future<void> Function();

class Refreshable extends StatefulWidget {
  const Refreshable({
    Key? key,
    required this.isLoading,
    required this.onRefresh,
    required this.child,
    this.displacement,
    this.notificationPredicate,
  }) : super(key: key);

  final Widget child;
  final bool isLoading;
  final RefreshCallback onRefresh;
  final double? displacement;
  final ScrollNotificationPredicate? notificationPredicate;

  @override
  State<StatefulWidget> createState() => _RefreshableState();
}

class _RefreshableState extends State<Refreshable> {
  final _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>(debugLabel: '_refreshIndicatorKey');

  @override
  Widget build(BuildContext context) {
    if (widget.isLoading) {
      _refreshIndicatorKey.currentState?.show();
    }

    return RefreshIndicator(
      key: _refreshIndicatorKey,
      child: widget.child,
      onRefresh: widget.onRefresh,
      displacement: widget.displacement ?? 40.r,
      notificationPredicate:
          widget.notificationPredicate ?? defaultScrollNotificationPredicate,
    );
  }
}
