import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:glug_app/models/themes.dart';
import 'package:glug_app/screens/drawer_screen.dart';
import 'package:glug_app/screens/first_screen.dart';
import 'package:glug_app/screens/login_screen.dart';
import 'package:glug_app/screens/splash_screen.dart';
import 'package:glug_app/services/auth_service.dart';
import 'package:glug_app/services/shared_pref_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // await Permission.camera.request();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  static final id = 'membersscreen';

  @override
  _MainApp createState() => _MainApp();
}

class AppThemes {
  static const int Light = 0;
  static const int Dark = 1;
}

class _MainApp extends State<MainApp> {
  bool _isIntroDone = false;
  bool _isDark = false;

  @override
  void initState() {
    SharedPrefService.getIsDark().then((isDark) {
      setState(() {
        _isDark = isDark;
      });
    });
    SharedPrefService.getIntroDone().then((isDone) {
      setState(() {
        _isIntroDone = isDone;
      });
    });
    super.initState();
  }

  // Widget _getScreen() {
  //   return StreamBuilder<User>(
  //     stream: AuthService.authStateChanges,
  //     builder: (BuildContext context, snapshot) {
  //       if (snapshot.hasData)
  //         return Scaffold(
  //             body: DoubleBackToCloseApp(
  //                 snackBar: const SnackBar(
  //                   content: Text('Tap back again to leave'),
  //                 ),
  //                 child: Stack(
  //                   children: [
  //                     DrawerScreen(),
  //                     FirstScreen(),
  //                   ],
  //                 )));
  //       else
  //         return LoginScreen();
  //     },
  //   );
  // }

  final themeCollection = ThemeCollection(
    themes: {
      AppThemes.Light: Themes.lightTheme,
      AppThemes.Dark: Themes.darkTheme,
    },
    fallbackTheme: ThemeData.light(),
  );

  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      themeCollection: themeCollection,
      builder: (context, theme) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "GLUG App",
          theme: theme,
          home: SplashScreen(),
        );
      },
    );
  }
}
