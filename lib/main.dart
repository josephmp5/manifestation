import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:manifestation/affirmations/affirmation_data_initializer.dart.dart';
import 'package:manifestation/pages/affirmations.dart';
import 'package:manifestation/pages/manifest.dart';
import 'package:manifestation/authtentication/onboarding_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AffirmationDataInitializer.populateAffirmations();
  await Firebase.initializeApp();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            return const Affirmations();
          }
          return const OnBoardingPage();
        },
      ),
    );
  }
}
