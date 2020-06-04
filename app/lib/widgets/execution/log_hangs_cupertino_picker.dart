import 'package:app/styles/styles.dart' as styles;
import 'package:app/view_models/execution/log_hangs_dialog.vm.dart';
import 'package:app/widgets/divider.dart';
import 'package:flutter/cupertino.dart';

class LogHangsCupertinoPicker extends StatelessWidget {
  const LogHangsCupertinoPicker({
    @required this.handleScrollAttempt,
    @required this.canScroll,
    @required this.pastHangs,
    @required this.selectedPastHang,
    @required this.setSelectedPastHang,
  });

  final VoidCallback handleScrollAttempt;
  final bool canScroll;
  final List<PastHang> pastHangs;
  final PastHang selectedPastHang;
  final Function(int index) setSelectedPastHang;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: handleScrollAttempt,
      onVerticalDragDown: (DragDownDetails _) {
        handleScrollAttempt();
      },
      child: AbsorbPointer(
        absorbing: !canScroll,
        child: CupertinoPicker(
          scrollController: FixedExtentScrollController(
              initialItem: pastHangs.indexOf(selectedPastHang)),
          useMagnifier: false,
          magnification: 1,
          backgroundColor: styles.Colors.bgWhite,
          onSelectedItemChanged: setSelectedPastHang,
          itemExtent: 40,
          children: <Widget>[
            ...pastHangs.map((PastHang pastHang) => _HangRow(
                currentHangPerSet: pastHang.currentHangPerSet,
                totalHangsPerSet: pastHang.totalHangsPerSet,
                currentSet: pastHang.currentSet,
                totalSets: pastHang.totalSets,
                isSelectedPastHang: pastHang.isSelected))
          ],
        ),
      ),
    );
  }
}

class _HangRow extends StatelessWidget {
  const _HangRow({
    @required this.isSelectedPastHang,
    @required this.currentSet,
    @required this.totalSets,
    @required this.currentHangPerSet,
    @required this.totalHangsPerSet,
  });

  final bool isSelectedPastHang;
  final int currentSet;
  final int totalSets;
  final int totalHangsPerSet;
  final int currentHangPerSet;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            children: <Widget>[
              _CompletedCircle(active: isSelectedPastHang),
              Divider(
                width: styles.Measurements.xs,
              ),
              Text('Hang', style: styles.Staatliches.sBlack),
              Divider(
                width: styles.Measurements.xs,
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Divider(
                    height: 5,
                  ),
                  Text('$currentHangPerSet/$totalHangsPerSet',
                      style: styles.Lato.xsGray),
                ],
              ),
            ],
          ),
          Divider(
            width: styles.Measurements.m,
          ),
          if (totalSets > 1)
            Row(
              children: <Widget>[
                Text('set', style: styles.Staatliches.sBlack),
                Divider(
                  width: styles.Measurements.xs,
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Divider(
                      height: 5,
                    ),
                    Text('$currentSet/$totalSets', style: styles.Lato.xsGray),
                  ],
                ),
              ],
            )
        ],
      ),
    );
  }
}

class _CompletedCircle extends StatelessWidget {
  const _CompletedCircle({
    @required this.active,
  });

  final bool active;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: active ? 1.5 : 1,
      child: Container(
        height: styles.Measurements.xs,
        width: styles.Measurements.xs,
        decoration:
            BoxDecoration(color: styles.Colors.primary, shape: BoxShape.circle),
      ),
    );
  }
}
