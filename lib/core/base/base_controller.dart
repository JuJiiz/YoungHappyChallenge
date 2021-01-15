import 'dart:async';

abstract class BaseController {
  Stream<bool> isLoading;

  init();

  dispose();
}
