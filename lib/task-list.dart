import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'task.dart';

class TaskListPage extends StatefulWidget {
  @override
  _TaskListPageState createState() => _TaskListPageState();
  FirebaseAuth auth = FirebaseAuth.instance;
}

class _TaskListPageState extends State<TaskListPage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool showFinishedTasks = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task List"),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () async {
                await widget.auth.signOut();
                Navigator.pushNamedAndRemoveUntil(
                    context, '/user-login', (route) => false);
              },
            ),
            IconButton(
              alignment: Alignment.center,
              icon: Icon(showFinishedTasks ? Icons.visibility_off : Icons.visibility),
              onPressed: () {
                        setState(() {
                          showFinishedTasks = !showFinishedTasks;
                        });
                      },
            ),
          ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestore.collection('tasks').orderBy('name').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          var tasks = snapshot.data!.docs
              as List<QueryDocumentSnapshot<Map<String, dynamic>>>;

          if (showFinishedTasks) {
            tasks = tasks.where((t) => t['finished']).toList();
          } else {
            tasks = tasks.where((t) => !t['finished']).toList();
          }

          return ListView(
            children: tasks
                .map(
                  (t) => Dismissible(
                    key: Key(t.id),
                    onDismissed: (_) =>
                        firestore.collection('tasks').doc(t.id).delete(),
                    background: Container(color: Colors.red),
                    child: CheckboxListTile(
                      title: Text(t['name']),
                      value: t['finished'],
                      onChanged: (value) => firestore.collection('tasks')
                          .doc(t.id)
                          .update({'finished': value}),
                    ),
                  ),
                )
                .toList(),
          );
        
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed('/task-create'),
        child: Icon(Icons.add),
      ),
    );
  }
}