import 'package:flutter/cupertino.dart';

import 'package:app/models/models.dart';
import 'package:app/routes/routes.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/card.dart';
import 'package:app/widgets/rate_workout/congratulations_content.dart';

class RateWorkoutArguments {
  RateWorkoutArguments({this.workout});

  final Workout workout;
}

class CongratulationsScreen extends StatefulWidget {
  CongratulationsScreen({Key key}) : super(key: key);

  @override
  _CongratulationsScreenState createState() => _CongratulationsScreenState();
}

class _CongratulationsScreenState extends State<CongratulationsScreen> {
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
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _handleRateWorkoutTap(context) {
    Navigator.of(context).pushNamed(Routes.rateWorkoutScreen,
        arguments: RateWorkoutArguments(
          workout: _workout,
        ));
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
      child: Container(
        decoration: BoxDecoration(color: styles.Colors.bgBlack),
        child: SafeArea(
          child: ListView(
            physics: ClampingScrollPhysics(),
            children: [
              Column(
                children: <Widget>[
                  if (_orientation == Orientation.portrait)
                    _PortraitContainer(
                      maxContainerHeight: _maxContainerHeight,
                      content: CongratulationsContent(
                        handleRateWorkoutTap: () =>
                            _handleRateWorkoutTap(context),
                        orientation: _orientation,
                      ),
                    ),
                  if (_orientation == Orientation.landscape)
                    _LandscapeContainer(
                      content: CongratulationsContent(
                        handleRateWorkoutTap: () =>
                            _handleRateWorkoutTap(context),
                        orientation: _orientation,
                      ),
                    ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _PortraitContainer extends StatelessWidget {
  _PortraitContainer(
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

class _LandscapeContainer extends StatelessWidget {
  _LandscapeContainer({Key key, @required this.content}) : super(key: key);

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
