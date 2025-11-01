part of 'app_pages.dart';

abstract class Routes {
  static const MAIN = _Paths.MAIN;
  static const HOME = _Paths.HOME;
  static const DETAIL = _Paths.DETAIL;
  static const PROFILE = _Paths.PROFILE;
  static const AUTH = _Paths.AUTH;
  static const NOTIFICATION = _Paths.NOTIFICATION;
  static const TEST = _Paths.TEST;
  static const ACTIVITY = _Paths.ACTIVITY;
  static const SCAN = _Paths.SCAN;
  // static const DASHBOARD = _Paths.DASHBOARD;
  // static const EVENT = _Paths.EVENT;
}

abstract class _Paths {
  static const MAIN = '/main';
  static const HOME = '/home';
  static const DETAIL = '/detail';
  static const PROFILE = '/profile';
  static const AUTH = '/auth';
  static const NOTIFICATION ='/notif';
  static const TEST = '/test';
  static const ACTIVITY = '/activity';
  static const SCAN = '/scan';
  // static const DASHBOARD = '/dashboard';
  // static const EVENT = '/event';
}
