// Unused network API client from template
import 'package:rxdart/rxdart.dart';

import '../features/auth/loginn_screen/presentation/data/data/rx.dart';
import '../features/auth/loginn_screen/presentation/data/model/login_model.dart';
import '../features/auth/register/presentation/data/rx.dart';
import '../features/auth/register/presentation/model/register_model.dart';

PostRegisterRx postRegisterRx = PostRegisterRx(
  empty: PostRegisterModel(),
  dataFetcher: BehaviorSubject<PostRegisterModel>(),
);

PostLoginRx postLoginRx = PostLoginRx(
  empty: PostLoginModel(),
  dataFetcher: BehaviorSubject<PostLoginModel>(),
);
