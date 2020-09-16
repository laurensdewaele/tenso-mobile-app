import 'package:flutter/cupertino.dart';
import 'package:tenso_app/modules/board/board_with_grips.dart';
import 'package:tenso_app/modules/common/button.dart';
import 'package:tenso_app/modules/common/divider.dart';
import 'package:tenso_app/modules/execution/adjust_hangs_cupertino_picker.dart';
import 'package:tenso_app/modules/execution/adjust_hangs_dialog.vm.dart';
import 'package:tenso_app/modules/keyboard_input/number_input_and_description.dart';
import 'package:tenso_app/styles/styles.dart' as styles;

class AdjustHangsLandscape extends StatelessWidget {
  const AdjustHangsLandscape({
    @required this.repText,
    @required this.selectedPastHang,
    @required this.setText,
    @required this.handleDone,
    @required this.setHangTimeInput,
    @required this.setAddedWeightInput,
    @required this.handleScrollAttempt,
    @required this.canScroll,
    @required this.pastHangs,
    @required this.setSelectedPastHang,
  });

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
      children: <Widget>[
        Expanded(
          child: Row(
            children: <Widget>[
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      LayoutBuilder(builder:
                          (BuildContext context, BoxConstraints constraints) {
                        return Container(
                          width: constraints.maxWidth / 1.5,
                          child: BoardWithGrips(
                            clipped: false,
                            key: ValueKey(
                                'log-hangs-dialog-board-${selectedPastHang.sequenceTimerIndex}'),
                            boardImageAssetWidth:
                                selectedPastHang.imageAssetWidth,
                            boardImageAsset: selectedPastHang.imageAsset,
                            customBoardHoldImages:
                                selectedPastHang.customBoardHoldImages,
                            withFixedHeight: true,
                            handToBoardHeightRatio:
                                selectedPastHang.handToBoardHeightRatio,
                            boardAspectRatio: selectedPastHang.boardAspectRatio,
                            rightGripBoardHold:
                                selectedPastHang.rightGripBoardHold,
                            leftGripBoardHold:
                                selectedPastHang.leftGripBoardHold,
                            leftGrip: selectedPastHang.leftGrip,
                            rightGrip: selectedPastHang.rightGrip,
                          ),
                        );
                      }),
                      NumberInputAndDescription<double>(
                        key: ValueKey(
                            'hang-duration-landscape${selectedPastHang.sequenceTimerIndex}'),
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
                            'added-weight-landscape-${selectedPastHang.sequenceTimerIndex}'),
                        enabled: true,
                        description:
                            '${selectedPastHang.weightUnit} added weight',
                        handleValueChanged: setAddedWeightInput,
                        initialValue: selectedPastHang.effectiveAddedWeight,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: AdjustHangsCupertinoPicker(
                        canScroll: canScroll,
                        handleScrollAttempt: handleScrollAttempt,
                        pastHangs: pastHangs,
                        selectedPastHang: selectedPastHang,
                        setSelectedPastHang: setSelectedPastHang,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Button(
              width: 150,
              handleTap: handleDone,
              text: 'Done',
              small: true,
              displayBackground: false,
            ),
          ],
        )
      ],
    );
  }
}
