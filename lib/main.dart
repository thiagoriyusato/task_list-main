import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:task_list/user-login.dart';
import 'user-register.dart';
import 'task-create.dart';
import 'task-list.dart';

const firebaseOptions = FirebaseOptions(
  apiKey: "AIzaSyCIn10uGwbGB_fKwsh3tHhi8cMDepzLdtc",
  authDomain: "taskl-6ec79.firebaseapp.com",
  databaseURL: "https://taskl-6ec79-default-rtdb.firebaseio.com",
  projectId: "taskl-6ec79",
  storageBucket: "taskl-6ec79.appspot.com",
  messagingSenderId: "35566142459",
  appId: "1:35566142459:web:eb38a45f5fbbafa22f415e"
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: firebaseOptions);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        // home: TaskListPage(),
        initialRoute: '/user-login',
        routes: {
          '/task-list': (context) => TaskListPage(),
          '/task-create': (context) => TaskCreatePage(),
          '/user-register': (context) => UserRegisterPage(),
          '/user-login': (context) => UserLoginPage(),
        });
  }
}
