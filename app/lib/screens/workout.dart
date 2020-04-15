import 'dart:async';

import 'package:flutter/cupertino.dart' hide Icon;

import 'package:provider/provider.dart';

import 'package:app/models/models.dart';
import 'package:app/services/keyboard.dart';
import 'package:app/state/app_state.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/view_models/workout/workout_navigator.dart';
import 'package:app/view_models/workout/workout_navigator_state.dart';
import 'package:app/view_models/workout/workout_vm.dart';
import 'package:app/view_models/workout/workout_vm_state.dart';
import 'package:app/widgets/divider.dart';
import 'package:app/widgets/keyboard_and_toast_provider.dart';
import 'package:app/widgets/keyboard_list_view.dart';
import 'package:app/widgets/screen.dart';
import 'package:app/widgets/top_navigation.dart';
import 'package:app/widgets/workout/extra_page.dart';
import 'package:app/widgets/workout/hold_page.dart';
import 'package:app/widgets/workout/general_page.dart';

@immutable
class WorkoutScreenArguments {
  final WorkoutTypes workoutType;
  final Workout workout;
  final WeightUnit weightUnit;

  WorkoutScreenArguments({
    @required this.workoutType,
    @required this.workout,
    @required this.weightUnit,
  });
}

class WorkoutScreen extends StatefulWidget {
  WorkoutScreen({Key key}) : super(key: key);

  @override
  _WorkoutScreenState createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  WorkoutViewModel _workoutViewModel;
  WorkoutNavigator _workoutNavigator;
  KeyboardService _keyboardService;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_workoutViewModel == null) {
      _keyboardService = Provider.of<KeyboardService>(context, listen: false);
      final WorkoutScreenArguments _arguments =
          ModalRoute.of(context).settings.arguments;
      _workoutViewModel = WorkoutViewModel(
          keyboardService: _keyboardService,
          workout: _arguments.workout,
          workoutType: _arguments.workoutType,
          currentWeightUnit: _arguments.weightUnit,
          appState: Provider.of<AppState>(context, listen: false));
      _workoutNavigator = WorkoutNavigator(workoutViewModel: _workoutViewModel);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _workoutViewModel?.dispose();
    _workoutNavigator?.dispose();
    super.dispose();
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    if (details.primaryVelocity > 0) {
      _workoutNavigator.handleBackRequest();
    }

    if (details.primaryVelocity < 0) {
      _workoutNavigator.handleForwardRequest();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _workoutNavigator.handleBackRequest();
        return false;
      },
      child: _ShouldPopRouteListener(
          shouldPopRoute$: _workoutNavigator.shouldPopRoute$,
          workoutViewModel: _workoutViewModel,
          child: GestureDetector(
            onHorizontalDragEnd: _onHorizontalDragEnd,
            child: KeyboardAndToastProvider(
              child: StreamBuilder<WorkoutViewModelState>(
                initialData: _workoutViewModel.state,
                stream: _workoutViewModel.state$,
                builder: (BuildContext context,
                    AsyncSnapshot<WorkoutViewModelState> snapshot) {
                  final _workoutState = snapshot.data;
                  return Screen(
                      gradientStartColor: _workoutState.primaryColor,
                      gradientStopColor: _workoutState.primaryColor,
                      child: KeyboardListView(
                          scrollToTopStream:
                              _workoutNavigator.activePage$.map((page) => true),
                          children: [
                            Column(
                              children: <Widget>[
                                TopNavigation(
                                  title: _workoutState.title,
                                ),
                                Divider(height: styles.Measurements.xxl),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: styles.Measurements.xs),
                                  child: StreamBuilder(
                                    initialData: _workoutNavigator.initialPage,
                                    stream: _workoutNavigator.activePage$,
                                    builder: (BuildContext context,
                                        AsyncSnapshot<WorkoutNavigatorPage>
                                            snapshot) {
                                      final WorkoutNavigatorPage activePage =
                                          snapshot.data;
                                      return Column(
                                        children: <Widget>[
                                          if (activePage.page ==
                                              WorkoutPages.generalPage)
                                            GeneralPage(
                                                workoutNavigator:
                                                    _workoutNavigator,
                                                workoutViewModel:
                                                    _workoutViewModel),
                                          if (activePage.page ==
                                              WorkoutPages.holdPage)
                                            HoldPage(
                                                workoutNavigator:
                                                    _workoutNavigator,
                                                workoutViewModel:
                                                    _workoutViewModel),
                                          if (activePage.page ==
                                              WorkoutPages.extraPage)
                                            ExtraPage(
                                              workoutViewModel:
                                                  _workoutViewModel,
                                              workoutNavigator:
                                                  _workoutNavigator,
                                            )
                                        ],
                                      );
                                    },
                                  ),
                                ),
                                Divider(height: styles.Measurements.xxl)
                              ],
                            )
                          ]));
                },
              ),
            ),
          )),
    );
  }
}

class _ShouldPopRouteListener extends StatefulWidget {
  _ShouldPopRouteListener(
      {Key key,
      @required this.shouldPopRoute$,
      @required this.child,
      @required this.workoutViewModel})
      : super(key: key);

  final Stream<bool> shouldPopRoute$;
  final WorkoutViewModel workoutViewModel;
  final Widget child;

  @override
  _ShouldPopRouteListenerState createState() => _ShouldPopRouteListenerState();
}

class _ShouldPopRouteListenerState extends State<_ShouldPopRouteListener> {
  StreamSubscription _sub;

  @override
  void initState() {
    _sub = widget.shouldPopRoute$.listen((_) {
      Navigator.of(context).pop();
    });
    super.initState();
  }

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
