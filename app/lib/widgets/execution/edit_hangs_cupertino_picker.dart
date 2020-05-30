import 'package:app/styles/styles.dart' as styles;
import 'package:app/view_models/execution/edit_hangs_dialog.vm.dart';
import 'package:app/widgets/divider.dart';
import 'package:flutter/cupertino.dart';

class EditHangsCupertinoPicker extends StatelessWidget {
  const EditHangsCupertinoPicker({
    @required this.handleScrollAttempt,
    @required this.canScroll,
    @required this.hangs,
    @required this.selectedHang,
    @required this.setSelectedHang,
  });

  final VoidCallback handleScrollAttempt;
  final bool canScroll;
  final List<Hang> hangs;
  final Hang selectedHang;
  final Function(int index) setSelectedHang;

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
              initialItem: hangs.indexOf(selectedHang)),
          useMagnifier: false,
          magnification: 1,
          backgroundColor: styles.Colors.bgWhite,
          onSelectedItemChanged: setSelectedHang,
          itemExtent: 40,
          children: <Widget>[
            ...hangs.map((Hang hang) => _HangRow(
                currentHangPerSet: hang.currentHangPerSet,
                totalHangsPerSet: hang.totalHangsPerSet,
                currentSet: hang.currentSet,
                totalSets: hang.totalSets,
                isPastHang: hang.isPastHang,
                isSelectedHang: hang.isSelected))
          ],
        ),
      ),
    );
  }
}

class _HangRow extends StatelessWidget {
  const _HangRow({
    @required this.isSelectedHang,
    @required this.isPastHang,
    @required this.currentSet,
    @required this.totalSets,
    @required this.currentHangPerSet,
    @required this.totalHangsPerSet,
  });

  final bool isSelectedHang;
  final bool isPastHang;
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
              if (isPastHang == false)
                _Circle(
                  active: isSelectedHang,
                ),
              if (isPastHang == true) _CompletedCircle(active: isSelectedHang),
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

class _Circle extends StatelessWidget {
  const _Circle({
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
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: styles.Colors.primary),
            borderRadius: BorderRadius.all(Radius.circular(10))),
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
