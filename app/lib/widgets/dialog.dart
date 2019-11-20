import 'package:flutter/cupertino.dart';

class AppDialog extends StatelessWidget {
  /// Creates an iOS-style alert dialog.
  ///
  /// The [actions] must not be null.
  const AppDialog(
      {Key key, this.handleCancelTap, this.handleConfirmTap, this.child})
      : super(key: key);

  final VoidCallback handleCancelTap;
  final VoidCallback handleConfirmTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Center(
            child: Container(
          margin: const EdgeInsets.symmetric(vertical: 20.0),
          width: 270,
          child: CupertinoPopupSurface(
            isSurfacePainted: false,
            child: Semantics(
              namesRoute: true,
              scopesRoute: true,
              explicitChildNodes: true,
              label: 'Alert',
              child: child,
            ),
          ),
        ));
      },
    );
  }

//  Widget _buildContent() {
//    final List<Widget> children = <Widget>[];
//
//    if (title != null || content != null) {
//      final Widget titleSection = _CupertinoAlertContentSection(
//        title: title,
//        content: content,
//        scrollController: scrollController,
//      );
//      children.add(Flexible(flex: 3, child: titleSection));
//    }
//
//    return
//  }
//
//  Widget _buildActions() {
//    Widget actionSection = Container(
//      height: 0.0,
//    );
//    if (actions.isNotEmpty) {
//      actionSection = _CupertinoAlertActionSection(
//        children: actions,
//        scrollController: actionScrollController,
//      );
//    }
//
//    return actionSection;
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    final CupertinoLocalizations localizations =
//        CupertinoLocalizations.of(context);
//    final bool isInAccessibilityMode = _isInAccessibilityMode(context);
//    final double textScaleFactor = MediaQuery.of(context).textScaleFactor;
//    return MediaQuery(
//      data: MediaQuery.of(context).copyWith(
//        // iOS does not shrink dialog content below a 1.0 scale factor
//        textScaleFactor: math.max(textScaleFactor, 1.0),
//      ),
//      child: LayoutBuilder(
//        builder: (BuildContext context, BoxConstraints constraints) {
//          return Center(
//            child: Container(
//              margin: const EdgeInsets.symmetric(vertical: _kEdgePadding),
//              width: isInAccessibilityMode
//                  ? _kAccessibilityCupertinoDialogWidth
//                  : _kCupertinoDialogWidth,
//              child: CupertinoPopupSurface(
//                isSurfacePainted: false,
//                child: Semantics(
//                  namesRoute: true,
//                  scopesRoute: true,
//                  explicitChildNodes: true,
//                  label: localizations.alertDialogLabel,
//                  child: _CupertinoDialogRenderWidget(
//                    contentSection: _buildContent(),
//                    actionsSection: _buildActions(),
//                  ),
//                ),
//              ),
//            ),
//          );
//        },
//      ),
//    );
//  }
}
