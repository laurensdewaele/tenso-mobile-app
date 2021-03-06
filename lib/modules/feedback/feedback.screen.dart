import 'package:flutter/cupertino.dart';
import 'package:tenso_app/modules/common/button.dart';
import 'package:tenso_app/modules/common/card.dart';
import 'package:tenso_app/modules/common/divider.dart';
import 'package:tenso_app/modules/common/ok_button.dart';
import 'package:tenso_app/modules/common/screen.dart';
import 'package:tenso_app/modules/common/section.dart';
import 'package:tenso_app/modules/common/section_with_info_icon.dart';
import 'package:tenso_app/modules/common/top_navigation.dart';
import 'package:tenso_app/modules/feedback/feedback.vm.dart';
import 'package:tenso_app/modules/keyboard_input/keyboard_and_toast_provider.dart';
import 'package:tenso_app/modules/keyboard_input/keyboard_list_view.dart';
import 'package:tenso_app/modules/keyboard_input/text_input.dart';
import 'package:tenso_app/styles/styles.dart' as styles;

class FeedbackScreen extends StatefulWidget {
  FeedbackScreen({Key key}) : super(key: key);

  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  FeedbackViewModel _viewModel;

  @override
  void initState() {
    _viewModel = FeedbackViewModel();
    _viewModel.addListener(_viewModelListener);
    super.initState();
  }

  void _viewModelListener() {
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _handleBackNavigation() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardAndToastProvider(
      child: Screen(
        handleBackNavigation: _handleBackNavigation,
        child: KeyboardListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                TopNavigation(
                  handleBackNavigation: _handleBackNavigation,
                  title: 'feedback',
                ),
                Divider(height: styles.Measurements.xxl),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: styles.Measurements.xs),
                  child: Card(
                    padding: const EdgeInsets.only(
                      left: styles.Measurements.m,
                      right: styles.Measurements.m,
                      top: styles.Measurements.m,
                      bottom: styles.Measurements.l,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Divider(
                          height: styles.Measurements.xs,
                        ),
                        Section(
                          title: 'type',
                          children: <Widget>[
                            Container(
                              height: 100,
                              child: CupertinoPicker(
                                scrollController:
                                    FixedExtentScrollController(initialItem: 0),
                                useMagnifier: false,
                                magnification: 1,
                                backgroundColor: styles.Colors.bgWhite,
                                onSelectedItemChanged: (int index) {
                                  _viewModel.setType(feedbackTypes[index]);
                                },
                                itemExtent: 40,
                                children: <Widget>[
                                  ...feedbackTypes.map((String type) {
                                    return Center(
                                      child: Text(
                                        type,
                                        style: styles.Staatliches.lBlack,
                                      ),
                                    );
                                  })
                                ],
                              ),
                            )
                          ],
                        ),
                        Section(
                          nextSectionHasInfoIcon: true,
                          title: 'message *',
                          children: <Widget>[
                            Container(
                              height: 200,
                              child: TextInput(
                                primaryColor: styles.Colors.turquoise,
                                multiLine: true,
                                handleValueChanged: _viewModel.setMessage,
                                initialValue: '',
                              ),
                            )
                          ],
                        ),
                        SectionWithInfoIcon(
                          appDialogContent: EmailInfo(),
                          title: 'e-mail address',
                          children: <Widget>[
                            TextInput(
                              primaryColor: styles.Colors.turquoise,
                              multiLine: false,
                              handleValueChanged: _viewModel.setEmail,
                              initialValue: '',
                            )
                          ],
                        ),
                        Button(
                          backgroundColor: styles.Colors.turquoise,
                          text: 'send',
                          loading: _viewModel.awaitingResponse,
                          handleTap: _viewModel.sendMessage,
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(height: styles.Measurements.xxl)
              ],
            )
          ],
        ),
      ),
    );
  }
}

class EmailInfo extends StatelessWidget {
  EmailInfo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          'You may wish to leave your e-mail address, so we can reply to your feedback.',
          style: styles.Lato.xsBlack,
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
