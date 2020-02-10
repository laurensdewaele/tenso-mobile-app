import 'package:flutter/cupertino.dart';

import 'package:provider/provider.dart';

import 'package:app/state/app_state.dart';
import 'package:app/view_models/general_tab_vm.dart';
import 'package:app/widgets/new_workout/integer_input_and_divider.dart';
import 'package:app/widgets/section.dart';

class GeneralTab extends StatefulWidget {
  GeneralTab(
      {Key key,
      @required this.shouldLoseFocusStream,
      @required this.shouldFocusOnInput})
      : super(key: key);

  final Stream<bool> shouldLoseFocusStream;
  final bool shouldFocusOnInput;

  @override
  _GeneralTabState createState() => _GeneralTabState();
}

class _GeneralTabState extends State<GeneralTab> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _workout = Provider.of<AppState>(context, listen: false).workout;
    final _viewModel = Provider.of<GeneralTabViewModel>(context, listen: false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Section(
          title: 'basics',
          children: <Widget>[
            NumberInputAndDivider(
              isDouble: false,
              description: 'holds',
              shouldFocus: widget.shouldFocusOnInput,
              handleIntValueChanged: (int n) {
                _viewModel.setHoldCount(n);
              },
              initialValue: _workout.holdCount.toDouble(),
              shouldLoseFocusStream: widget.shouldLoseFocusStream,
            ),
            NumberInputAndDivider(
              isDouble: false,
              description: 'sets',
              shouldFocus: false,
              handleIntValueChanged: (int n) {
                _viewModel.setSets(n);
              },
              initialValue: _workout.sets.toDouble(),
              shouldLoseFocusStream: widget.shouldLoseFocusStream,
            ),
          ],
        ),
        Section(
          title: 'timers',
          children: <Widget>[
            NumberInputAndDivider(
              isDouble: false,
              description: 'rest seconds between holds',
              shouldFocus: false,
              handleIntValueChanged: (int n) {
                _viewModel.setRestBetweenHolds(n);
              },
              initialValue: _workout.restBetweenHolds.toDouble(),
              shouldLoseFocusStream: widget.shouldLoseFocusStream,
            ),
            NumberInputAndDivider(
              isDouble: false,
              description: 'rest seconds between sets',
              shouldFocus: false,
              handleIntValueChanged: (int n) {
                _viewModel.setRestBetweenSets(n);
              },
              initialValue: _workout.restBetweenSets.toDouble(),
              shouldLoseFocusStream: widget.shouldLoseFocusStream,
            ),
          ],
        ),
        Section(
          title: 'board',
          children: <Widget>[
            // TODO: Board selector
          ],
        )
      ],
    );
  }
}
