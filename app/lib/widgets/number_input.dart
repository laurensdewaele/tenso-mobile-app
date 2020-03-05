import 'dart:async';

import 'package:flutter/cupertino.dart';

import 'package:provider/provider.dart';

import 'package:app/services/toast.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/keyboard_screen.dart';

class NumberInput extends StatefulWidget {
  NumberInput(
      {@required this.initialValue,
      this.primaryColor = styles.Colors.primary,
      this.handleDoubleValueChanged,
      this.handleIntValueChanged,
      @required this.shouldLoseFocusStream,
      @required this.isDouble,
      @required this.shouldFocus,
      this.zeroValueAllowed});

  final Color primaryColor;
  final double initialValue;
  final Stream<bool> shouldLoseFocusStream;
  final bool shouldFocus;
  final bool isDouble;
  final bool zeroValueAllowed;
  final ValueChanged<int> handleIntValueChanged;
  final ValueChanged<double> handleDoubleValueChanged;

  @override
  _NumberInputState createState() => _NumberInputState();
}

class _NumberInputState extends State<NumberInput> {
  final _textEditingController = TextEditingController();
  final _focusNode = FocusNode();
  StreamSubscription _subscription;

  @override
  void initState() {
    super.initState();
    final dynamic initialValue =
        widget.isDouble ? widget.initialValue : widget.initialValue.toInt();
    _textEditingController.text = initialValue.toString();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus != true) {
        _validateInput();
      }
    });
    _subscription = widget.shouldLoseFocusStream.listen((shouldLoseFocus) {
      _validateInput();
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  void _validateInput() {
    dynamic value;
    try {
      value = widget.isDouble
          ? double.parse(_textEditingController.text)
          : int.parse(_textEditingController.text);
    } on FormatException catch (_) {
      _validationError();
    }

    if (value != null && widget.zeroValueAllowed == true && value < 0) {
      _validationError();
    }

    if (value != null && widget.zeroValueAllowed != true && value < 1) {
      _validationError();
    }

    if (value != null && widget.zeroValueAllowed == true && value >= 0) {
      widget.handleDoubleValueChanged(value);
    }

    if (value != null && widget.zeroValueAllowed != true && value >= 1) {
      widget.handleIntValueChanged(value);
    }

    _focusNode.unfocus();
    final KeyboardScreenCallbackProvider keyboardScreenCallbacks =
        KeyboardScreen.of(context);
    keyboardScreenCallbacks.resetKeyboardOffset();
  }

  void _validationError() {
    _textEditingController.text = widget.initialValue.toString();

    final String biggerThanZero = 'bigger than 0.';
    final String biggerEqualThanZero = 'bigger or equal than 0.';

    final Widget errorMessage = RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'Please input a value ',
          style: styles.Typography.textInfo,
          children: [
            TextSpan(
                text: widget.isDouble ? biggerEqualThanZero : biggerThanZero,
                style: styles.Typography.textInfoBold),
          ]),
    );

    Provider.of<ToastService>(context, listen: false).add(errorMessage);
  }

  void _onTap() {
    _textEditingController.clear();
  }

  void _onPointerDown(PointerEvent event) {
    final KeyboardScreenCallbackProvider keyboardScreenCallbacks =
        KeyboardScreen.of(context);
    keyboardScreenCallbacks.handlePointerDown(event.position);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.isDouble ? styles.Measurements.xxl : styles.Measurements.xl,
      child: Listener(
        onPointerDown: _onPointerDown,
        child: CupertinoTextField(
          autofocus: widget.shouldFocus,
          autocorrect: false,
          controller: _textEditingController,
          cursorColor: styles.Colors.white,
          decoration: BoxDecoration(
              color: widget.primaryColor,
              borderRadius: styles.kBorderRadiusAll),
          focusNode: _focusNode,
          keyboardType: widget.isDouble
              ? TextInputType.numberWithOptions(decimal: true)
              : TextInputType.number,
          maxLength: widget.isDouble ? 4 : 3,
          onTap: _onTap,
          onEditingComplete: _validateInput,
          onSubmitted: (String text) => {_validateInput},
          style: styles.Typography.inputDescriptionSquare,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
