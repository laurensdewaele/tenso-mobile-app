import 'package:flutter/cupertino.dart' hide Icon;

import 'package:provider/provider.dart';

import 'package:app/models/workout.dart';
import 'package:app/routes/routes.dart';
import 'package:app/services/toast.dart';
import 'package:app/state/app_state.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/view_models/rate_workout_vm.dart';
import 'package:app/widgets/card.dart';
import 'package:app/widgets/keyboard_and_toast_provider.dart';
import 'package:app/widgets/keyboard_list_view.dart';
import 'package:app/widgets/rate_workout/congratulations_content.dart';
import 'package:app/widgets/rate_workout/rate_workout_content.dart';

class RateWorkoutScreenArguments {
  RateWorkoutScreenArguments({this.workout});

  final Workout workout;
}

enum _Pages { congratulations, rateWorkout }

class RateWorkoutScreen extends StatefulWidget {
  RateWorkoutScreen({Key key}) : super(key: key);

  @override
  _RateWorkoutScreenState createState() => _RateWorkoutScreenState();
}

class _RateWorkoutScreenState extends State<RateWorkoutScreen> {
  RateWorkoutViewModel _rateWorkoutViewModel;
  _Pages _page = _Pages.congratulations;
  int _effortLevel = 0;
  Workout _workout;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final RateWorkoutScreenArguments routeArguments =
        ModalRoute.of(context).settings.arguments;
    _workout = routeArguments.workout;
  }

  @override
  void initState() {
    _rateWorkoutViewModel = RateWorkoutViewModel(
        appState: Provider.of<AppState>(context, listen: false));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _handleRateWorkoutTap() {
    setState(() {
      _page = _Pages.rateWorkout;
    });
  }

  void _handleCompleteWorkoutButtonTap() {
    if (_validateInput() == false) {
      return;
    }
    _rateWorkoutViewModel.saveCompletedWorkout(
        workout: _workout, effortLevel: _effortLevel);
    Navigator.of(context).pushNamed(Routes.workoutOverviewScreen);
  }

  bool _validateInput() {
    if (_effortLevel < 1 || _effortLevel > 10) {
      Provider.of<ToastService>(context, listen: false).add(Text(
          'Please define an effort level ranging from 1 to 10',
          style: styles.Lato.sBlack));
      return false;
    } else {
      return true;
    }
  }

  void handleEffortLevelValueChanged(int n) {
    setState(() {
      _effortLevel = n;
    });
    _validateInput();
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData _mediaQueryData = MediaQuery.of(context);
    final double _maxContainerHeight = _mediaQueryData.size.height -
        _mediaQueryData.padding.top -
        _mediaQueryData.padding.bottom;
    final Orientation _orientation = _mediaQueryData.orientation;

    Widget _content;
    final Widget _congratulationsContent = CongratulationsContent(
      handleRateWorkoutTap: _handleRateWorkoutTap,
      orientation: _orientation,
    );
    final Widget _rateWorkoutContent = RateWorkoutContent(
      handleCompleteWorkoutButtonTap: _handleCompleteWorkoutButtonTap,
      handleEffortLevelValueChanged: handleEffortLevelValueChanged,
    );

    if (_page == _Pages.congratulations) _content = _congratulationsContent;
    if (_page == _Pages.rateWorkout) _content = _rateWorkoutContent;

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
                      _Container(
                        maxContainerHeight: _maxContainerHeight,
                        content: _content,
                      ),
                    if (_orientation == Orientation.landscape &&
                        _page == _Pages.congratulations)
                      _CongratulationsLandscapeContainer(
                        content: _content,
                      ),
                    if (_orientation == Orientation.landscape &&
                        _page == _Pages.rateWorkout)
                      _RateWorkoutLandscapeContainer(
                        maxContainerHeight: _maxContainerHeight,
                        content: _content,
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

class _Container extends StatelessWidget {
  _Container(
      {Key key, @required this.content, @required this.maxContainerHeight})
      : super(key: key);

  final Widget content;
  final double maxContainerHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: maxContainerHeight,
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

class _RateWorkoutLandscapeContainer extends StatelessWidget {
  _RateWorkoutLandscapeContainer(
      {Key key, @required this.content, @required this.maxContainerHeight})
      : super(key: key);

  final Widget content;
  final double maxContainerHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: maxContainerHeight,
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

class _CongratulationsLandscapeContainer extends StatelessWidget {
  _CongratulationsLandscapeContainer({Key key, @required this.content})
      : super(key: key);

  final Widget content;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: styles.kLandscapeDialogWidth,
        child: Padding(
          padding: EdgeInsets.all(styles.Measurements.m),
          child: Card(
            padding: EdgeInsets.only(
              left: styles.Measurements.m,
              top: styles.Measurements.m,
              right: styles.Measurements.m,
              bottom: styles.Measurements.l,
            ),
            child: content,
          ),
        ),
      ),
    );
  }
}
