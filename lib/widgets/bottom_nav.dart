import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;

  const BottomNavBar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        if (index == currentIndex) return; // Hindari navigasi ulang ke halaman yang sama
        switch (index) {
          case 0:
            Navigator.pushReplacementNamed(context, '/home');
            break;
          case 1:
            Navigator.pushReplacementNamed(context, '/orders'); // Rute ke halaman Pesanan
            break;
          case 2:
            Navigator.pushReplacementNamed(context, '/profile'); // Rute ke halaman Profil
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
        BottomNavigationBarItem(icon: Icon(Icons.assignment), label: 'Pesanan'),
        BottomNavigationBarItem(icon: Icon(Icons.person_2_rounded), label: 'Profil'),
      ],
    );
  }
}
