import 'package:flutter/material.dart';
import 'package:carwash/screens/customer/shop_screen.dart';
import 'package:carwash/screens/customer/book_screen.dart';
import 'package:carwash/screens/customer/bookings_screen.dart';
import 'package:carwash/screens/customer/profile_screen.dart';

class CustomerHomeScreen extends StatefulWidget {
  @override
  _CustomerHomeScreenState createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = [];

  @override
  void initState() {
    super.initState();
    // Initialize widgetOptions here where context is available.
    _widgetOptions = [
      _buildHomePage(context),
      const BookScreen(), // Traditional book screen
      const BookingsScreen(), // Bookings screen with sample data
      const ShopScreen(), // New Shop tab
      const ProfileScreen(), // Profile screen
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            activeIcon: Icon(Icons.add_circle),
            label: 'Book',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history_outlined),
            activeIcon: Icon(Icons.history),
            label: 'Bookings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            activeIcon: Icon(Icons.shopping_bag),
            label: 'Shop',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blue[800],
        unselectedItemColor: Colors.grey[600],
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  Widget _buildHomePage(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: _buildCustomHeader(),
          ),
          _buildSectionHeader('Special For You'),
          _buildHorizontalList(
            (context, index) => _buildSpecialOfferCard(index),
            2,
          ),
          _buildSectionHeader('Services'),
          _buildHorizontalList(
            (context, index) => _buildServiceIcon(index),
            4,
            height: 120,
          ),
          _buildSectionHeader('Popular Service Provider'),
          _buildHorizontalList(
            (context, index) => _buildProviderCard(context, index),
            2,
          ),
        ],
      ),
    );
  }

  SliverToBoxAdapter _buildSectionHeader(String title) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'See all',
              style: TextStyle(
                color: Colors.blue[800],
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildHorizontalList(
    Widget Function(BuildContext, int) itemBuilder,
    int count, {
    double height = 180,
  }) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: height,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: count,
          itemBuilder: (context, index) => itemBuilder(context, index),
        ),
      ),
    );
  }

  Widget _buildSpecialOfferCard(int index) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: const DecorationImage(
            image: AssetImage(
              'assets/images/lavage1.jpg',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: const Center(
          child: Text(
            'Special Offer',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildServiceIcon(int index) {
    final services = [
      {'icon': Icons.directions_car, 'label': 'Exterior'},
      {'icon': Icons.event_seat, 'label': 'Interior'},
      {'icon': Icons.settings, 'label': 'Engine'},
      {'icon': Icons.ac_unit, 'label': 'Vacuum'},
    ];
    return SizedBox(
      width: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.blue[100],
            child: Icon(
              services[index]['icon'] as IconData,
              color: Colors.blue[800],
            ),
          ),
          const SizedBox(height: 8),
          Text(services[index]['label'] as String, textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget _buildProviderCard(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/provider_detail');
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          width: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://via.placeholder.com/200x100/2196F3/FFFFFF?text=Provider+${index + 1}',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'ProGlow Auto Spa',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 16),
                    Text(' 4.8'),
                  ],
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}

// Add this method below your other widget builders
  Widget _buildCustomHeader() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.blue.shade800, // Darker blue
            Colors.blue.shade500, // Medium blue
          ],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      padding: EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Location', style: TextStyle(color: Colors.white70, fontSize: 13)),
                  Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.orange, size: 18),
                      SizedBox(width: 4),
                      Text('New York, USA', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                      Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 18),
                    ],
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  icon: Icon(Icons.notifications_none, color: Colors.white),
                  onPressed: () {},
                ),
              ),
            ],
          ),
          SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      hintStyle: TextStyle(color: Colors.grey[600]),
                      prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12),
              Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  icon: Icon(Icons.tune, color: Colors.blue.shade800),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
