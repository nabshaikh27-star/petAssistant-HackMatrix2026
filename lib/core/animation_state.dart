import 'package:flutter/foundation.dart';

enum PetAnimationState {
  idle,
  alert,
  talking
}

class PetAnimationController {
  static final PetAnimationController _instance = PetAnimationController._internal();
  factory PetAnimationController() => _instance;
  PetAnimationController._internal();

  final ValueNotifier<PetAnimationState> state = ValueNotifier(PetAnimationState.idle);

  void setIdle() {
    state.value = PetAnimationState.idle;
  }

  void setAlert() {
    state.value = PetAnimationState.alert;
  }

  void setTalking() {
    state.value = PetAnimationState.talking;
  }
}
