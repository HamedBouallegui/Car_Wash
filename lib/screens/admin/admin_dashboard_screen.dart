import 'package:flutter/material.dart';
import 'package:carwash/screens/customer/bookings_screen.dart';
import 'package:carwash/screens/admin/product_list_screen.dart';
import 'package:carwash/screens/admin/admin_shop_screen.dart';

class AdminDashboardScreen extends StatefulWidget {
  @override
  _AdminDashboardScreenState createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  int _selectedIndex = 0;
  
  // Sample data for dashboard
  final List<Map<String, dynamic>> dashboardStats = [
    {'title': 'Total Bookings', 'value': '156', 'icon': Icons.calendar_today, 'color': Colors.blue},
    {'title': 'Active Users', 'value': '89', 'icon': Icons.people, 'color': Colors.green},
    {'title': 'Revenue', 'value': '\$12,450', 'icon': Icons.attach_money, 'color': Colors.orange},
    {'title': 'Pending Requests', 'value': '7', 'icon': Icons.pending, 'color': Colors.red},
  ];

  final List<Map<String, dynamic>> recentBookings = [
    {
      'id': 'BK001',
      'customer': 'John Doe',
      'service': 'Premium Wash',
      'date': '2024-01-15',
      'time': '14:30',
      'status': 'Confirmed',
      'price': 45.00,
    },
    {
      'id': 'BK002',
      'customer': 'Jane Smith',
      'service': 'Interior Detail',
      'date': '2024-01-15',
      'time': '16:00',
      'status': 'Pending',
      'price': 65.00,
    },
    {
      'id': 'BK003',
      'customer': 'Mike Johnson',
      'service': 'Basic Wash',
      'date': '2024-01-16',
      'time': '09:00',
      'status': 'Completed',
      'price': 25.00,
    },
  ];

