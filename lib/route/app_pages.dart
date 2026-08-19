import 'package:get/get.dart';
import '../features/splash/splash_screen.dart';
import '../features/auth/screens/login_screen.dart';
import '../features/auth/screens/forgot_password_screen.dart';
import '../features/student_dashboard/screens/student_dashboard_screen.dart';
import '../features/navigation/screens/main_navigation_screen.dart';
import '../features/profile/screens/profile_screen.dart';
import '../features/courses/screens/my_courses_screen.dart';
import '../features/courses/screens/class_player_screen.dart';
import '../features/schedule/screens/class_schedule_screen.dart';
import '../features/reference_book/screens/reference_book_screen.dart';
import '../features/assignments/screens/assignments_screen.dart';
import '../features/exams/screens/exams_screen.dart';
import '../features/result/screens/result_screen.dart';
import '../features/discuss/screens/discuss_screen.dart';
import '../features/payment/screens/payment_history_screen.dart';
import '../features/payment/screens/stripe_payment_screen.dart';
import '../features/certificate/screens/certificates_screen.dart';
import '../features/notification/screens/notifications_screen.dart';
import '../features/recertification/screens/recertification_screen.dart';
import '../features/refer/screens/refer_screen.dart';
import '../features/youtube/screens/youtube_screen.dart';
import '../features/profile/screens/personal_details_screen.dart';
import '../features/profile/screens/change_password_screen.dart';
import '../features/profile/screens/help_support_screen.dart';

// Admin
import '../features/admin/screens/admin_dashboard_screen.dart';
import '../features/admin/screens/admin_student_management_screen.dart';
import '../features/admin/screens/admin_enrollment_screen.dart';
import '../features/admin/screens/admin_invoices_screen.dart';
import '../features/admin/screens/admin_assessments_screen.dart';
import '../features/admin/screens/admin_course_management_screen.dart';
import '../features/admin/screens/admin_push_notifications_screen.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginScreen(),
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () => const ForgotPasswordScreen(),
    ),
    GetPage(
      name: _Paths.MAIN_NAVIGATION,
      page: () => const MainNavigationScreen(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileScreen(),
    ),
    GetPage(
      name: _Paths.STUDENT_DASHBOARD,
      page: () => const StudentDashboardScreen(),
    ),
    GetPage(
      name: _Paths.MY_COURSES,
      page: () => const MyCoursesScreen(),
    ),
    GetPage(
      name: _Paths.CLASS_SCHEDULE,
      page: () => const ClassScheduleScreen(),
    ),
    GetPage(
      name: _Paths.ASSIGNMENTS,
      page: () => const AssignmentsScreen(),
    ),
    GetPage(
      name: _Paths.EXAMS,
      page: () => const ExamsScreen(),
    ),
    GetPage(
      name: _Paths.RESULT,
      page: () => const ResultScreen(),
    ),
    GetPage(
      name: _Paths.REFERENCE_BOOK,
      page: () => const ReferenceBookScreen(),
    ),
    GetPage(
      name: _Paths.CLASS_PLAYER,
      page: () => const ClassPlayerScreen(),
    ),
    GetPage(
      name: _Paths.CERTIFICATES,
      page: () => const CertificatesScreen(),
    ),
    GetPage(
      name: _Paths.DISCUSS,
      page: () => const DiscussScreen(),
    ),
    GetPage(
      name: _Paths.PAYMENTS,
      page: () => const PaymentHistoryScreen(),
    ),
    GetPage(
      name: _Paths.STRIPE_PAYMENT,
      page: () => const StripePaymentScreen(),
    ),
    GetPage(
      name: _Paths.NOTIFICATIONS,
      page: () => const NotificationsScreen(),
    ),
    GetPage(
      name: _Paths.RECERTIFICATION,
      page: () => const RecertificationScreen(),
    ),
    GetPage(
      name: _Paths.REFER,
      page: () => const ReferScreen(),
    ),
    GetPage(
      name: _Paths.YOUTUBE,
      page: () => const YoutubeScreen(),
    ),
    GetPage(
      name: _Paths.PERSONAL_DETAILS,
      page: () => PersonalDetailsScreen(),
    ),
    GetPage(
      name: _Paths.CHANGE_PASSWORD,
      page: () => const ChangePasswordScreen(),
    ),
    GetPage(
      name: _Paths.HELP_SUPPORT,
      page: () => const HelpSupportScreen(),
    ),
    GetPage(
      name: _Paths.ADMIN_DASHBOARD,
      page: () => const AdminDashboardScreen(),
    ),
    GetPage(
      name: _Paths.ADMIN_STUDENT_MANAGEMENT,
      page: () => const AdminStudentManagementScreen(),
    ),
    GetPage(
      name: _Paths.ADMIN_ENROLLMENT,
      page: () => const AdminEnrollmentScreen(),
    ),
    GetPage(
      name: _Paths.ADMIN_INVOICES,
      page: () => const AdminInvoicesScreen(),
    ),
    GetPage(
      name: _Paths.ADMIN_ASSESSMENTS,
      page: () => const AdminAssessmentsScreen(),
    ),
    GetPage(
      name: _Paths.ADMIN_COURSE_MANAGEMENT,
      page: () => const AdminCourseManagementScreen(),
    ),
    GetPage(
      name: _Paths.ADMIN_PUSH_NOTIFICATIONS,
      page: () => const AdminPushNotificationsScreen(),
    ),
  ];
}
