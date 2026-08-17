import 'package:provider/provider.dart';

import '../provider/marketplace_provider.dart';
import '../provider/profile_provider.dart';
import '../provider/forget_password_provider.dart';
import '../provider/singnup_provider.dart';
import '../provider/carosul_provider.dart';
import '../provider/auth_provider.dart';
import '../common_wigdets/custom_theme.dart';

var providers = [
  ChangeNotifierProvider<AuthProvider>(
    create: ((context) => AuthProvider()),
  ),
  ChangeNotifierProvider<ForgetPasswordProvider>(
    create: ((context) => ForgetPasswordProvider()),
  ),

  ChangeNotifierProvider<SignupProvider>(
    create: ((context) => SignupProvider()),
  ),

  ChangeNotifierProvider<ProfileProvider>(
    create: ((context) => ProfileProvider()),
  ),

  ChangeNotifierProvider<CarosulProvider>(
    create: ((context) => CarosulProvider()),
  ),

  ChangeNotifierProvider<MarketplaceProvider>(
    create: ((context) => MarketplaceProvider()),
  ),

  ChangeNotifierProvider<CustomThemeProvider>(
    create: ((context) => CustomThemeProvider()),
  ),
];
