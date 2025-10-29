part of 'app_pages.dart';

abstract class Routes {
  static const MAIN = _Paths.MAIN;
  static const HOME = _Paths.HOME;
  static const PROFILE = _Paths.PROFILE;
  static const AUTH = _Paths.AUTH;
  // static const DASHBOARD = _Paths.DASHBOARD;
  // static const EVENT = _Paths.EVENT;
}

abstract class _Paths {
  static const MAIN = '/main';
  static const HOME = '/home';
  static const PROFILE = '/profile';
  static const AUTH = '/auth';
  // static const DASHBOARD = '/dashboard';
  // static const EVENT = '/event';
}
