import 'package:flutter/cupertino.dart';

import 'package:provider/provider.dart';

import 'package:app/styles/styles.dart';
import 'package:app/view_models/countdown_vm.dart';

class CountdownScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _countdownViewModel =
        Provider.of<CountdownViewModel>(context, listen: true);
    _countdownViewModel.start();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Center(
        child: Text(_countdownViewModel.remainingSeconds.toString()),
      ),
    );
  }
}
