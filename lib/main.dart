import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_features/core/providers/home_providers.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

import 'core/providers/cart_providers.dart';
import 'core/providers/my_grade_providers.dart';
import 'core/providers/point_providers.dart';
import 'core/providers/review_providers.dart';
import 'core/providers/shipping_address_providers.dart';
import 'core/routes/routes.dart';
import 'core/theme/app_theme.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  String initialRoute = '/home';

  runApp(MyApp(initialRoute: initialRoute));
}

class MyApp extends StatelessWidget {
  final String initialRoute;


  MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final firebaseStorage = FirebaseStorage.instance;
    final client = http.Client();

    GoRouter _router = GoRouter(
      initialLocation: initialRoute,
      routes: appRoutes,
    );

    return MultiRepositoryProvider(
      providers: [
        ...CartProviders.repositoryProviders(firestore),
        ...ReviewProviders.repositoryProviders(firestore),
        ...ShippingAddressProviders.repositoryProviders,
        ...MyGradeProviders.repositoryProviders(firestore), // 등급 관련 의존성 주입,
        ...PointProviders.repositoryProviders(firestore),
        ...HomeProviders.repositoryProviders(client),
      ],
      child: MultiBlocProvider(
        providers: [
          ...CartProviders.blocProviders,
          ...ShippingAddressProviders.blocProviders,
          ...MyGradeProviders.blocProvider,
          ...ReviewProviders.blocProviders,
          ...PointProviders.blocProviders,
          ...HomeProviders.blocProviders,
        ],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.darkTheme,
          routerConfig: _router, // GoRouter를 사용한 라우팅 설정
        ),
      ),
    );
  }
}
