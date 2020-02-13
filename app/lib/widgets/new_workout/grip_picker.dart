import 'package:flutter/cupertino.dart';

import 'package:app/models/grip.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/divider.dart';
import 'package:app/widgets/grip_image.dart';

final GlobalKey _kGripPickerContainerKey = GlobalKey();
final double _kGripPickerHeight = 100;
final double _kGripWidth = 80;

class GripPicker extends StatefulWidget {
  GripPicker(
      {Key key,
      @required this.grips,
      @required this.selectedGrip,
      @required this.handleGripChanged,
      @required this.primaryColor})
      : super(key: key);

  final Color primaryColor;
  final List<Grip> grips;
  final Grip selectedGrip;
  final Function(Grip grip) handleGripChanged;

  @override
  _GripPickerState createState() => _GripPickerState();
}

class _GripPickerState extends State<GripPicker> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _afterLayout(Duration timeStamp) {
    _scrollToSelected();
  }

  @override
  void didUpdateWidget(GripPicker oldWidget) {
    if (oldWidget.selectedGrip != widget.selectedGrip) {
      _scrollToSelected();
    }
    super.didUpdateWidget(oldWidget);
  }

  void _scrollToSelected() {
    final RenderBox container =
        _kGripPickerContainerKey.currentContext.findRenderObject();
    final Size size = container.size;
    final double center = size.width / 2;
    final int index = widget.grips.indexOf(widget.selectedGrip);
    final double totalWidth = _kGripWidth * widget.grips.length;

    if (index * _kGripWidth < center) {
      _scrollController.animateTo(0,
          duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
    }
    if (index * _kGripWidth > totalWidth - center) {
      _scrollController.animateTo(totalWidth,
          duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
    }
    _scrollController.animateTo(
        index * _kGripWidth + (_kGripWidth / 2) - center,
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut);
  }

  void _handleGripChanged(Grip grip) {
    widget.handleGripChanged(grip);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          widget.selectedGrip.description,
          style: styles.Typography.textInfoBold,
          textAlign: TextAlign.center,
        ),
        Divider(height: styles.Measurements.m),
        Container(
          width: double.infinity,
          height: _kGripPickerHeight,
          key: _kGripPickerContainerKey,
          child: ListView(
            physics: ClampingScrollPhysics(),
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              ...widget.grips.map((Grip grip) => _Grip(
                    primaryColor: widget.primaryColor,
                    grip: grip,
                    handleGripChanged: _handleGripChanged,
                    selected: widget.selectedGrip == grip,
                  )),
            ],
          ),
        ),
      ],
    );
  }
}

class _Grip extends StatelessWidget {
  _Grip(
      {Key key,
      @required this.grip,
      this.primaryColor,
      @required this.handleGripChanged,
      @required this.selected})
      : super(key: key);

  final Color primaryColor;
  final Grip grip;
  final Function(Grip grip) handleGripChanged;
  final bool selected;

  void _handleTap() {
    handleGripChanged(grip);
  }

  @override
  Widget build(BuildContext context) {
    final Widget image = GripImage(
        primaryColor: primaryColor,
        assetSrc: grip.assetSrc,
        selected: selected,
        color: styles.Colors.lightGray);

    return GestureDetector(
        onTap: _handleTap,
        child: Container(
            width: _kGripWidth,
            child: selected
                ? image
                : Transform.scale(
                    scale: .8,
                    child: image,
                  )));
  }
}
