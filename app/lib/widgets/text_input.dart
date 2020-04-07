import 'dart:async';

import 'package:flutter/cupertino.dart';

import 'package:provider/provider.dart';

import 'package:app/services/keyboard.dart';
import 'package:app/styles/styles.dart' as styles;

class TextInput extends StatefulWidget {
  TextInput({
    Key key,
    @required this.multiLine,
    @required this.handleValueChanged,
    @required this.initialValue,
    this.shouldFocus = false,
    this.enabled = true,
    this.primaryColor = styles.Colors.primary,
  });

  final bool multiLine;
  final bool enabled;
  final ValueChanged<String> handleValueChanged;
  final String initialValue;
  final Color primaryColor;
  final bool shouldFocus;

  @override
  _TextInputState createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  final _focusNode = FocusNode();
  final _textEditingController = TextEditingController();

  KeyboardService _keyboardService;
  StreamSubscription _subscription;

  @override
  void initState() {
    super.initState();
    _textEditingController.text = widget.initialValue.toString();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus != true) {
        _onComplete();
      }
    });

    _keyboardService = Provider.of<KeyboardService>(context, listen: false);
    _subscription = _keyboardService.shouldLoseFocus$.listen((_) {
      _onComplete();
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  void _onChanged() {
    widget.handleValueChanged(_textEditingController.text);
  }

  void _onComplete() {
    _focusNode.unfocus();
    _keyboardService.resetKeyboardOffset();
  }

  void _onPointerDown(PointerEvent event) {
    _keyboardService.handlePointerDown(event.position);
  }

  @override
  Widget build(BuildContext context) {
    final _decoration = widget.multiLine
        ? BoxDecoration(
            borderRadius: styles.kBorderRadiusAll,
            border: Border.all(color: widget.primaryColor, width: 3))
        : BoxDecoration(
            border: Border(
              bottom: BorderSide(color: widget.primaryColor, width: 3),
            ),
          );
    final _style =
        widget.multiLine ? styles.Lato.xsGray : styles.Staatliches.lGray;

    return Container(
      width: double.infinity,
      child: Listener(
        onPointerDown: _onPointerDown,
        child: CupertinoTextField(
          minLines: null,
          maxLines: widget.multiLine ? null : 1,
          expands: widget.multiLine ? true : false,
          enabled: widget.enabled,
          autofocus: widget.shouldFocus,
          autocorrect: false,
          controller: _textEditingController,
          cursorColor: styles.Colors.black,
          decoration: _decoration,
          focusNode: _focusNode,
          keyboardType: TextInputType.text,
          onChanged: (_) => {_onChanged()},
          onEditingComplete: _onComplete,
          onSubmitted: (_) => {_onComplete()},
          style: _style,
          textAlign: TextAlign.start,
        ),
      ),
    );
  }
}
