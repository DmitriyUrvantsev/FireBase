import 'package:firebase_2/domain/entity/user.dart';
import 'package:firebase_2/servises/auth_servises.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'screen/auth/auth_model.dart';
import 'screen/home/home_model.dart';
import 'wrapper.dart';

//start 2

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthenticateModel()),
          ChangeNotifierProvider(
          create: (context) => HomeWidgetModel()),
        StreamProvider<UserApp?>.value(
          value: AuthService().user,
          initialData: null,
        ),
      ],
      child: MaterialApp(
        routes: {
          '/': (context) => const Wrapper(),
//можно было оставить home..
        },
        initialRoute: '/',
      ),
    );
  }
}
