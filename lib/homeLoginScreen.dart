import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeLoginScreen extends StatefulWidget {
  const HomeLoginScreen({Key? key}) : super(key: key);

  @override
  State<HomeLoginScreen> createState() => _HomeLoginScreenState();
}

class _HomeLoginScreenState extends State<HomeLoginScreen> {
  late User? _currentUser;

  @override
  void initState() {
    super.initState();
    _currentUser = FirebaseAuth.instance.currentUser;
    saveUserDataToFirebase();
  }

  Future<void> saveUserDataToFirebase() async {
    final user = FirebaseAuth.instance.currentUser;
    final userData = {
      'email': user?.email,
      'displayName': user?.displayName,
      // Add other data you want to save here
    };

    // Save user data in Firebase
    final firebaseUserRef = FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: user?.email);
    await firebaseUserRef.get().then((snapshot) {
      if (snapshot.docs.isEmpty) {
        FirebaseFirestore.instance.collection('users').add(userData);
      } else {
        final docId = snapshot.docs[0].id;
        FirebaseFirestore.instance
            .collection('users')
            .doc(docId)
            .update(userData);
      }
    });
  }


  Future<void> _signOutFirebase() async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushNamedAndRemoveUntil(
        '/login', (Route<dynamic> route) => false);
  }

  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.person),
            SizedBox(width: 5),
            Text(_currentUser?.email ?? ''),
          ],
        ),
        actions: [
          GestureDetector(
            onTap: _signOutFirebase,
            child: Icon(Icons.logout),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('imagens/FundodeLegumes.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/receitas');
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: Text(
                  'Catálogo de Receitas',
                  style: TextStyle(fontSize: 25),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/minhas_receitas');
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: Text(
                  'Minhas Receitas Favoritas',
                  style: TextStyle(fontSize: 25),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/telamapa');
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: Text(
                  'Encontre-nos',
                  style: TextStyle(fontSize: 25),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  makePhoneCall('+5569992086561');
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: Text(
                  'Fale Conosco',
                  style: TextStyle(fontSize: 25),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
