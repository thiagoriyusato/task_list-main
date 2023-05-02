import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserLoginPage extends StatelessWidget {
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: txtEmail,
              decoration: const InputDecoration(labelText: "E-mail"),
            ),
            TextField(
              controller: txtPassword,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Password"),
            ),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  auth.signInWithEmailAndPassword(
                      email: txtEmail.text, password: txtPassword.text)
                  .then((_) {
                    Navigator.pushNamedAndRemoveUntil(
                    context, '/task-list', (route) => false);
                  })
                  .catchError((error) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Erro de autenticação"),
                            content: Text(error.message),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("OK"),
                              ),
                            ],
                          );
                        },
                      );
                    });
                },
                child: Text("Login"),
              ),
            ),
            Container(
              margin: const EdgeInsets.only( top: 20.0),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/user-register');
                },
                child: Text("Register"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
