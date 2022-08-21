import 'package:flutter/material.dart';

class RatingsTab extends StatefulWidget {
  const RatingsTab({Key? key}) : super(key: key);

  @override
  State<RatingsTab> createState() => _RatingsTabState();
}

class _RatingsTabState extends State<RatingsTab> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Ratings'),
    );
  }
}
