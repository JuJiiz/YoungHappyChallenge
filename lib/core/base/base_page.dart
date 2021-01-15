import 'package:flutter/material.dart';
import 'package:younghappychallenge/core/base/base_controller.dart';
import 'package:younghappychallenge/core/base/base_ui.dart';
import 'package:younghappychallenge/core/base/life_cycle_listener.dart';

abstract class BasePage<T extends BaseController> extends StatefulWidget
    with LifeCycleListener {
  final BuildContext context;
  final T controller;

  const BasePage(
    this.context,
    this.controller, {
    Key key,
  }) : super(key: key);

  Widget initUI(BuildContext context);

  @override
  State<StatefulWidget> createState() => _BasePageState(
        initUI,
        controller,
        this,
      );
}

class _BasePageState extends State<BasePage> with WidgetsBindingObserver {
  final BaseController _controller;
  final Widget Function(BuildContext context) _initUI;
  final LifeCycleListener _lifeCycleListener;

  _BasePageState(initUI, controller, lifeCycleListener)
      : _initUI = initUI,
        _controller = controller,
        _lifeCycleListener = lifeCycleListener;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _lifeCycleListener.onStateInit();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _lifeCycleListener.onDispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        {
          _lifeCycleListener.onResume();
          break;
        }
      case AppLifecycleState.paused:
        {
          _lifeCycleListener.onPause();
          break;
        }
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.detached:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseUI(isLoading: _controller.isLoading, child: _initUI);
  }
}
