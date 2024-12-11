import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'core/providers/cart_providers.dart';
import 'core/routes/routes.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();


  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  String initialRoute = '/cart';

  runApp(MyApp(initialRoute: initialRoute));
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {

    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final firebaseStorage = FirebaseStorage.instance;

    GoRouter _router = GoRouter(
      initialLocation: initialRoute,
      routes: appRoutes,
    );

    return MultiRepositoryProvider(
      providers: [
        ...CartProviders.repositoryProviders(firestore),
      ],
      child: MultiBlocProvider(
        providers: [
          ...CartProviders.blocProviders,
        ],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'Pretendard',
            scaffoldBackgroundColor: Colors.white,
            appBarTheme:
            const AppBarTheme(backgroundColor: Colors.white),
            useMaterial3: true,
          ),
          routerConfig: _router, // GoRouter를 사용한 라우팅 설정
        ),
      ),
    );
  }
}

