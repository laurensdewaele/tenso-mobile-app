import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/modal_popup.dart';
import 'package:flutter/cupertino.dart';

class AddHoldModal extends StatefulWidget {
  AddHoldModal({
    Key key,
    @required this.open,
    @required this.handleTap,
  }) : super(key: key);

  final bool open;
  final VoidCallback handleTap;

  @override
  _AddHoldModalState createState() => _AddHoldModalState();
}

class _AddHoldModalState extends State<AddHoldModal>
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
  void didUpdateWidget(AddHoldModal oldWidget) {
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
      child: GestureDetector(
        onTap: widget.handleTap,
        child: AppModal(
          content: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: styles.Measurements.xs,
                vertical: styles.Measurements.xs),
            child: Container(
              width: double.infinity,
              child: Text(
                'add hold',
                style: styles.Staatliches.xlBlack,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
