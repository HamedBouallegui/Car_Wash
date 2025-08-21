import 'package:flutter/material.dart';
import 'package:carwash/config/theme.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;
  bool _locationServices = true;

  // Sample user data - in real app, this would come from auth service
  final Map<String, dynamic> _userData = {
    'name': 'John Doe',
    'email': 'john.doe@email.com',
    'phone': '+1 (555) 123-4567',
    'memberSince': 'January 2024',
    'totalWashes': 24,
    'loyaltyPoints': 480,
    'tier': 'Gold',
    'vehicles': [
      {'make': 'Toyota', 'model': 'Camry', 'year': 2020, 'plate': 'ABC-123'},
      {'make': 'Honda', 'model': 'Civic', 'year': 2019, 'plate': 'XYZ-789'},
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: _showEditProfileDialog,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileHeader(),
            const SizedBox(height: 20),
            _buildStatsSection(),
            const SizedBox(height: 20),
            _buildVehiclesSection(),
            const SizedBox(height: 20),
            _buildSettingsSection(),
            const SizedBox(height: 20),
            _buildActionsSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 50,
            backgroundColor: Colors.white,
            child: Icon(
              Icons.person,
              size: 50,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            _userData['name'],
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            _userData['email'],
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '${_userData['tier']} Member',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatCard('Total Washes', _userData['totalWashes'].toString(), Icons.local_car_wash),
          _buildStatCard('Loyalty Points', _userData['loyaltyPoints'].toString(), Icons.stars),
          _buildStatCard('Member Since', _userData['memberSince'], Icons.calendar_today),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.blue, size: 30),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVehiclesSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'My Vehicles',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: _showAddVehicleDialog,
                child: const Text(
                  'Add New',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ..._userData['vehicles'].map<Widget>((vehicle) => _buildVehicleCard(vehicle)).toList(),
        ],
      ),
    );
  }

  Widget _buildVehicleCard(Map<String, dynamic> vehicle) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.directions_car, color: Colors.blue, size: 30),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${vehicle['year']} ${vehicle['make']} ${vehicle['model']}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  'Plate: ${vehicle['plate']}',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.blue),
            onPressed: () => _showEditVehicleDialog(vehicle),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Settings',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          _buildSettingsCard(),
        ],
      ),
    );
  }

  Widget _buildSettingsCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildSettingsItem(
            'Push Notifications',
            Icons.notifications,
            _notificationsEnabled,
            (value) => setState(() => _notificationsEnabled = value),
          ),
          _divider(),
          _buildSettingsItem(
            'Dark Mode',
            Icons.dark_mode,
            _darkModeEnabled,
            (value) => setState(() => _darkModeEnabled = value),
          ),
          _divider(),
          _buildSettingsItem(
            'Location Services',
            Icons.location_on,
            _locationServices,
            (value) => setState(() => _locationServices = value),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsItem(String title, IconData icon, bool value, Function(bool) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.blue,
          ),
        ],
      ),
    );
  }

  Widget _divider() {
    return Container(
      height: 1,
      margin: const EdgeInsets.symmetric(horizontal: 15),
      color: Colors.grey[200],
    );
  }

  Widget _buildActionsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Account',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          _buildActionCard(),
        ],
      ),
    );
  }

  Widget _buildActionCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildActionItem('Payment Methods', Icons.credit_card, _showPaymentMethods),
          _divider(),
          _buildActionItem('Order History', Icons.history, _showOrderHistory),
          _divider(),
          _buildActionItem('Help & Support', Icons.help_outline, _showHelpSupport),
          _divider(),
          _buildActionItem('Privacy Policy', Icons.privacy_tip, _showPrivacyPolicy),
          _divider(),
          _buildActionItem('Log Out', Icons.logout, _showLogoutConfirmation, isDestructive: true),
        ],
      ),
    );
  }

  Widget _buildActionItem(String title, IconData icon, VoidCallback onTap, {bool isDestructive = false}) {
    return ListTile(
      leading: Icon(icon, color: isDestructive ? Colors.red : Colors.blue),
      title: Text(
        title,
        style: TextStyle(
          color: isDestructive ? Colors.red : Colors.black87,
        ),
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap,
    );
  }

  void _showEditProfileDialog() {
    final nameController = TextEditingController(text: _userData['name']);
    final emailController = TextEditingController(text: _userData['email']);
    final phoneController = TextEditingController(text: _userData['phone']);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Profile'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              TextField(
                controller: phoneController,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  prefixIcon: Icon(Icons.phone),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // In real app, save to backend
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Profile updated successfully')),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showAddVehicleDialog() {
    final makeController = TextEditingController();
    final modelController = TextEditingController();
    final yearController = TextEditingController();
    final plateController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Vehicle'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: makeController,
                decoration: const InputDecoration(
                  labelText: 'Make',
                  prefixIcon: Icon(Icons.directions_car),
                ),
              ),
              TextField(
                controller: modelController,
                decoration: const InputDecoration(
                  labelText: 'Model',
                  prefixIcon: Icon(Icons.directions_car),
                ),
              ),
              TextField(
                controller: yearController,
                decoration: const InputDecoration(
                  labelText: 'Year',
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: plateController,
                decoration: const InputDecoration(
                  labelText: 'License Plate',
                  prefixIcon: Icon(Icons.confirmation_number),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // In real app, save to backend
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Vehicle added successfully')),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _showEditVehicleDialog(Map<String, dynamic> vehicle) {
    // Similar to add vehicle dialog but with pre-filled data
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Edit vehicle feature coming soon')),
    );
  }

  void _showPaymentMethods() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Payment methods feature coming soon')),
    );
  }

  void _showOrderHistory() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Order history feature coming soon')),
    );
  }

  void _showHelpSupport() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Help & Support'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Contact us at:'),
            SizedBox(height: 10),
            Text('Email: support@carwash.com'),
            Text('Phone: 1-800-CAR-WASH'),
            Text('Hours: 8 AM - 8 PM, 7 days a week'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showPrivacyPolicy() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Privacy Policy'),
        content: const SingleChildScrollView(
          child: Text(
            'We respect your privacy. Your data is securely stored and only used to provide better service. We do not share your personal information with third parties without your consent.',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showLogoutConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Log Out'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // In real app, clear auth tokens and navigate to login
              Navigator.pop(context);
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/login',
                (route) => false,
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Log Out'),
          ),
        ],
      ),
    );
  }
}