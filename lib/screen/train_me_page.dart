import 'package:academia/auth/auth_page.dart';
import 'package:academia/componentes/MySearchDelegate.dart';
import 'package:academia/screen/exercises_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class TrainMe extends StatefulWidget {
  const TrainMe({super.key});

  @override
  State<TrainMe> createState() => _TrainMeState();
}

final tabs = [
  Container(
    color: Colors.white, // Substitua 'Colors.red' pela cor que você deseja
    child: Center(child: Text('Home', style: TextStyle(color: Colors.black))),
  ),
  Exercises(),
  Container(
    color: Colors.white, // Substitua 'Colors.blue' pela cor que você deseja
    child: Center(child: Text('Config', style: TextStyle(color: Colors.black))),
  ),
];

class _TrainMeState extends State<TrainMe> {
  int currentIndex = 0;

  //signout button
  void signOutUser() async {
    await FirebaseAuth.instance.signOut();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AuthPage()));
  }

  @override
  final _user = FirebaseAuth.instance.currentUser?.displayName;
  final _email = FirebaseAuth.instance.currentUser?.email;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Train me'),
        backgroundColor: Color.fromRGBO(28, 43, 69, 1),
        elevation: 2,
        actions: currentIndex == 1
            ? <Widget>[
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    showSearch(context: context, delegate: MySearchDelegate());
                  },
                ),
              ]
            : null,
      ),
      drawer: Drawer(
        child: Container(
          color: Color.fromRGBO(28, 43, 69, 1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  // Seus outros widgets aqui
                  UserAccountsDrawerHeader(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(28, 43, 69, 1),
                    ),
                    accountName: Padding(
                      padding: EdgeInsets.only(top: 30.0),
                      child: Text(
                        _user!,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    accountEmail: Padding(
                      padding: EdgeInsets.only(bottom: 0.0),
                      child: Text(
                        _email!,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    currentAccountPicture: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Text(
                        "N",
                        style: TextStyle(fontSize: 40.0),
                      ),
                    ),
                  ),
                ],
              ),
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 70.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: signOutUser,
                    child: Text('Logout'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: tabs[currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: const Color.fromRGBO(28, 43, 69, 1),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 30.0,
            vertical: 15,
          ),
          child: GNav(
            gap: 8,
            onTabChange: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            backgroundColor: Color.fromRGBO(28, 43, 69, 1),
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundGradient: LinearGradient(
              colors: [
                Color.fromRGBO(255, 130, 0, 1),
                Color.fromRGBO(254, 145, 2, 1),
                Color.fromRGBO(255, 156, 1, 1),
                Color.fromRGBO(253, 156, 0, 1),
                Color.fromRGBO(255, 157, 1, 1),
                Color.fromRGBO(252, 170, 0, 1),
                Color.fromRGBO(251, 174, 0, 1),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            tabBorderRadius: 20,
            tabMargin: EdgeInsets.symmetric(horizontal: 10),
            padding: EdgeInsets.all(15),
            tabs: [
              GButton(
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(
                icon: Icons.person,
                text: 'Perfil',
              ),
              GButton(
                icon: Icons.settings,
                text: 'Config',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
