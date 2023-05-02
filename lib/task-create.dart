import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TaskCreatePage extends StatelessWidget {
  TextEditingController txtName = TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Task"),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(        
          children: [
            TextField(
              controller: txtName,
              decoration: const InputDecoration(
                hintText: "Digite o que precisa fazer..."
              ),
            ),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // IMPLEMENTE AQUI A INSERÇÃO DA TAREFA NO FIRESTORE:
                  firestore.collection('tasks').add({
                    'name': txtName.text,
                    'finished': false
                  });

                  Navigator.of(context).pop(); 
                },
                child: Text("Adicionar"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}