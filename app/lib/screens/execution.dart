import 'package:flutter/cupertino.dart' hide Icon;

import 'package:app/models/models.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/view_models/execution_vm.dart';
import 'package:app/view_models/execution_vm_state.dart';
import 'package:app/widgets/button.dart';
import 'package:app/widgets/divider.dart';
import 'package:app/widgets/dialog.dart';
import 'package:app/widgets/execution/execution.dart';
import 'package:app/widgets/icons.dart' as icons;

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
      _animationController = AnimationController(vsync: this);
      _viewModel = ExecutionViewModel(
          workout: routeArguments.workout,
          animationController: _animationController);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  void _pause() {
    _viewModel.handlePauseTap();
    showAppDialog(
        context: context,
        content: _PauseDialog(
            handleResumeTap: _viewModel.handleResumeTap,
            handleSkipTap: _viewModel.handleSkipTap,
            handleStopTap: _viewModel.handleStopTap));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ExecutionViewModelState>(
      initialData: _viewModel.state,
      stream: _viewModel.state$,
      builder: (context, snapshot) {
        final _state = snapshot.data;
        return GestureDetector(
          onTap: _pause,
          child: Execution(
            weightUnit: _state.weightUnit,
            addedWeight: _state.addedWeight,
            animatedBackgroundHeightFactor: _state.animatedBackgroundHeightFactor,
            primaryColor: _state.primaryColor,
            title: _state.title,
            seconds: _state.seconds,
            holdLabel: _state.holdLabel,
            board: _state.board,
            leftGrip: _state.leftGrip,
            rightGrip: _state.rightGrip,
            leftGripBoardHold: _state.leftGripBoardHold,
            rightGripBoardHold: _state.rightGripBoardHold,
            totalSets: _state.totalSets,
            currentSet: _state.currentSet,
            totalHangsPerSet: _state.totalHangsPerSet,
            currentHang: _state.currentHang,
            endSound: _state.endSound,
            beepSound: _state.beepSound,
            beepsBeforeEnd: _state.beepsBeforeEnd,
          ),
        );
      }
    );
  }
}

class _PauseDialog extends StatelessWidget {
  _PauseDialog(
      {Key key,
      @required this.handleResumeTap,
      @required this.handleSkipTap,
      @required this.handleStopTap})
      : super(key: key);

  final VoidCallback handleStopTap;
  final VoidCallback handleResumeTap;
  final VoidCallback handleSkipTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          'paused',
          style: styles.Staatliches.xlBlack,
        ),
        Divider(
          height: styles.Measurements.xxl,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Button(
                  text: 'play',
                  handleTap: handleResumeTap,
                  displayBackground: false,
                  leadingIcon: icons.playIconBlackXl),
            ),
            Expanded(
              flex: 1,
              child: Button(
                text: 'stop',
                handleTap: handleStopTap,
                leadingIcon: icons.stopIconWhiteXl,
              ),
            )
          ],
        )
      ],
    );
  }
}
