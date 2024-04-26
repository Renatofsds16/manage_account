import 'package:flutter/material.dart';
import 'package:manage_account/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:manage_account/pages/Login.dart';


void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
      MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
          useMaterial3: true
        ),
        debugShowCheckedModeBanner: false,
        home: const Login(),
      )
  );
}