import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserRegisterPage extends StatelessWidget {
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New User"),
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
              decoration: const InputDecoration(labelText: "Password")
            ),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  auth.createUserWithEmailAndPassword(
                    email: txtEmail.text, password: txtPassword.text)
                    .then((_) {
                      Navigator.pop(context);
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
                child: Text("Registrar"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