  final List<Map<String, dynamic>> services = [
    {'name': 'Basic Wash', 'price': 25.00, 'duration': '30 min', 'active': true},
    {'name': 'Premium Wash', 'price': 45.00, 'duration': '45 min', 'active': true},
    {'name': 'Interior Detail', 'price': 65.00, 'duration': '60 min', 'active': true},
    {'name': 'Full Service', 'price': 85.00, 'duration': '90 min', 'active': true},
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
        backgroundColor: Colors.blue[800],
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Show notifications
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              _showSettingsDialog();
            },
          ),
        ],
      ),
      drawer: _buildDrawer(),
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Bookings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Users',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.build),
            label: 'Services',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue[800],
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Colors.blue[800]),
            accountName: Text('Admin User'),
            accountEmail: Text('admin@carwash.com'),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.admin_panel_settings, size: 40, color: Colors.blue[800]),
            ),
          ),
          ListTile(
            leading: Icon(Icons.dashboard),
            title: Text('Dashboard'),
            onTap: () {
              setState(() => _selectedIndex = 0);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.calendar_today),
            title: Text('Bookings'),
            onTap: () {
              setState(() => _selectedIndex = 1);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.people),
            title: Text('Manage Users'),
            onTap: () {
              setState(() => _selectedIndex = 2);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.build),
            title: Text('Services'),
            onTap: () {
              setState(() => _selectedIndex = 3);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.shopping_bag),
            title: Text('Product Management'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ProductListScreen()));
            },
          ),
          ListTile(
            leading: Icon(Icons.store),
            title: Text('Shop Management'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminShopScreen()));
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.analytics),
            title: Text('Analytics'),
            onTap: () {
              Navigator.pop(context);
              _showAnalyticsDialog();
            },
          ),
          ListTile(
            leading: Icon(Icons.report),
            title: Text('Reports'),
            onTap: () {
              Navigator.pop(context);
              _showReportsDialog();
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {
              Navigator.pop(context);
              _handleLogout();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return _buildDashboard();
      case 1:
        return _buildBookingsManagement();
      case 2:
        return _buildUsersManagement();
      case 3:
        return _buildServicesManagement();
      default:
        return _buildDashboard();
    }
  }

  Widget _buildDashboard() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Dashboard Overview',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          _buildStatsGrid(),
          SizedBox(height: 24),
          _buildRecentBookings(),
          SizedBox(height: 24),
          _buildQuickActions(),
        ],
      ),
    );
  }

  Widget _buildStatsGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.5,
      ),
      itemCount: dashboardStats.length,
      itemBuilder: (context, index) {
        final stat = dashboardStats[index];
        return Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(stat['icon'], size: 40, color: stat['color']),
                SizedBox(height: 8),
                Text(
                  stat['value'],
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  stat['title'],
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildRecentBookings() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent Bookings',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {
                    setState(() => _selectedIndex = 1);
                  },
                  child: Text('View All'),
                ),
              ],
            ),
            SizedBox(height: 8),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: recentBookings.length,
              itemBuilder: (context, index) {
                final booking = recentBookings[index];
                return ListTile(
                  title: Text('${booking['customer']} - ${booking['service']}'),
                  subtitle: Text('${booking['date']} at ${booking['time']}'),
                  trailing: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getStatusColor(booking['status']),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      booking['status'],
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Quick Actions',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildQuickActionButton(
                  Icons.add,
                  'Add Booking',
                  Colors.blue,
                  () => _showAddBookingDialog(),
                ),
                _buildQuickActionButton(
                  Icons.person_add,
                  'Add User',
                  Colors.green,
                  () => _showAddUserDialog(),
                ),
                _buildQuickActionButton(
                  Icons.add_box,
                  'Add Service',
                  Colors.orange,
                  () => _showAddServiceDialog(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionButton(IconData icon, String label, Color color, VoidCallback onPressed) {
    return Column(
      children: [
        FloatingActionButton(
          mini: true,
          backgroundColor: color,
          onPressed: onPressed,
          child: Icon(icon, color: Colors.white),
        ),
        SizedBox(height: 8),
        Text(label, style: TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget _buildBookingsManagement() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search bookings...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16),
              ElevatedButton(
                onPressed: () => _showAddBookingDialog(),
                child: Text('Add Booking'),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: recentBookings.length,
            itemBuilder: (context, index) {
              final booking = recentBookings[index];
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  title: Text('${booking['customer']} - ${booking['service']}'),
                  subtitle: Text('${booking['date']} at ${booking['time']}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: _getStatusColor(booking['status']),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          booking['status'],
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                      PopupMenuButton(
                        itemBuilder: (context) => [
                          PopupMenuItem(child: Text('View Details'), value: 'view'),
                          PopupMenuItem(child: Text('Edit'), value: 'edit'),
                          PopupMenuItem(child: Text('Cancel'), value: 'cancel'),
                        ],
                        onSelected: (value) {
                          // Handle menu actions
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildUsersManagement() {
    return Center(
      child: Text(
        'Users Management - Coming Soon',
        style: TextStyle(fontSize: 18),
      ),
    );
  }

  Widget _buildServicesManagement() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search services...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16),
              ElevatedButton(
                onPressed: () => _showAddServiceDialog(),
                child: Text('Add Service'),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: services.length,
            itemBuilder: (context, index) {
              final service = services[index];
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  title: Text(service['name']),
                  subtitle: Text('${service['duration']} - \$${service['price']}'),
                  trailing: Switch(
                    value: service['active'],
                    onChanged: (value) {
                      setState(() {
                        service['active'] = value;
                      });
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Confirmed':
        return Colors.green;
      case 'Pending':
        return Colors.orange;
      case 'Completed':
        return Colors.blue;
      case 'Cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  void _showSettingsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Settings'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text('Notifications'),
              trailing: Switch(value: true, onChanged: (value) {}),
            ),
            ListTile(
              leading: Icon(Icons.security),
              title: Text('Security'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.language),
              title: Text('Language'),
              onTap: () {},
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showAnalyticsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Analytics'),
        content: Text('Analytics dashboard coming soon...'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showReportsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Reports'),
        content: Text('Reports section coming soon...'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showAddBookingDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add New Booking'),
        content: Text('Add booking form coming soon...'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showAddUserDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add New User'),
        content: Text('Add user form coming soon...'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showAddServiceDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add New Service'),
        content: Text('Add service form coming soon...'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Save'),
          ),
        ],
      ),
    );
  }

  void _handleLogout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Logout'),
        content: Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Handle logout logic
            },
            child: Text('Logout'),
          ),
        ],
      ),
    );
  }
}
