import 'package:flutter/cupertino.dart';

import 'package:app/styles/styles.dart' as styles;
import 'package:app/view_models/workout/workout_general_vm.dart';
import 'package:app/widgets/divider.dart';
import 'package:app/widgets/number_input_and_description2.dart';
import 'package:app/widgets/section.dart';
import 'package:app/widgets/workout/card_container.dart';

class GeneralPage extends StatefulWidget {
  GeneralPage({Key key, @required this.viewModel}) : super(key: key);

  final WorkoutGeneralViewModel viewModel;

  @override
  _GeneralPageState createState() => _GeneralPageState();
}

class _GeneralPageState extends State<GeneralPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    widget.viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CardContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Section(
            title: 'basics',
            children: <Widget>[
              NumberInputAndDescription2<int>(
                enabled: widget.viewModel.inputsEnabled,
                primaryColor: widget.viewModel.primaryColor,
                description: 'holds',
                handleValueChanged: widget.viewModel.setHoldCount,
                initialValue: widget.viewModel.holdCount,
              ),
              Divider(
                height: styles.Measurements.m,
              ),
              NumberInputAndDescription2<int>(
                enabled: widget.viewModel.inputsEnabled,
                primaryColor: widget.viewModel.primaryColor,
                description: 'sets',
                handleValueChanged: widget.viewModel.setSets,
                initialValue: widget.viewModel.sets,
              ),
              Divider(
                height: styles.Measurements.m,
              ),
            ],
          ),
          Section(
            title: 'timers',
            children: <Widget>[
              NumberInputAndDescription2<int>(
                enabled: widget.viewModel.inputsEnabled,
                primaryColor: widget.viewModel.primaryColor,
                description: 'rest seconds between holds',
                handleValueChanged: widget.viewModel.setRestBetweenHolds,
                initialValue: widget.viewModel.restBetweenHolds,
              ),
              Divider(
                height: styles.Measurements.m,
              ),
              NumberInputAndDescription2(
                enabled: widget.viewModel.inputsEnabled,
                primaryColor: widget.viewModel.primaryColor,
                description: 'rest seconds between sets',
                handleValueChanged: widget.viewModel.setRestBetweenSets,
                initialValue: widget.viewModel.restBetweenSets,
              ),
              Divider(
                height: styles.Measurements.m,
              ),
            ],
          ),
          if (widget.viewModel.inputsEnabled == true)
            Section(
              title: 'board',
              children: <Widget>[
                // TODO: Board selector
              ],
            )
        ],
      ),
    );
  }
}
