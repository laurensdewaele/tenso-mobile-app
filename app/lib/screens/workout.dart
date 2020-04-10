import 'package:flutter/cupertino.dart' hide Icon;

import 'package:provider/provider.dart';

import 'package:app/data/basic_workout.dart';
import 'package:app/models/models.dart';
import 'package:app/services/keyboard.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/view_models/workout/hold_page_vm.dart';
import 'package:app/view_models/workout/general_page_vm.dart';
import 'package:app/view_models/workout/workout_navigator.dart';
import 'package:app/view_models/workout/workout_vm.dart';
import 'package:app/view_models/workout/workout_vm_state.dart';
import 'package:app/widgets/divider.dart';
import 'package:app/widgets/keyboard_and_toast_provider.dart';
import 'package:app/widgets/keyboard_list_view.dart';
import 'package:app/widgets/screen.dart';
import 'package:app/widgets/top_navigation.dart';
import 'package:app/widgets/workout/hold_page.dart';
import 'package:app/widgets/workout/general_page.dart';

class WorkoutScreen extends StatefulWidget {
  WorkoutScreen({Key key}) : super(key: key);

  @override
  _WorkoutScreenState createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  WorkoutViewModel _workoutViewModel;
  WorkoutNavigator _workoutNavigator;
  KeyboardService _keyboardService;
  // This way it won't initialize multiple times during a rebuild.
  GeneralPageViewModel _generalPageViewModel;
  HoldPageViewModel _holdPageViewModel;

  @override
  void initState() {
    // TODO: Replace ofc
    Workout _workout = basicWorkout;
    WorkoutTypes _workoutType = WorkoutTypes.newWorkout;
    WeightUnit _weightUnit = WeightUnit.metric;

    _keyboardService = Provider.of<KeyboardService>(context, listen: false);
    _workoutViewModel = WorkoutViewModel(
        keyboardService: _keyboardService,
        workout: _workout,
        workoutType: _workoutType,
        currentWeightUnit: _weightUnit);
    _workoutNavigator = WorkoutNavigator(initialHoldCount: _workout.holdCount);
    _generalPageViewModel = GeneralPageViewModel(
        workoutNavigator: _workoutNavigator,
        workoutViewModel: _workoutViewModel);
    _holdPageViewModel = HoldPageViewModel(
        workoutNavigator: _workoutNavigator,
        workoutViewModel: _workoutViewModel);
    super.initState();
  }

  @override
  void dispose() {
    _workoutViewModel.dispose();
    _workoutNavigator.dispose();
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
    return GestureDetector(
      onHorizontalDragEnd: _onHorizontalDragEnd,
      child: KeyboardAndToastProvider(
        child: StreamBuilder<WorkoutViewModelState>(
          initialData: _workoutViewModel.initialState,
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
                          TopNavigation(title: _workoutState.title),
                          Divider(height: styles.Measurements.xxl),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: styles.Measurements.xs),
                            child: StreamBuilder(
                              initialData: initialPages[0],
                              stream: _workoutNavigator.activePage$,
                              builder: (BuildContext context,
                                  AsyncSnapshot<NavigatorPage> snapshot) {
                                return Column(
                                  children: <Widget>[
                                    if (snapshot.data.page == Pages.generalPage)
                                      GeneralPage(
                                          viewModel: _generalPageViewModel),
                                    if (snapshot.data.page == Pages.holdPage)
                                      HoldPage(viewModel: _holdPageViewModel),
                                    if (snapshot.data.page == Pages.extraPage)
                                      Container(
                                        child: Text('extra'),
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
    );
  }
}
