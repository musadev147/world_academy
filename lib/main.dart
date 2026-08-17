import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:auto_animated/auto_animated.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'helpers/di.dart';
import 'helpers/helper_methods.dart';
import 'helpers/register_provider.dart';
import 'helpers/navigation_service.dart';
import 'constants/app_colors.dart';
import 'constants/custom_theme.dart';
import 'common_wigdets/custom_theme.dart';
import 'route/app_pages.dart';
import 'networks/dio/dio.dart';
import 'features/splash/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'networks/firebase_api.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  diSetup();
  initiInternetChecker();
  DioSingleton.instance.create();
  try {
    await Firebase.initializeApp();
    await FirebaseApi().sendTokenToServer();
  } catch (e) {
    print("Firebase initialization failed: $e");
  }

  configLoading();

  runApp(const MyApp());
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(seconds: 3)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 40.0
    ..radius = 10.0
    ..maskType = EasyLoadingMaskType.none
    ..toastPosition = EasyLoadingToastPosition.top
    ..backgroundColor = const Color(0xFF00F0FF)
    ..textColor = Colors.white
    ..indicatorColor = Colors.white
    ..userInteractions = true
    ..dismissOnTap = true;
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    rotation();
    setInitValue();
    return MultiProvider(
      providers: providers,
      child: AnimateIfVisibleWrapper(
        showItemInterval: const Duration(milliseconds: 150),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return const UtillScreenMobile();
          },
        ),
      ),
    );
  }
}

class UtillScreenMobile extends StatelessWidget {
  const UtillScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<CustomThemeProvider>(context);
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
          showPerformanceOverlay: false,
          theme: themeProvider.currentTheme,
          debugShowCheckedModeBanner: false,
          navigatorKey: NavigationService.navigatorKey,
          navigatorObservers: [routeObserver],
          builder: EasyLoading.init(),
        );
      },
    );
  }
}
