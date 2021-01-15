import 'package:flutter/material.dart';

class BaseUI extends StatelessWidget {
  final Stream<bool> isLoading;
  final Widget Function(BuildContext context) child;
  final double opacity;
  final Color color;
  final Widget progressIndicator;
  final String waitingText;
  final Offset offset;
  final bool dismissible;

  const BaseUI({
    Key key,
    @required this.isLoading,
    @required this.child,
    this.opacity = 0.4,
    this.color = const Color(0xff757575),
    this.progressIndicator = const CircularProgressIndicator(
      backgroundColor: Colors.white,
      valueColor: AlwaysStoppedAnimation<Color>(const Color(0xFF9CCC65)),
    ),
    this.waitingText,
    this.offset,
    this.dismissible = false,
  })  : assert(child != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        this.child(context),
        StreamBuilder(
          stream: isLoading,
          builder: (context, data) {
            var loading = data.data ?? false;
            if (loading) {
              return Stack(
                children: [
                  Opacity(
                    child: ModalBarrier(dismissible: dismissible, color: color),
                    opacity: opacity,
                  ),
                  _ProgressIndicator(
                    offset: offset,
                    loadingDialog: _LoadingDialog(
                      progressIndicator: progressIndicator,
                      waitingText: waitingText,
                    ),
                  ),
                ],
              );
            } else {
              return Material(type: MaterialType.transparency);
            }
          },
        ),
      ],
    );
  }
}

class _ProgressIndicator extends StatelessWidget {
  final Offset offset;
  final Widget loadingDialog;

  const _ProgressIndicator({
    Key key,
    this.offset,
    this.loadingDialog,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (offset != null) {
      return Padding(
        padding: EdgeInsets.all(20.0),
        child: Align(
          child: loadingDialog,
          alignment: Alignment.center,
        ),
      );
    } else {
      return Positioned(
        child: loadingDialog,
        left: offset.dx,
        top: offset.dy,
      );
    }
  }
}

class _LoadingDialog extends StatelessWidget {
  final Widget progressIndicator;
  final String waitingText;

  const _LoadingDialog({
    Key key,
    this.progressIndicator = const CircularProgressIndicator(
      backgroundColor: Colors.white,
      valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
    ),
    this.waitingText = 'Loading...',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: new BorderRadius.circular(10.0),
      ),
      width: 300.0,
      height: 200.0,
      alignment: AlignmentDirectional.center,
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Center(
            child: new SizedBox(
              height: 50.0,
              width: 50.0,
              child: progressIndicator,
            ),
          ),
          new Container(
            margin: const EdgeInsets.only(top: 25.0),
            child: new Center(
              child: new Text(
                waitingText,
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
