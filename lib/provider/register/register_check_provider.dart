import 'package:flutter_riverpod/flutter_riverpod.dart';

final registerCheckProvider =
    StateNotifierProvider<RegisterCheckProvider, List<bool?>>(
  (ref) => RegisterCheckProvider(),
);

class RegisterCheckProvider extends StateNotifier<List<bool?>> {
  RegisterCheckProvider() : super(List.generate(10, (index) => false));

  void init(int length) {
    state = List.generate(length, (index) => false);
  }

  void check(int index, bool value) {
    state = [
      ...state.sublist(0, index),
      value,
      ...state.sublist(index + 1),
    ];
  }

  void load(DateTime selectedDateTime) {
    // TODO selectedDateTime으로 API 호출
    state = List.generate(10, (index) => false);
  }
}
