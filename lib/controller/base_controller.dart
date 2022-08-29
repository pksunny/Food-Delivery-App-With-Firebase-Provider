import 'package:flutter/material.dart';

enum ViewState { Ideal, Busy }
enum AuthState { SignIn, SignUp }

class BaseController extends ChangeNotifier {
  late ViewState _viewState;

  ViewState get viewState => _viewState;

  setViewState(ViewState viewState) {
    _viewState = viewState;
    notifyListeners();
  }

  late AuthState _authState;

  AuthState get authState => _authState;

  setAuthState(AuthState authState) {
    _authState = authState;
    notifyListeners();
  }
}