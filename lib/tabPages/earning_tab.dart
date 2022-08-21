import 'package:flutter/material.dart';

class EarningTab extends StatefulWidget {
  const EarningTab({Key? key}) : super(key: key);

  @override
  State<EarningTab> createState() => _EarningTabState();
}

class _EarningTabState extends State<EarningTab> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Earnings'),
    );
  }
}
