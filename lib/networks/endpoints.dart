// ignore_for_file: constant_identifier_names

final class NetworkConstants {
  NetworkConstants._();
  static const ACCEPT = "Accept";
  static const APP_KEY = "App-Key";
  static const ACCEPT_LANGUAGE = "Accept-Language";
  static const ACCEPT_LANGUAGE_VALUE = "pt";
  static const APP_KEY_VALUE = String.fromEnvironment("APP_KEY_VALUE");
  static const ACCEPT_TYPE = "application/json";
  static const AUTHORIZATION = "Authorization";
  static const CONTENT_TYPE = "content-Type";
}

final class Endpoints {
  Endpoints._();
  
  static String baseUrl = 'https://worldacademy.uk/api/v1';

  // Auth
  static String login() => "/accounts";
  static String profile() => "/profile";

  // Courses
  static String courses() => "/courses";
  static String currentCourses() => "/current-courses";
  static String paginationCourses(int page) => "/pagination-courses?page=$page";
  static String searchCourses() => "/search-courses";
  static String studentLecture() => "/student-lecture";

  // Tests / Exams
  static String tests() => "/tests";
  static String startStudentTest() => "/student-tests";
  static String submitTest(int id) => "/student-test-submit/$id";
  static String testResults(int id) => "/test-results/$id";

  // Assignments
  static String assignments() => "/assignments";
  static String assignmentDetails(int id) => "/assignments/$id";
  static String submitAssignment() => "/assignment-submissions";

  // Miscellaneous
  static String menus() => "/menus";
  static String dashboardGuideline() => "/dashboard-guide-line";
  static String sendSms(String to, String message) => "http://api.greenweb.com.bd/api.php?token=1101511011017153172703d4a610c36ed6b68630a2cb72eb73b2e&to=$to&message=$message";

  // Legacy / Template Endpoints (Restored to fix compilation errors)
  static String fcmToken() => "/auth/fcm-token/";
  static String signIn() => "/auth/buyer/login/";
  static String register() => "/auth/buyer/register/";
  static String loginVerifyOtp() => "/auth/buyer/login-verify/";
}
