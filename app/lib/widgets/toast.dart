import 'dart:async';

import 'package:flutter/cupertino.dart';

import 'package:app/services/toast.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/divider.dart';

class Toast extends StatefulWidget {
  Toast();

  @override
  _ToastState createState() => _ToastState();
}

class _ToastState extends State<Toast> with SingleTickerProviderStateMixin {
  StreamSubscription _subscription;

  List<Widget> messages = [];

  @override
  void initState() {
    super.initState();
    _subscription = ToastService().errorMessage$.listen((Widget message) {
      setState(() {
        messages.add(message);
      });
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [...messages.map((message) => _ToastUI(message: message))]);
  }
}

class _ToastUI extends StatefulWidget {
  _ToastUI({this.message});

  final Widget message;

  @override
  _ToastUIState createState() => _ToastUIState();
}

class _ToastUIState extends State<_ToastUI>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  final Animatable<Offset> _offSetTween =
      Tween<Offset>(begin: Offset(0, -1), end: Offset(0.0, 0.0))
          .chain(CurveTween(curve: Curves.easeIn));
  final Future _delayedTicker = Future.delayed(Duration(milliseconds: 3000));
  StreamSubscription _subscription;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _openClose();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _subscription.cancel();
    super.dispose();
  }

  void _openClose() {
    _animationController.forward().then((_) async {
      // We need to properly dispose the Future.
      // Futures in Dart cannot be cancelled. Streams can.
      _subscription = _delayedTicker.asStream().listen((_) => {
            // It could be null because it might have already been disposed.
            if (_animationController != null)
              _animationController.reverse()
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animationController.drive(_offSetTween),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: styles.Measurements.xs),
        child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: styles.Colors.bgWhite,
                borderRadius: BorderRadius.only(
                    bottomLeft: styles.kBorderRadius,
                    bottomRight: styles.kBorderRadius),
                boxShadow: [styles.kBoxShadow]),
            padding: EdgeInsets.symmetric(
                vertical: styles.Measurements.m,
                horizontal: styles.Measurements.m),
            child: SafeArea(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Image.asset('assets/images/icons/error.png'),
                    Divider(width: styles.Measurements.m),
                    Expanded(child: Center(child: widget.message))
                  ],
                ),
              ],
            ))),
      ),
    );
  }
}
