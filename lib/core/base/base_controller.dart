import 'package:rxdart/rxdart.dart';
import 'package:younghappychallenge/core/base/base_view_event.dart';

abstract class BaseController {
  BehaviorSubject<BaseViewEvent> viewState =
      BehaviorSubject.seeded(NormalViewState());

  setViewState(BaseViewEvent viewEvent) {
    viewState.sink.add(viewEvent);
  }

  init() {}

  dispose() {
    viewState.close();
  }
}
