import 'package:flutter/cupertino.dart' hide Icon;

import 'package:app/models/models.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/view_models/execution_vm.dart';
import 'package:app/view_models/execution_vm_state.dart';
import 'package:app/widgets/button.dart';
import 'package:app/widgets/divider.dart';
import 'package:app/widgets/dialog.dart';
import 'package:app/widgets/execution/landscape.dart';
import 'package:app/widgets/execution/portrait.dart';
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
        width: styles.Measurements.xxl * 6,
        landscapeWidth: styles.Measurements.xxl * 7,
        context: context,
        content: _PauseDialog(
            handleResumeTap: _viewModel.handleResumeTap,
            handleSkipTap: _viewModel.handleSkipTap,
            handleStopTap: _viewModel.handleStopTap));
  }

  void _onHorizontalDragEnd(DragEndDetails detail) {
    _pause();
  }

  @override
  Widget build(BuildContext context) {
    final Orientation _orientation = MediaQuery.of(context).orientation;

    return WillPopScope(
      onWillPop: () async {
        _pause();
        return false;
      },
      child: StreamBuilder<ExecutionViewModelState>(
          initialData: _viewModel.state,
          stream: _viewModel.state$,
          builder: (context, snapshot) {
            final _state = snapshot.data;
            return GestureDetector(
              onTap: _pause,
              onHorizontalDragEnd: _onHorizontalDragEnd,
              child: Stack(children: <Widget>[
                Container(
                  decoration: BoxDecoration(color: styles.Colors.bgBlack),
                ),
                FractionallySizedBox(
                    heightFactor: _state.animatedBackgroundHeightFactor,
                    child: Container(
                      decoration: BoxDecoration(color: _state.primaryColor),
                    )),
                SafeArea(
                  child: Padding(
                      padding: const EdgeInsets.all(styles.Measurements.m),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          if (_orientation == Orientation.portrait) {
                            return Portrait(
                              handleReadyTap: _viewModel.handleReadyTap,
                              type: _state.type,
                              title: _state.title,
                              weightUnit: _state.weightUnit,
                              seconds: _state.seconds,
                              orientation: _orientation,
                              rightGripBoardHold: _state.rightGripBoardHold,
                              rightGrip: _state.rightGrip,
                              leftGripBoardHold: _state.leftGripBoardHold,
                              leftGrip: _state.leftGrip,
                              board: _state.board,
                              currentHang: _state.currentHang,
                              currentSet: _state.currentSet,
                              holdLabel: _state.holdLabel,
                              primaryColor: _state.primaryColor,
                              totalHangsPerSet: _state.totalHangsPerSet,
                              totalSets: _state.totalSets,
                              addedWeight: _state.addedWeight,
                            );
                          } else {
                            return Landscape(
                              seconds: _state.seconds,
                              handleReadyTap: _viewModel.handleReadyTap,
                              type: _state.type,
                              title: _state.title,
                              weightUnit: _state.weightUnit,
                              orientation: _orientation,
                              rightGripBoardHold: _state.rightGripBoardHold,
                              rightGrip: _state.rightGrip,
                              leftGripBoardHold: _state.leftGripBoardHold,
                              leftGrip: _state.leftGrip,
                              board: _state.board,
                              currentHang: _state.currentHang,
                              currentSet: _state.currentSet,
                              holdLabel: _state.holdLabel,
                              primaryColor: _state.primaryColor,
                              totalHangsPerSet: _state.totalHangsPerSet,
                              totalSets: _state.totalSets,
                              addedWeight: _state.addedWeight,
                            );
                          }
                        },
                      )),
                ),
              ]),
            );
          }),
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
    return ListView(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'paused',
              style: styles.Staatliches.xlBlack,
            ),
            Divider(
              height: styles.Measurements.xs,
            ),
            Text(
              'Progress will be saved when skipping or stopping.',
              textAlign: TextAlign.center,
              style: styles.Lato.xsBlack,
            ),
            Divider(
              height: styles.Measurements.xxl,
            ),
            Button(
                text: 'skip',
                handleTap: handleSkipTap,
                displayBackground: true,
                backgroundColor: styles.Colors.gray,
                leadingIcon: icons.skipIconWhiteXl),
            Divider(
              height: styles.Measurements.m,
            ),
            Button(
                text: 'stop',
                handleTap: handleStopTap,
                displayBackground: true,
                backgroundColor: styles.Colors.primary,
                leadingIcon: icons.stopIconWhiteXl),
            Divider(
              height: styles.Measurements.m,
            ),
            Button(
                text: 'resume',
                handleTap: handleResumeTap,
                displayBackground: false,
                leadingIcon: icons.playIconBlackXl),
          ],
        )
      ],
    );
  }
}
