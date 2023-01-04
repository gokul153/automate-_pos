import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.add))]),
      body: myform(),
    );
  }
}

class myform extends StatefulWidget {
  const myform({Key? key}) : super(key: key);

  @override
  State<myform> createState() => _myformState();
}

class _myformState extends State<myform> {
  final mycontroller = TextEditingController();
  String pname = "";
  @override
  void initState() {
    super.initState();
    // mycontroller.addListener(_printLatestvalu)
  }

  @override
  void dispose() {
    mycontroller.dispose();
    super.dispose();
  }

  Future createuser({required String cname}) async {
    final docUser = FirebaseFirestore.instance.collection('users').doc('my-id');
    final json = {
      'name': cname,
      'age': 22,
      'birthday': DateTime(2001, 5, 23),
    };
    await docUser.set(json);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Enter the product',
                border: OutlineInputBorder(),
              ),
              onChanged: (text) {
                print('First text field: $text');
                final name = mycontroller.text;
                pname = name;
              },
            ),
            TextField(
              controller: mycontroller,
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                     final addnew = mycontroller.text;
                  createuser(cname: addnew);
                  print("name successfully added$addnew");
                  });
                 
                },
                child: Text("submit"))
          ],
        ),
      ),
    );
  }
}
