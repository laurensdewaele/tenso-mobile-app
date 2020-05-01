import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'package:app/styles/styles.dart' as styles;
import 'package:app/view_models/custom_board.dart';
import 'package:app/widgets/bottom_menu_drawer.dart';
import 'package:app/widgets/icons.dart' as icons;
import 'package:app/widgets/keyboard_and_toast_provider.dart';
import 'package:app/widgets/modal_popup.dart';
import 'package:app/widgets/screen.dart';
import 'package:app/widgets/top_navigation.dart';

class CustomBoardScreen extends StatefulWidget {
  CustomBoardScreen({Key key}) : super(key: key);

  @override
  _CustomBoardScreenState createState() => _CustomBoardScreenState();
}

class _CustomBoardScreenState extends State<CustomBoardScreen> {
  CustomBoardViewModel _viewModel;

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    _viewModel = CustomBoardViewModel();
    _viewModel.addListener(_viewModelListener);
    super.initState();
  }

  void _viewModelListener() {
    setState(() {});
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    _viewModel.removeListener(_viewModelListener);
    super.dispose();
  }

  void _handleSaveTap() {}
  void _handlePreviewTap() {}
  void _handleInfoTap() {}
  void _handleAddHoldTap() async {
    await showAppModalPopup(
        context: context,
        content: Row(
          children: <Widget>[
            Expanded(
              child: Text('pinch block'),
            ),
            Expanded(
              child: Text('sloper'),
            ),
            Expanded(
              child: Text('jug'),
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardAndToastProvider(
      child: Stack(
        children: <Widget>[
          Screen(
            gradientStartColor: styles.Colors.bgGrayStart,
            gradientStopColor: styles.Colors.bgGrayStop,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                TopNavigation(
                  title: 'custom board',
                  dark: true,
                  handleBackNavigation: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                  styles.Measurements.xs, 64, styles.Measurements.xs, 45),
              child: Stack(
                children: <Widget>[
                  ClipRRect(
                      borderRadius: styles.kBorderRadiusAll,
                      // The custom_board image has an aspect ratio of 3
                      child:
                          Image.asset('assets/images/boards/custom_board.png')),
                  AspectRatio(
                    aspectRatio: 3,
                    child: GridView.count(
                      padding: EdgeInsets.all(styles.Measurements.xs),
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      crossAxisSpacing: styles.Measurements.xs,
                      mainAxisSpacing: styles.Measurements.xs,
                      childAspectRatio: 3.6,
                      crossAxisCount: 4,
                      children: <Widget>[
                        ..._viewModel.boxes.map((BoxState boxState) =>
                            boxState.selected == true
                                ? _SelectedBox(
                                    handleTap: () =>
                                        _viewModel.handleBoxTap(boxState))
                                : _Box(
                                    handleTap: () =>
                                        _viewModel.handleBoxTap(boxState),
                                  ))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          BottomMenuDrawer(
            dragIndicatorColor: styles.Colors.lightGray,
            menuItems: [
              MenuItem(
                name: 'save',
                handleTap: _handleSaveTap,
              ),
              MenuItem(
                name: 'preview',
                handleTap: _handlePreviewTap,
              ),
              MenuItem(
                name: 'info',
                handleTap: _handleInfoTap,
              )
            ],
            longestMenuItemLength: 120,
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: _Modal(
                open: _viewModel.modalOpen,
                handleTap: _handleAddHoldTap,
              ))
        ],
      ),
    );
  }
}

class _Modal extends StatefulWidget {
  _Modal({Key key, @required this.open, this.handleTap}) : super(key: key);

  final bool open;
  final VoidCallback handleTap;

  @override
  _ModalState createState() => _ModalState();
}

class _ModalState extends State<_Modal> with SingleTickerProviderStateMixin {
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
  void didUpdateWidget(_Modal oldWidget) {
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
        onTap: () {
          _animationController.reverse();
          widget.handleTap();
        },
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: styles.kBorderRadius,
                  topRight: styles.kBorderRadius),
              color: styles.Colors.bgWhite),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: styles.Measurements.xs),
            child: Text(
              'add hold',
              style: styles.Staatliches.xlBlack,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

class _Box extends StatelessWidget {
  _Box({Key key, @required this.handleTap}) : super(key: key);

  final VoidCallback handleTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: handleTap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: styles.kBorderRadiusAll,
            border:
                Border.all(width: 1, color: styles.Colors.whiteTranslucent)),
        child: Center(
          child: icons.plusIconWhiteS,
        ),
      ),
    );
  }
}

class _SelectedBox extends StatelessWidget {
  _SelectedBox({Key key, @required this.handleTap}) : super(key: key);

  final VoidCallback handleTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: handleTap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: styles.kBorderRadiusAll,
            border: Border.all(width: 1, color: styles.Colors.black)),
        child: Center(
          child: icons.selectedIconBlackS,
        ),
      ),
    );
  }
}
