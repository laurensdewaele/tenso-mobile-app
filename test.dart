class ViewModel {
	ViewModel({KeyboardService keyboardService} {
		_input = 'initial';

    	_keyboardSub = _keyboardService.validate$.listen((_) {
    		print('--validate stream--');
  			print(_input);
      		_validate();
		});
	});

	String _input;

	void setInput(String s) {
		_input = s
		print('--setInput--');
		print(_input);
	}
}

This is my output when I change the input, and then trigger the validate stream:

```Dart
--setInput--
different
--validate stream--
initial
--validate stream--
different
```

First issue:
It's being triggered twice.
From the streamController docs:
```
   * If two events are sent on an async controller with two listeners,
   * one of the listeners may get both events
   * before the other listener gets any.
```

Ok, what the hell?
But never mind that, why does my listen callback somehow have the old values on the first trigger?