part of 'app_pages.dart';

abstract class Routes {
  static const SPLASH = _Paths.SPLASH;
  static const ONBOARDING = _Paths.ONBOARDING;
  
  static const MAIN_NAVIGATION = _Paths.MAIN_NAVIGATION;
  static const PROFILE = _Paths.PROFILE;

  static const LOGIN = _Paths.LOGIN;
  static const FORGOT_PASSWORD = _Paths.FORGOT_PASSWORD;
  
  // Student Journey
  static const STUDENT_DASHBOARD = _Paths.STUDENT_DASHBOARD;
  static const MY_COURSES = _Paths.MY_COURSES;
  static const CLASS_PLAYER = _Paths.CLASS_PLAYER;
  static const CLASS_SCHEDULE = _Paths.CLASS_SCHEDULE;
  
  // Student Extras
  static const REFERENCE_BOOK = _Paths.REFERENCE_BOOK;
  static const ASSIGNMENTS = _Paths.ASSIGNMENTS;
  static const EXAMS = _Paths.EXAMS;
  static const RESULT = _Paths.RESULT;
  static const DISCUSS = _Paths.DISCUSS;
  static const PAYMENTS = _Paths.PAYMENTS;
  static const STRIPE_PAYMENT = _Paths.STRIPE_PAYMENT;
  static const CERTIFICATES = _Paths.CERTIFICATES;
  static const NOTIFICATIONS = _Paths.NOTIFICATIONS;
  static const RECERTIFICATION = _Paths.RECERTIFICATION;
  static const REFER = _Paths.REFER;
  static const YOUTUBE = _Paths.YOUTUBE;

  // Admin
  static const ADMIN_DASHBOARD = _Paths.ADMIN_DASHBOARD;
  static const ADMIN_STUDENT_MANAGEMENT = _Paths.ADMIN_STUDENT_MANAGEMENT;
  static const ADMIN_ENROLLMENT = _Paths.ADMIN_ENROLLMENT;
  static const ADMIN_INVOICES = _Paths.ADMIN_INVOICES;
  static const ADMIN_ASSESSMENTS = _Paths.ADMIN_ASSESSMENTS;
  static const ADMIN_COURSE_MANAGEMENT = _Paths.ADMIN_COURSE_MANAGEMENT;
  static const ADMIN_PUSH_NOTIFICATIONS = _Paths.ADMIN_PUSH_NOTIFICATIONS;
}

abstract class _Paths {
  _Paths._();
  static const SPLASH = '/splash';
  static const ONBOARDING = '/onboarding';
  static const MAIN_NAVIGATION = '/main_navigation';
  static const PROFILE = '/profile';
  static const LOGIN = '/login';

  static const FORGOT_PASSWORD = '/forgot_password';
  static const STUDENT_DASHBOARD = '/student_dashboard';
  static const MY_COURSES = '/my_courses';
  static const CLASS_PLAYER = '/class_player';
  static const CLASS_SCHEDULE = '/class_schedule';
  static const REFERENCE_BOOK = '/reference_book';
  static const ASSIGNMENTS = '/assignments';
  static const EXAMS = '/exams';
  static const RESULT = '/result';
  static const DISCUSS = '/discuss';
  static const PAYMENTS = '/payments';
  static const STRIPE_PAYMENT = '/stripe_payment';
  static const CERTIFICATES = '/certificates';
  static const NOTIFICATIONS = '/notifications';
  static const RECERTIFICATION = '/recertification';
  static const REFER = '/refer';
  static const YOUTUBE = '/youtube';
  static const ADMIN_DASHBOARD = '/admin_dashboard';
  static const ADMIN_STUDENT_MANAGEMENT = '/admin_student_management';
  static const ADMIN_ENROLLMENT = '/admin_enrollment';
  static const ADMIN_INVOICES = '/admin_invoices';
  static const ADMIN_ASSESSMENTS = '/admin_assessments';
  static const ADMIN_COURSE_MANAGEMENT = '/admin_course_management';
  static const ADMIN_PUSH_NOTIFICATIONS = '/admin_push_notifications';
}
