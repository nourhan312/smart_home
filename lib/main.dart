import 'package:flutter/material.dart';
import 'package:ui_common/ui_common.dart';
import 'core/theme/sh_theme.dart';
import 'features/home/presentation/screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
void main() async {
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
    return ScreenUtilInit(
      builder: (context, child) {
        return MaterialApp(
          title: 'Smart Home',
          debugShowCheckedModeBanner: false,
          theme: SHTheme.dark,
          home: const HomeScreen(),
        );
      },
    );
  }
}
