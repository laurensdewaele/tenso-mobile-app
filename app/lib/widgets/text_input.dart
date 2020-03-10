import 'dart:async';

import 'package:flutter/cupertino.dart';

import 'package:provider/provider.dart';

import 'package:app/services/toast.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/keyboard_screen.dart';

class TextInput extends StatefulWidget {
  TextInput({
    @required this.handleValueChanged,
    @required this.initialValue,
    @required this.shouldLoseFocusStream,
    @required this.shouldFocus,
    this.enabled = true,
    this.primaryColor = styles.Colors.primary,
  });

  final bool enabled;
  final ValueChanged<String> handleValueChanged;
  final String initialValue;
  final Color primaryColor;
  final Stream<bool> shouldLoseFocusStream;
  final bool shouldFocus;

  @override
  _TextInputState createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  final _textEditingController = TextEditingController();
  final _focusNode = FocusNode();
  StreamSubscription _subscription;

  @override
  void initState() {
    super.initState();
    _textEditingController.text = widget.initialValue.toString();
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
    if (_textEditingController.text == '' ||
        _textEditingController.text == null) {
      _validationError();
    }
    _focusNode.unfocus();
    final KeyboardScreenCallbackProvider keyboardScreenCallbacks =
        KeyboardScreen.of(context);
    keyboardScreenCallbacks.resetKeyboardOffset();
    widget.handleValueChanged(_textEditingController.text);
  }

  void _validationError() {
    _textEditingController.text = widget.initialValue.toString();
    Provider.of<ToastService>(context, listen: false)
        .add(Text('Name must be filled in.', style: styles.Lato.sBlack));
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
      width: double.infinity,
      child: Listener(
        onPointerDown: _onPointerDown,
        child: CupertinoTextField(
          enabled: widget.enabled,
          // TODO: Figure out if it needs a max-length
          autofocus: widget.shouldFocus,
          autocorrect: false,
          controller: _textEditingController,
          cursorColor: styles.Colors.black,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: widget.primaryColor, width: 3),
            ),
          ),
          focusNode: _focusNode,
          keyboardType: TextInputType.text,
          onTap: _onTap,
          onEditingComplete: _validateInput,
          onSubmitted: (String text) => {_validateInput},
          style: styles.Lato.xsGray,
          textAlign: TextAlign.start,
        ),
      ),
    );
  }
}
