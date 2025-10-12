import 'package:chat_app_with_firebase/screens/auth.dart';
import 'package:chat_app_with_firebase/screens/chat.dart';
import 'package:chat_app_with_firebase/screens/splash.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Chat',
      theme: ThemeData().copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 63, 17, 177),
        ),
      ),
      home:
          // Using StreamBuilder to check Auth State Changes
          // and Show appropriate Screen[AuthScreen(LogIn/SignUp) or ChatScreen]
          // the difference between StreamBuilder and FutureBuilder is
          // StreamBuilder can be used to listen to a stream of data that changes over time
          // whereas FutureBuilder is used to handle a single asynchronous operation that completes once.
          SafeArea(
        child: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (ctx, snapshot) {
            // if the connection is still waiting, show splash screen
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SplashScreen();
            }
            if (snapshot.hasData) {
              return const ChatScreen();
            }
            return const AuthScreen();
          },
        ),
      ),
    );
  }
}
