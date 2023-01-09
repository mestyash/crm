import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerContainer extends StatelessWidget {
  final double width;
  final double height;
  final EdgeInsetsGeometry? margin;
  final double? borderRadius;

  const ShimmerContainer({
    Key? key,
    required this.width,
    required this.height,
    this.margin,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      period: Duration(seconds: 2, milliseconds: 750),
      child: Container(
        margin: margin,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: borderRadius == null
              ? BorderRadius.circular(5.r)
              : BorderRadius.circular(borderRadius!),
        ),
        width: width,
        height: height,
      ),
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade200,
    );
  }
}
