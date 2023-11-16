import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class TrainMe extends StatefulWidget {
  const TrainMe({super.key});

  @override
  State<TrainMe> createState() => _TrainMeState();
}

final tabs = [
  Center(child: Text('Home')),
  Center(child: Text('Perfil')),
  Center(child: Text('Config')),
];

class _TrainMeState extends State<TrainMe> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Train Me'),
      ),
      body: tabs[currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.black,
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
            backgroundColor: Colors.black,
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundGradient: LinearGradient(
              colors: [
                Colors.purple.shade800,
                Colors.purple.shade600,
                Colors.purple.shade400,
                Colors.purple.shade200,
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
