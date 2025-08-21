import 'package:carwash/screens/admin/admin_dashboard_screen.dart';
import 'package:carwash/screens/auth/login_screen.dart';
import 'package:carwash/screens/auth/signup_screen.dart';
import 'package:carwash/screens/customer/customer_home_screen.dart';
import 'package:carwash/screens/customer/profile_screen.dart';
import 'package:carwash/screens/splash_screen.dart';
import 'package:carwash/screens/washer/washer_dashboard_screen.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = {
  '/splash': (context) => SplashScreen(),
  '/login': (context) => LoginScreen(),
  '/signup': (context) => SignupScreen(),
  '/customer_home': (context) => CustomerHomeScreen(),
  '/profile': (context) => const ProfileScreen(),
  '/washer_dashboard': (context) => WasherDashboardScreen(),
  '/admin_dashboard': (context) => AdminDashboardScreen(),
};
