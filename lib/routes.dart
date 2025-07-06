import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/login_screen.dart';
import '../screens/register_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/auth_screen.dart';
import '../screens/work_regist_screen.dart';
import '../screens/order_screen.dart';
import '../screens/orderlist_screen.dart';
import '../screens/riwayat_screen.dart';
import '../screens/dompet_screen.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => const AuthScreen(),
  '/home': (context) => const HomeScreen(),
  '/login': (context) => const LoginScreen(),
  '/register': (context) => const RegisterScreen(),
  '/profile': (context) => const ProfileScreen(),
  '/workregist': (context) => const WorkRegistScreen(),
  '/orderlist': (context) => const OrderListScreen(),
  '/orders': (context) => const OrderScreen(),
  '/riwayat': (context) => const RiwayatScreen(),
  '/dompet': (context) => const DompetScreen()
};
