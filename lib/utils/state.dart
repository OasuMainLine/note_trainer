

import 'package:get/get.dart';

class StateObject<T extends Enum> {
    final _state = Rxn<T>();
    StateObject(T initialState) {
      this._state.value = initialState;
    }


    to(T state){
      _state.value = state;
    }

    equals(T state){
      return state == _state.value;
    }

    not(T state){
      return state != _state.value;
    }

    onTransition(Function(T?) callback) {
      _state.listen(callback);
    }

}
