import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:tenso_app/services/toast.service.dart';
import 'package:tenso_app/styles/styles.dart' as styles;

class ToastProvider extends StatefulWidget {
  ToastProvider({@required this.child});

  final Widget child;

  @override
  _ToastState createState() => _ToastState();
}

class _ToastState extends State<ToastProvider>
    with SingleTickerProviderStateMixin {
  StreamSubscription _sub;

  @override
  void initState() {
    super.initState();
    OverlayState _overlayState = Overlay.of(context);
    _sub = ToastService().errorMessage$.listen((Widget message) async {
      OverlayEntry _entry =
          OverlayEntry(builder: (_) => _ToastUI(message: message));
      _overlayState.insert(_entry);
      await Future.delayed(Duration(milliseconds: 4000));
      _entry.remove();
    });
  }

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
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
  // -1.1 used for making sure the dropshadow is not visisble.
  final Animatable<Offset> _offSetTween =
      Tween<Offset>(begin: Offset(0, -1.1), end: Offset(0.0, 0.0))
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
            if (_animationController != null) _animationController.reverse()
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animationController.drive(_offSetTween),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: styles.Measurements.xs),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
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
                    maintainBottomViewPadding: true, child: widget.message)),
          ],
        ),
      ),
    );
  }
}
