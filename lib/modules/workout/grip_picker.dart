import 'package:flutter/cupertino.dart';
import 'package:tenso_app/models/models.dart';
import 'package:tenso_app/modules/common/divider.dart';
import 'package:tenso_app/modules/common/grip_image.dart';
import 'package:tenso_app/styles/styles.dart' as styles;

final double _kGripPickerHeight = 100;
final double _kGripWidth = 80;

class GripPicker extends StatelessWidget {
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
  final void Function(Grip grip) handleGripChanged;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return _GripPicker(
        containerWidth: constraints.maxWidth,
        grips: grips,
        primaryColor: primaryColor,
        handleGripChanged: handleGripChanged,
        selectedGrip: selectedGrip,
      );
    });
  }
}

class _GripPicker extends StatefulWidget {
  _GripPicker(
      {Key key,
      @required this.grips,
      @required this.selectedGrip,
      @required this.handleGripChanged,
      @required this.primaryColor,
      @required this.containerWidth})
      : super(key: key);

  final double containerWidth;
  final Color primaryColor;
  final List<Grip> grips;
  final Grip selectedGrip;
  final void Function(Grip grip) handleGripChanged;

  @override
  _GripPickerState createState() => _GripPickerState();
}

class _GripPickerState extends State<_GripPicker> {
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
  void didUpdateWidget(_GripPicker oldWidget) {
    if (oldWidget.selectedGrip != widget.selectedGrip ||
        oldWidget.containerWidth != widget.containerWidth) {
      _scrollToSelected();
    }
    super.didUpdateWidget(oldWidget);
  }

  void _scrollToSelected() {
    final double center = widget.containerWidth / 2;
    final int index = widget.grips.indexOf(widget.selectedGrip);

    _scrollController.animateTo(
        (index + 1) * _kGripWidth - (_kGripWidth / 2) - center,
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
          style: styles.Lato.sBlackBold,
          textAlign: TextAlign.center,
        ),
        Divider(height: styles.Measurements.m),
        Container(
          width: double.infinity,
          height: _kGripPickerHeight,
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
  final void Function(Grip grip) handleGripChanged;
  final bool selected;

  void _handleTap() {
    handleGripChanged(grip);
  }

  @override
  Widget build(BuildContext context) {
    final Widget image = GripImage(
        primaryColor: primaryColor,
        imageAsset: grip.imageAsset,
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
