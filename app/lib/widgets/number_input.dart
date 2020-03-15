import 'dart:async';

import 'package:flutter/cupertino.dart';

import 'package:provider/provider.dart';

import 'package:app/services/keyboard.dart';
import 'package:app/services/toast.dart';
import 'package:app/styles/styles.dart' as styles;

class NumberInput extends StatefulWidget {
  NumberInput(
      {@required this.isDouble,
      this.initialIntValue,
      this.initialDoubleValue,
      this.shouldFocus = false,
      this.maxIntValue,
      this.enabled = true,
      this.handleDoubleValueChanged,
      this.handleIntValueChanged,
      this.primaryColor = styles.Colors.primary,
      this.zeroValueAllowed});

  final bool enabled;
  final ValueChanged<int> handleIntValueChanged;
  final ValueChanged<double> handleDoubleValueChanged;
  final bool isDouble;
  final int initialIntValue;
  final double initialDoubleValue;
  final Color primaryColor;
  final bool shouldFocus;
  final bool zeroValueAllowed;
  final int maxIntValue;

  @override
  _NumberInputState createState() => _NumberInputState();
}

class _NumberInputState extends State<NumberInput> {
  final _textEditingController = TextEditingController();
  final _focusNode = FocusNode();

  String _initialValue;
  bool _shouldValidate = false;

  StreamSubscription _subscription;
  KeyboardService _keyboardService;
  ToastService _toastService;

  @override
  void initState() {
    super.initState();
    _initialValue = widget.initialDoubleValue?.toString() ??
        widget.initialIntValue?.toString();
    _textEditingController.text = _initialValue;
    _focusNode.addListener(() {
      if (_focusNode.hasFocus != true) {
        _validateInput();
      } else {
        _textEditingController.clear();
      }
    });

    _keyboardService = Provider.of<KeyboardService>(context, listen: false);
    _subscription = _keyboardService.shouldLoseFocusStream.listen((_) {
      _validateInput();
    });
    _toastService = Provider.of<ToastService>(context, listen: false);
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  void _validateInput() {
    if (_textEditingController.text == '') {
      _resetInitialValue();
      _validationEnd();
      return;
    }

    if (_shouldValidate == false) {
      _validationEnd();
      return;
    }

    dynamic value;
    try {
      value = widget.isDouble
          ? double.parse(_textEditingController.text)
          : int.parse(_textEditingController.text);
    } on FormatException catch (_) {
      _resetInitialValue();
      _validationError();
      _validationEnd();
      return;
    }

    if (widget.zeroValueAllowed == true && value < 0) {
      _resetInitialValue();
      _validationError();
      _validationEnd();
      return;
    }

    if (widget.zeroValueAllowed != true && value < 1) {
      _resetInitialValue();
      _validationError();
      _validationEnd();
      return;
    }

    if (widget.maxIntValue != null && value > widget.maxIntValue) {
      _resetInitialValue();
      _exceedMaxIntValueError();
      _validationEnd();
      return;
    }

    widget.isDouble == true
        ? widget.handleDoubleValueChanged(value)
        : widget.handleIntValueChanged(value);
    _validationEnd();
  }

  void _validationEnd() {
    _shouldValidate = false;
    _focusNode.unfocus();
    _keyboardService.resetKeyboardOffset();
  }

  void _resetInitialValue() {
    _textEditingController.text = _initialValue;
  }

  void _exceedMaxIntValueError() {
    final String value = widget.maxIntValue.toString();
    final String text = 'smaller than $value';
    final Widget errorMessage = RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'Please input a value ',
          style: styles.Lato.sBlack,
          children: [
            TextSpan(text: text, style: styles.Lato.sBlackBold),
          ]),
    );

    _toastService.add(errorMessage);
  }

  void _validationError() {
    final String biggerThanZero = 'bigger than 0.';
    final String biggerEqualThanZero = 'bigger or equal than 0.';
    String text;
    if (widget.zeroValueAllowed == true) {
      text = biggerEqualThanZero;
    } else {
      text = biggerThanZero;
    }

    final Widget errorMessage = RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'Please input a value ',
          style: styles.Lato.sBlack,
          children: [
            TextSpan(text: text, style: styles.Lato.sBlackBold),
          ]),
    );

    _toastService.add(errorMessage);
  }

  void _onTap() {
    _shouldValidate = true;
    _textEditingController.clear();
  }

  void _onPointerDown(PointerEvent event) {
    _keyboardService.handlePointerDown(event.position);
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
          style: styles.Staatliches.sWhite,
          textAlign: TextAlign.center,
          enabled: widget.enabled,
        ),
      ),
    );
  }
}
