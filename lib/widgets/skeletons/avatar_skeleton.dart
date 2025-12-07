import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AvartarSkeleton extends StatelessWidget {
  const AvartarSkeleton({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 20.0,
      height: 20.0,
      child: ClipOval(
        child: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Text(
            'Shimmer',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
