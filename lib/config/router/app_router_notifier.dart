import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/auth/presentation/riverpod/providers.dart';

final goRouterNotifierProvider = Provider(
  (ref) {
    final authNotifier = ref.read(authProvider.notifier);
    return GoRouterNotifier(
      authNotifier,
    );
  },
);

class GoRouterNotifier extends ChangeNotifier {
  final AuthNotifier _authNotifier;
  AuthStatus _authStatus = AuthStatus.checking;
  // AuthState _authState = AuthState();

  GoRouterNotifier(this._authNotifier) {
    _authNotifier.addListener((state) {
      authStatus = state.authStatus;
      // authState = state;
    });
  }

  AuthStatus get authStatus => _authStatus;
  // AuthState get authState => _authState;

  set authStatus(AuthStatus value) {
    _authStatus = value;
    notifyListeners();
  }

  // set authState(AuthState value) {
  //   _authState = value;
  //   notifyListeners();
  // }
}
