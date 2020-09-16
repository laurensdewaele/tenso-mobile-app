import 'package:flutter/cupertino.dart' hide Icon;
import 'package:flutter/scheduler.dart';
import 'package:tenso_app/models/models.dart';
import 'package:tenso_app/modules/common/bottom_menu_drawer.dart';
import 'package:tenso_app/modules/common/color_square.dart';
import 'package:tenso_app/modules/common/dialog.dart';
import 'package:tenso_app/modules/common/icons.dart' as icons;
import 'package:tenso_app/modules/common/screen.dart';
import 'package:tenso_app/modules/common/sliding_card.dart';
import 'package:tenso_app/modules/common/sliding_expansion_card.dart';
import 'package:tenso_app/modules/workout_overview/delete_action.dart';
import 'package:tenso_app/modules/workout_overview/update.dart';
import 'package:tenso_app/modules/workout_overview/workout_overview.vm.dart';
import 'package:tenso_app/styles/styles.dart' as styles;
import 'package:tenso_app/widgets/button.dart';
import 'package:tenso_app/widgets/divider.dart';
import 'package:tenso_app/widgets/ok_button.dart';
import 'package:tenso_app/widgets/workout_overview/edit_action.dart';
import 'package:tenso_app/widgets/workout_overview/workout_expanded_content.dart';
import 'package:tenso_app/widgets/workout_overview/workout_long_press_dialog.dart';

class WorkoutOverviewScreen extends StatefulWidget {
  WorkoutOverviewScreen();

  @override
  _WorkoutOverviewScreenState createState() => _WorkoutOverviewScreenState();
}

class _WorkoutOverviewScreenState extends State<WorkoutOverviewScreen> {
  WorkoutOverviewViewModel _viewModel;

  @override
  void initState() {
    _viewModel = WorkoutOverviewViewModel();
    _viewModel.addListener(_viewModelListener);
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (_viewModel.displayChangelog == true) {
        _displayChangelog();
      }
      if (_viewModel.firstLaunch == true) {
        _displayNewcomerInfo();
      }
    });
    super.initState();
  }

  void _viewModelListener() {
    setState(() {});
  }

  @override
  void dispose() {
    _viewModel.removeListener(_viewModelListener);
    super.dispose();
  }

  void _displayNewcomerInfo() async {
    await showAppDialog(
        barrierDismissible: true,
        smallWidth: false,
        context: context,
        content: _NewcomerInfo());
  }

  void _displayChangelog() async {
    await showAppDialog(
        barrierDismissible: true,
        smallWidth: false,
        context: context,
        content: Update(
            setDisplayChangelogFalse: _viewModel.setDisplayChangelogFalse));
  }

  void _handleLongPress(Workout workout) async {
    await showAppDialog(
        smallWidth: true,
        context: context,
        content: WorkoutLongPressDialog(
            name: workout.name,
            handleDeleteTap: () => _viewModel.deleteWorkout(workout),
            handleCopyTap: () => _viewModel.copyWorkout(workout),
            handleEditTap: () => _viewModel.editWorkout(workout)));
  }

  @override
  Widget build(BuildContext context) {
    final EdgeInsets padding = MediaQuery.of(context).padding;
    final double viewHeight =
        MediaQuery.of(context).size.height - padding.top - padding.bottom;
    return WillPopScope(
      onWillPop: () async => false,
      child: Stack(
        children: <Widget>[
          Screen(
            padding: EdgeInsets.symmetric(
                horizontal: styles.Measurements.xs,
                vertical: styles.Measurements.m),
            child: ListView(
              key: ValueKey(_viewModel.workoutList.hashCode),
              physics: ClampingScrollPhysics(),
              children: <Widget>[
                ..._viewModel.workoutList
                    .asMap()
                    .map((int index, Workout workout) => MapEntry(
                        index,
                        SlidingCard(
                          disabled: false,
                          key: ValueKey(workout.id),
                          border: false,
                          divider: _viewModel.workoutList.length > 1 &&
                              index != _viewModel.workoutList.length - 1,
                          dividerHeight: styles.Measurements.m,
                          leftAction: EditAction(),
                          handleLeftActionTap: () =>
                              _viewModel.editWorkout(workout),
                          rightAction: DeleteAction(),
                          handleRightActionTap: () =>
                              _viewModel.deleteWorkout(workout),
                          handleLongPress: () => _handleLongPress(workout),
                          content: SlidingExpansionCard(
                            padding: const EdgeInsets.symmetric(
                                vertical: styles.Measurements.s),
                            topLeftSection: Container(
                              padding:
                                  EdgeInsets.only(left: styles.Measurements.s),
                              height: styles.Measurements.xxl,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(workout.name,
                                      style: styles.Staatliches.xlBlack,
                                      overflow: TextOverflow.ellipsis),
                                ],
                              ),
                            ),
                            topRightSection: Padding(
                              padding: const EdgeInsets.only(
                                  right: styles.Measurements.s),
                              child: ColorSquare(
                                color: workout.label.color,
                                width: styles.Measurements.xxl,
                                height: styles.Measurements.xxl,
                              ),
                            ),
                            topRightSectionWidth:
                                styles.Measurements.xxl + styles.Measurements.s,
                            handleTap: () {},
                            content: WorkoutExpandedContent(
                              workout: workout,
                              handleStart: () => _viewModel.start(workout),
                            ),
                            handleLongPress: () => _handleLongPress(workout),
                          ),
                        )))
                    .values
                    .toList(),
                if (_viewModel.workoutList.length > 0)
                  Divider(height: styles.Measurements.l),
                Button(
                    text: 'Add workout',
                    handleTap: _viewModel.addWorkout,
                    leadingIcon: icons.plusIconWhiteXl),
                // When scrolling down, the start button will be centered on the screen.
                Divider(height: viewHeight / 2 - styles.Measurements.m)
              ],
            ),
          ),
          BottomMenuDrawer(
            safeAreaPaddingBottom: MediaQuery.of(context).padding.bottom,
            startOpen: _viewModel.firstLaunch,
            menuItems: menuItems,
            longestMenuItemLength: 140,
            dragIndicatorColor: styles.Colors.primary,
            icons: true,
          )
        ],
      ),
    );
  }
}

class _NewcomerInfo extends StatelessWidget {
  _NewcomerInfo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Text(
            'Welcome to Tenso!',
            style: styles.Staatliches.lBlack,
          ),
        ),
        Text(
          '\nIf you\'re relatively new to hangboarding, we suggest you check out our info page.',
          style: styles.Lato.xsBlack,
          textAlign: TextAlign.center,
        ),
        Text(
          '\nIf you want to jump right in, we provided two low level entry workouts for you. A density hang protocol and a max hang protocol. For more, check out the info section.',
          style: styles.Lato.xsBlack,
          textAlign: TextAlign.center,
        ),
        Text(
          '\nYou can also create your own custom workout, go ahead by clicking on \'add workout\'.',
          style: styles.Lato.xsBlack,
          textAlign: TextAlign.center,
        ),
        Divider(
          height: styles.Measurements.l,
        ),
        OKButton(handleTap: () {
          Navigator.of(context).pop();
        }),
      ],
    );
  }
}
