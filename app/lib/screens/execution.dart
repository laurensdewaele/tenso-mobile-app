import 'package:flutter/cupertino.dart';

import 'package:app/models/models.dart';
import 'package:app/view_models/execution_vm.dart';

class ExecutionScreenArguments {
  ExecutionScreenArguments({this.workout});

  final Workout workout;
}

class ExecutionScreen extends StatefulWidget {
  ExecutionScreen({Key key}) : super(key: key);

  @override
  _ExecutionScreenState createState() => _ExecutionScreenState();
}

class _ExecutionScreenState extends State<ExecutionScreen>
    with SingleTickerProviderStateMixin {
  ExecutionViewModel _viewModel;
  AnimationController _animationController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_viewModel == null) {
      final ExecutionScreenArguments routeArguments =
          ModalRoute.of(context).settings.arguments;
      _viewModel = ExecutionViewModel(
          workout: routeArguments.workout,
          animationController: _animationController,
          vsync: this);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
