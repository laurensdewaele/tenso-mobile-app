import 'package:flutter/cupertino.dart' hide Icon;

import 'package:provider/provider.dart';

import 'package:app/models/workout.dart';
import 'package:app/routes/routes.dart';
import 'package:app/screens/congratulations.dart';
import 'package:app/services/toast.dart';
import 'package:app/state/app_state.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/view_models/rate_workout_vm.dart';
import 'package:app/widgets/keyboard_and_toast_provider.dart';
import 'package:app/widgets/keyboard_list_view.dart';
import 'package:app/widgets/rate_workout/containers.dart';
import 'package:app/widgets/rate_workout/rate_workout_content.dart';

class RateWorkoutScreen extends StatefulWidget {
  RateWorkoutScreen({Key key}) : super(key: key);

  @override
  _RateWorkoutScreenState createState() => _RateWorkoutScreenState();
}

class _RateWorkoutScreenState extends State<RateWorkoutScreen> {
  RateWorkoutViewModel _rateWorkoutViewModel;
  Workout _workout;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final RateWorkoutArguments routeArguments =
        ModalRoute.of(context).settings.arguments;
    _workout = routeArguments.workout;
  }

  @override
  void initState() {
    _rateWorkoutViewModel = RateWorkoutViewModel(
      Provider.of<AppState>(context, listen: false),
      Provider.of<ToastService>(context, listen: false),
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _handleCompleteWorkoutButtonTap() {
    if (_rateWorkoutViewModel.completeWorkout(_workout) == false) {
      return;
    }
    Navigator.of(context).pushNamed(Routes.workoutOverviewScreen);
  }

  void _handleEffortLevelValueChanged(int n) {
    _rateWorkoutViewModel.setEffortLevel(n);
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData _mediaQueryData = MediaQuery.of(context);
    final double _maxContainerHeight = _mediaQueryData.size.height -
        _mediaQueryData.padding.top -
        _mediaQueryData.padding.bottom;
    final Orientation _orientation = _mediaQueryData.orientation;

    return WillPopScope(
      onWillPop: () async => false,
      child: KeyboardAndToastProvider(
        child: Container(
          decoration: BoxDecoration(color: styles.Colors.bgBlack),
          child: SafeArea(
            child: KeyboardListView(
              children: [
                Column(
                  children: <Widget>[
                    if (_orientation == Orientation.portrait)
                      RateWorkoutPortraitContainer(
                        maxContainerHeight: _maxContainerHeight,
                        content: RateWorkoutContent(
                          handleCompleteWorkoutButtonTap:
                              _handleCompleteWorkoutButtonTap,
                          handleEffortLevelValueChanged:
                              _handleEffortLevelValueChanged,
                        ),
                      ),
                    if (_orientation == Orientation.landscape)
                      RateWorkoutLandscapeContainer(
                        maxContainerHeight: _maxContainerHeight,
                        content: RateWorkoutContent(
                          handleCompleteWorkoutButtonTap:
                              _handleCompleteWorkoutButtonTap,
                          handleEffortLevelValueChanged:
                              _handleEffortLevelValueChanged,
                        ),
                      ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
