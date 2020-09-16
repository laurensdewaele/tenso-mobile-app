import 'package:flutter/cupertino.dart' hide Icon;
import 'package:tenso_app/models/models.dart';
import 'package:tenso_app/modules/common/button.dart';
import 'package:tenso_app/modules/common/dialog.dart';
import 'package:tenso_app/modules/common/divider.dart';
import 'package:tenso_app/modules/common/icons.dart' as icons;
import 'package:tenso_app/modules/execution/adjust_hangs_dialog.dart';
import 'package:tenso_app/modules/execution/execution.vm.dart';
import 'package:tenso_app/modules/execution/execution_landscape.dart';
import 'package:tenso_app/modules/execution/execution_portrait.dart';
import 'package:tenso_app/modules/execution/execution_state.vm.dart';
import 'package:tenso_app/modules/toast/toast_message.dart';
import 'package:tenso_app/modules/toast/toast_provider.dart';
import 'package:tenso_app/services/toast.service.dart';
import 'package:tenso_app/styles/styles.dart' as styles;

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
        smallWidth: false,
        context: context,
        content: _PauseDialog(
          duringHang: _viewModel.state.type == SequenceTimerType.hangTimer,
          handleAdjustHangsTap: _handleAdjustHangsTap,
          handleResumeTap: _viewModel.handleResumeTap,
          handleSkipTap: _viewModel.handleSkipTap,
          handleStopTap: _viewModel.handleStopTap,
          handleAddCommentsTap: _viewModel.handleAddCommentsTap,
        ));
  }

  void _handleAdjustHangsTap() async {
    if (_viewModel.state.type == SequenceTimerType.hangTimer) {
      ToastService().add(ToastMessages.adjustingOnlyPossibleOnRests());
    } else if (_viewModel.pastHangs.length == 0) {
      ToastService()
          .add(ToastMessages.adjustingNotPossibleWhenNoCompletedHangs());
    } else {
      await showAppDialog(
          fullWidth: true,
          context: context,
          content: AdjustHangsDialog(
            pastHangs: _viewModel.pastHangs,
            handleAdjustedHangs: _viewModel.handleAdjustedHangs,
          ),
          smallWidth: false);
    }
  }

  void _onHorizontalDragEnd(DragEndDetails detail) {
    _pause();
  }

  @override
  Widget build(BuildContext context) {
    final Orientation _orientation = MediaQuery.of(context).orientation;
    _viewModel.setContext(context);

    return WillPopScope(
      onWillPop: () async {
        _pause();
        return false;
      },
      child: ToastProvider(
        child: StreamBuilder<ExecutionState>(
            initialData: _viewModel.state,
            stream: _viewModel.state$,
            builder: (context, snapshot) {
              final _state = snapshot.data;
              if (_state.displayEndScreen == true) {
                return Container(
                  decoration: BoxDecoration(color: styles.Colors.bgBlack),
                );
              } else {
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
                      maintainBottomViewPadding: true,
                      child: Padding(
                          padding: const EdgeInsets.all(styles.Measurements.m),
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              if (_orientation == Orientation.portrait) {
                                return ExecutionPortrait(
                                  handleReadyTap: _viewModel.handleReadyTap,
                                  isVariableRestTimer:
                                      _state.isVariableRestTimer,
                                  title: _state.title,
                                  weightSystem: _state.weightSystem,
                                  displaySeconds: _state.displaySeconds,
                                  rightGripBoardHold: _state.rightGripBoardHold,
                                  rightGrip: _state.rightGrip,
                                  leftGripBoardHold: _state.leftGripBoardHold,
                                  leftGrip: _state.leftGrip,
                                  board: _state.board,
                                  currentGroup: _state.currentGroup,
                                  totalGroups: _state.totalGroups,
                                  holdLabel: _state.holdLabel,
                                  primaryColor: _state.primaryColor,
                                  addedWeight: _state.addedWeight,
                                  totalSets: _state.totalSets,
                                  currentSet: _state.currentSet,
                                  totalReps: _state.totalReps,
                                  currentRep: _state.currentRep,
                                );
                              } else {
                                return ExecutionLandscape(
                                  displaySeconds: _state.displaySeconds,
                                  handleReadyTap: _viewModel.handleReadyTap,
                                  isVariableRestTimer:
                                      _state.isVariableRestTimer,
                                  title: _state.title,
                                  weightSystem: _state.weightSystem,
                                  rightGripBoardHold: _state.rightGripBoardHold,
                                  rightGrip: _state.rightGrip,
                                  leftGripBoardHold: _state.leftGripBoardHold,
                                  leftGrip: _state.leftGrip,
                                  board: _state.board,
                                  holdLabel: _state.holdLabel,
                                  primaryColor: _state.primaryColor,
                                  addedWeight: _state.addedWeight,
                                  currentGroup: _state.currentGroup,
                                  totalGroups: _state.totalGroups,
                                  currentRep: _state.currentRep,
                                  totalReps: _state.totalReps,
                                  currentSet: _state.currentSet,
                                  totalSets: _state.totalSets,
                                );
                              }
                            },
                          )),
                    ),
                  ]),
                );
              }
            }),
      ),
    );
  }
}

class _PauseDialog extends StatelessWidget {
  _PauseDialog({
    Key key,
    @required this.handleResumeTap,
    @required this.handleSkipTap,
    @required this.handleStopTap,
    @required this.handleAdjustHangsTap,
    @required this.duringHang,
    @required this.handleAddCommentsTap,
  }) : super(key: key);

  final bool duringHang;
  final VoidCallback handleStopTap;
  final VoidCallback handleResumeTap;
  final VoidCallback handleSkipTap;
  final VoidCallback handleAdjustHangsTap;
  final VoidCallback handleAddCommentsTap;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        handleResumeTap();
        return false;
      },
      child: ListView(
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
                smallText: true,
                text: 'add comments',
                handleTap: handleAddCommentsTap,
                displayBackground: true,
                backgroundColor: styles.Colors.turquoise,
                leadingIcon: icons.editIconWhiteXl,
                leadingIconTextCentered: true,
              ),
              Divider(
                height: styles.Measurements.m,
              ),
              Button(
                smallText: true,
                text: 'adjust hangs',
                handleTap: handleAdjustHangsTap,
                displayBackground: true,
                backgroundColor: styles.Colors.blue,
                leadingIcon: icons.editIconWhiteXl,
                leadingIconTextCentered: true,
              ),
              Divider(
                height: styles.Measurements.m,
              ),
              Button(
                smallText: true,
                text: duringHang ? 'end hang' : 'skip next hang',
                handleTap: handleSkipTap,
                displayBackground: true,
                backgroundColor: styles.Colors.gray,
                leadingIcon: icons.skipIconWhiteXl,
                leadingIconTextCentered: true,
              ),
              Divider(
                height: styles.Measurements.m,
              ),
              Button(
                smallText: true,
                text: 'stop',
                handleTap: handleStopTap,
                displayBackground: true,
                backgroundColor: styles.Colors.primary,
                leadingIcon: icons.stopIconWhiteXl,
                leadingIconTextCentered: true,
              ),
              Divider(
                height: styles.Measurements.l,
              ),
              Button(
                smallText: true,
                text: 'resume',
                handleTap: handleResumeTap,
                displayBackground: false,
                leadingIcon: icons.playIconBlackXl,
                leadingIconTextCentered: true,
              ),
            ],
          )
        ],
      ),
    );
  }
}
