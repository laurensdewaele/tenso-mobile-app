import 'dart:async';

import 'package:flutter/cupertino.dart';

import 'package:app/widgets/workout/extra_tab.dart';
import 'package:app/widgets/workout/general_tab.dart';
import 'package:app/widgets/workout/hold_tab.dart';
import 'package:app/widgets/workout/navigation_tabs.dart';

class TabsContainer extends StatefulWidget {
  TabsContainer(
      {Key key,
      @required this.primaryColor,
      @required this.holdCount,
      @required this.onNavigation,
      this.navigateForwardTabStream,
      this.navigateBackTabStream})
      : super(key: key);

  final Color primaryColor;
  final int holdCount;
  final VoidCallback onNavigation;
  final Stream<bool> navigateForwardTabStream;
  final Stream<bool> navigateBackTabStream;

  @override
  _TabsContainerState createState() => _TabsContainerState();
}

class _TabsContainerState extends State<TabsContainer> {
  int _activePageIndex;
  List<Widget> _pages;
  StreamSubscription _navigateForwardTabSub;
  StreamSubscription _navigateBackTabSub;

  @override
  void initState() {
    super.initState();
    _activePageIndex = 0;
    _buildPages(widget.holdCount);
    _navigateForwardTabSub =
        widget.navigateForwardTabStream.listen((bool shouldNavigate) {
      _handleForwardNavigation();
    });
    _navigateBackTabSub =
        widget.navigateBackTabStream.listen((bool shouldNavigate) {
      _handleBackNavigation();
    });
  }

  @override
  void dispose() {
    _navigateBackTabSub.cancel();
    _navigateForwardTabSub.cancel();
    super.dispose();
  }

  @override
  void didUpdateWidget(TabsContainer oldWidget) {
    if (oldWidget.holdCount != widget.holdCount) {
      _buildPages(widget.holdCount);
    }
    super.didUpdateWidget(oldWidget);
  }

  void _buildPages(
    int holdCount,
  ) {
    setState(() {
      _pages = [
        GeneralTab(
          key: UniqueKey(),
        ),
        ...List.generate(holdCount, (i) => i).map((n) {
          return HoldTab(
            key: UniqueKey(),
            currentHold: n,
          );
        }),
        ExtraTab(
          key: UniqueKey(),
        )
      ];
    });
  }

  void _handleBackNavigation() {
    if (_activePageIndex == 0) {
      Navigator.of(context).pop();
    } else {
      setState(() {
        --_activePageIndex;
      });
    }
    widget.onNavigation();
  }

  void _handleForwardNavigation() {
    if (_activePageIndex <= _pages.length - 2)
      setState(() {
        ++_activePageIndex;
      });
    widget.onNavigation();
  }

  void _handleNavigation(int index) {
    setState(() {
      _activePageIndex = index;
    });
    widget.onNavigation();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _pages[_activePageIndex],
        NavigationTabs(
            primaryColor: widget.primaryColor,
            handleNavigation: _handleNavigation,
            handleBackNavigation: _handleBackNavigation,
            handleForwardNavigation: _handleForwardNavigation,
            count: _pages.length,
            activeIndex: _activePageIndex)
      ],
    );
  }
}
