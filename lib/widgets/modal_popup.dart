import 'package:flutter/cupertino.dart';
import 'package:tenso_app/styles/styles.dart' as styles;

Future<void> showAppModalPopup({
  @required BuildContext context,
  @required Widget content,
}) {
  return showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => _AppModalDecoration(
            content: content,
          ));
}

// Padding can not be generic. We can have buttons inside our modal.
// Buttons ideally need to be as big as possible.
class _AppModalDecoration extends StatelessWidget {
  _AppModalDecoration({Key key, @required this.content}) : super(key: key);

  final Widget content;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: styles.Colors.bgWhite,
            borderRadius: BorderRadius.only(
                topLeft: styles.kBorderRadius, topRight: styles.kBorderRadius)),
        child: SafeArea(
            maintainBottomViewPadding: true, top: false, child: content));
  }
}

class AppModal extends StatefulWidget {
  AppModal({
    Key key,
    @required this.open,
    @required this.content,
  }) : super(key: key);

  final bool open;
  final Widget content;

  @override
  _AddHoldModalState createState() => _AddHoldModalState();
}

class _AddHoldModalState extends State<AppModal>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  final Animatable<Offset> _offSetTween =
      Tween<Offset>(begin: Offset(0, 1), end: Offset(0.0, 0.0))
          .chain(CurveTween(curve: Curves.easeIn));

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    super.initState();
  }

  @override
  void didUpdateWidget(AppModal oldWidget) {
    if (oldWidget.open != widget.open) {
      if (widget.open == true) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animationController.drive(_offSetTween),
      child: _AppModalDecoration(
        content: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: styles.Measurements.xs,
              vertical: styles.Measurements.xs),
          child: widget.content,
        ),
      ),
    );
  }
}
