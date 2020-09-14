import 'package:flutter/cupertino.dart';
import 'package:tenso_app/models/models.dart';
import 'package:tenso_app/styles/styles.dart' as styles;
import 'package:tenso_app/view_models/stats/filter.vm.dart';
import 'package:tenso_app/widgets/button.dart';
import 'package:tenso_app/widgets/card.dart';
import 'package:tenso_app/widgets/divider.dart';
import 'package:tenso_app/widgets/label_text_picker.dart';
import 'package:tenso_app/widgets/screen.dart';
import 'package:tenso_app/widgets/top_navigation.dart';

class FilterScreenArguments {
  final Label filteredLabel;
  final Workout filteredWorkout;

  const FilterScreenArguments({
    @required this.filteredLabel,
    @required this.filteredWorkout,
  });
}

class FilterScreen extends StatefulWidget {
  FilterScreen({Key key}) : super(key: key);

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  FilterViewModel _viewModel;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_viewModel == null) {
      final FilterScreenArguments _routeArguments =
          ModalRoute.of(context).settings.arguments;
      _viewModel = FilterViewModel(
          filteredLabel: _routeArguments.filteredLabel,
          filteredWorkout: _routeArguments.filteredWorkout);
      _viewModel.addListener(_viewModelListener);
    }
  }

  void _viewModelListener() {
    setState(() {});
  }

  @override
  void dispose() {
    _viewModel.removeListener(_viewModelListener);
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _viewModel.handleBackNavigation();
        return false;
      },
      child: LayoutBuilder(builder: (context, constraints) {
        return Screen(
          backgroundColor: styles.Colors.bgGray,
          handleBackNavigation: _viewModel.handleBackNavigation,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  TopNavigation(
                    handleBackNavigation: _viewModel.handleBackNavigation,
                    title: 'choose filter',
                    dark: false,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: styles.Measurements.xs,
                        vertical: styles.Measurements.xxl),
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Card(
                              padding: EdgeInsets.all(styles.Measurements.m),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'label',
                                    style: styles.Staatliches.xlBlack,
                                  ),
                                  Divider(height: styles.Measurements.m),
                                  LabelWithTextPicker(
                                    reset$: _viewModel.reset$,
                                    handleLabelChanged:
                                        _viewModel.setSelectedLabel,
                                    labelsWithText:
                                        _viewModel.state.labelsWithText,
                                    initialLabelWithText:
                                        _viewModel.state.initialLabelWithText,
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              height: styles.Measurements.xl,
                            ),
                            Card(
                              padding: EdgeInsets.all(styles.Measurements.m),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'workout',
                                    style: styles.Staatliches.xlBlack,
                                  ),
                                  Divider(height: styles.Measurements.l),
                                  // Workout list,
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Positioned(
                bottom: 0,
                child: LayoutBuilder(builder: (context, _) {
                  final double _dividerWidth = styles.Measurements.m;
                  final double _padding = styles.Measurements.m;
                  final double _buttonWidth =
                      (constraints.maxWidth - _dividerWidth - _padding * 2) / 2;
                  return Card(
                    padding: EdgeInsets.all(_padding),
                    child: Row(
                      children: [
                        Button(
                          handleTap: _viewModel.handleClearTap,
                          text: 'clear',
                          backgroundColor: styles.Colors.primary,
                          width: _buttonWidth,
                          smallText: true,
                          height: styles.kSmallButtonHeight,
                        ),
                        Divider(
                          width: _dividerWidth,
                        ),
                        Button(
                          handleTap: _viewModel.handleApplyTap,
                          text: 'apply',
                          backgroundColor: styles.Colors.turquoise,
                          width: _buttonWidth,
                          smallText: true,
                          height: styles.kSmallButtonHeight,
                        ),
                      ],
                    ),
                  );
                }),
              )
            ],
          ),
        );
      }),
    );
  }
}
