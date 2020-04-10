import 'package:flutter/cupertino.dart';

import 'package:app/styles/styles.dart' as styles;
import 'package:app/view_models/workout/general_page_vm.dart';
import 'package:app/view_models/workout/general_page_vm_state.dart';
import 'package:app/widgets/divider.dart';
import 'package:app/widgets/number_input_and_description2.dart';
import 'package:app/widgets/section.dart';
import 'package:app/widgets/workout/card_container.dart';

class GeneralPage extends StatefulWidget {
  GeneralPage({Key key, @required this.viewModel}) : super(key: key);

  final GeneralPageViewModel viewModel;

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
    // We need the stream builder here.
    // In the view model constructor, we're setting initialState variables based
    // on workout view model's state stream.
    // That all happens in a blink of an eye, but unfortunately, async.
    return StreamBuilder<GeneralPageInitialState>(
        stream: widget.viewModel.initialState$,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Container();
          } else {
            GeneralPageInitialState _initialState = snapshot.data;
            return CardContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Section(
                    title: 'basics',
                    children: <Widget>[
                      NumberInputAndDescription2<int>(
                        enabled: _initialState.inputsEnabled,
                        primaryColor: _initialState.primaryColor,
                        description: 'holds',
                        handleValueChanged: widget.viewModel.setHoldCount,
                        initialValue: _initialState.holdCount,
                      ),
                      Divider(
                        height: styles.Measurements.m,
                      ),
                      NumberInputAndDescription2<int>(
                        enabled: _initialState.inputsEnabled,
                        primaryColor: _initialState.primaryColor,
                        description: 'sets',
                        handleValueChanged: widget.viewModel.setSets,
                        initialValue: _initialState.sets,
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
                        enabled: _initialState.inputsEnabled,
                        primaryColor: _initialState.primaryColor,
                        description: 'rest seconds between holds',
                        handleValueChanged:
                            widget.viewModel.setRestBetweenHolds,
                        initialValue: _initialState.restBetweenHolds,
                      ),
                      Divider(
                        height: styles.Measurements.m,
                      ),
                      NumberInputAndDescription2(
                        enabled: _initialState.inputsEnabled,
                        primaryColor: _initialState.primaryColor,
                        description: 'rest seconds between sets',
                        handleValueChanged: widget.viewModel.setRestBetweenSets,
                        initialValue: _initialState.restBetweenSets,
                      ),
                      Divider(
                        height: styles.Measurements.m,
                      ),
                    ],
                  ),
                  if (_initialState.inputsEnabled == true)
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
        });
  }
}
