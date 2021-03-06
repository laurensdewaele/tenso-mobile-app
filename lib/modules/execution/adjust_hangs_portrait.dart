import 'package:flutter/cupertino.dart';
import 'package:tenso_app/modules/board/board_with_grips.dart';
import 'package:tenso_app/modules/common/button.dart';
import 'package:tenso_app/modules/common/divider.dart';
import 'package:tenso_app/modules/execution/adjust_hangs_cupertino_picker.dart';
import 'package:tenso_app/modules/execution/adjust_hangs_dialog.vm.dart';
import 'package:tenso_app/modules/keyboard_input/number_input_and_description.dart';
import 'package:tenso_app/styles/styles.dart' as styles;

class AdjustHangsPortrait extends StatelessWidget {
  const AdjustHangsPortrait(
      {@required this.repText,
      @required this.selectedPastHang,
      @required this.setText,
      @required this.handleDone,
      @required this.setHangTimeInput,
      @required this.setAddedWeightInput,
      @required this.handleScrollAttempt,
      @required this.canScroll,
      @required this.pastHangs,
      @required this.setSelectedPastHang,
      @required this.groupText});

  final String groupText;
  final String repText;
  final PastHang selectedPastHang;
  final String setText;
  final VoidCallback handleDone;
  final void Function(String s) setHangTimeInput;
  final void Function(String s) setAddedWeightInput;

  final VoidCallback handleScrollAttempt;
  final bool canScroll;
  final List<PastHang> pastHangs;
  final Function(int index) setSelectedPastHang;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        groupText,
                        style: styles.Staatliches.xlBlack,
                      ),
                    ],
                  ),
                  Divider(height: styles.Measurements.l),
                  BoardWithGrips(
                    clipped: false,
                    key: ValueKey(
                        'log-hangs-dialog-board-${selectedPastHang.sequenceTimerIndex}'),
                    boardImageAssetWidth: selectedPastHang.imageAssetWidth,
                    boardImageAsset: selectedPastHang.imageAsset,
                    customBoardHoldImages:
                        selectedPastHang.customBoardHoldImages,
                    withFixedHeight: true,
                    handToBoardHeightRatio:
                        selectedPastHang.handToBoardHeightRatio,
                    boardAspectRatio: selectedPastHang.boardAspectRatio,
                    rightGripBoardHold: selectedPastHang.rightGripBoardHold,
                    leftGripBoardHold: selectedPastHang.leftGripBoardHold,
                    leftGrip: selectedPastHang.leftGrip,
                    rightGrip: selectedPastHang.rightGrip,
                  ),
                  NumberInputAndDescription<double>(
                    key: ValueKey(
                        'hang-duration-portrait-${selectedPastHang.sequenceTimerIndex}'),
                    enabled: true,
                    description: 'effective hung seconds',
                    handleValueChanged: setHangTimeInput,
                    initialValue: selectedPastHang.effectiveDurationS,
                  ),
                  Divider(
                    height: styles.Measurements.m,
                  ),
                  NumberInputAndDescription<double>(
                    key: ValueKey(
                        'added-weight-portrait-${selectedPastHang.sequenceTimerIndex}'),
                    enabled: true,
                    description: '${selectedPastHang.weightUnit} added weight',
                    handleValueChanged: setAddedWeightInput,
                    initialValue: selectedPastHang.effectiveAddedWeight,
                  ),
                ],
              ),
              Divider(
                height: styles.Measurements.l,
              ),
              Container(
                height: 1,
                width: double.infinity,
                decoration: BoxDecoration(color: styles.Colors.lighestGray),
              ),
              Expanded(
                child: AdjustHangsCupertinoPicker(
                  canScroll: canScroll,
                  handleScrollAttempt: handleScrollAttempt,
                  pastHangs: pastHangs,
                  selectedPastHang: selectedPastHang,
                  setSelectedPastHang: setSelectedPastHang,
                ),
              ),
              Container(
                height: 1,
                width: double.infinity,
                decoration: BoxDecoration(color: styles.Colors.lighestGray),
              ),
            ],
          ),
        ),
        Button(
          handleTap: handleDone,
          text: 'Done',
          small: true,
          displayBackground: false,
        )
      ],
    );
  }
}
