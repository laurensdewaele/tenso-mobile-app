import 'package:flutter/cupertino.dart' hide Icon;

import 'package:provider/provider.dart';

import 'package:app/models/workout.dart';
import 'package:app/routes/routes.dart';
import 'package:app/screens/congratulations.dart';
import 'package:app/services/toast.dart';
import 'package:app/state/app_state.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/view_models/rate_workout_vm.dart';
import 'package:app/widgets/card.dart';
import 'package:app/widgets/keyboard_and_toast_provider.dart';
import 'package:app/widgets/keyboard_list_view.dart';
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

  void _handlePerceivedExertionChanged(int n) {
    _rateWorkoutViewModel.setPerceivedExertion(n);
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData _mediaQueryData = MediaQuery.of(context);
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
                      _PortraitContainer(
                        content: RateWorkoutContent(
                          handleCompleteWorkoutButtonTap:
                              _handleCompleteWorkoutButtonTap,
                          handlePerceivedExertionChanged:
                              _handlePerceivedExertionChanged,
                        ),
                      ),
                    if (_orientation == Orientation.landscape)
                      _LandscapeContainer(
                        content: RateWorkoutContent(
                          handleCompleteWorkoutButtonTap:
                              _handleCompleteWorkoutButtonTap,
                          handlePerceivedExertionChanged:
                              _handlePerceivedExertionChanged,
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

class _PortraitContainer extends StatelessWidget {
  _PortraitContainer({Key key, @required this.content}) : super(key: key);

  final Widget content;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(styles.Measurements.m),
        child: Card(
          padding: EdgeInsets.only(
            left: styles.Measurements.m,
            top: 0,
            right: styles.Measurements.m,
            bottom: styles.Measurements.l,
          ),
          child: content,
        ),
      ),
    );
  }
}

class _LandscapeContainer extends StatelessWidget {
  _LandscapeContainer({Key key, @required this.content}) : super(key: key);

  final Widget content;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: styles.kLandscapeDialogWidth,
      child: Padding(
        padding: EdgeInsets.all(styles.Measurements.m),
        child: Card(
          padding: EdgeInsets.only(
            left: styles.Measurements.m,
            top: 0,
            right: styles.Measurements.m,
            bottom: styles.Measurements.l,
          ),
          child: content,
        ),
      ),
    );
  }
}
