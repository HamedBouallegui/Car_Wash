import 'package:flutter/material.dart';

class WasherDashboardScreen extends StatefulWidget {
  @override
  _WasherDashboardScreenState createState() => _WasherDashboardScreenState();
}

class _WasherDashboardScreenState extends State<WasherDashboardScreen> {
  int _selectedIndex = 0;
  
  // Sample data for washer dashboard
  final Map<String, dynamic> washerProfile = {
    'name': 'John Washer',
    'rating': 4.8,
    'totalJobs': 342,
    'todayEarnings': 185.50,
    'weeklyEarnings': 945.00,
    'monthlyEarnings': 3850.00,
  };

  final List<Map<String, dynamic>> todayTasks = [
    {
      'id': 'BK001',
      'customer': 'Alice Johnson',
      'service': 'Premium Wash',
      'time': '09:00',
      'duration': '45 min',
      'price': 45.00,
      'status': 'Scheduled',
      'address': '123 Main St, Downtown',
      'car': 'Toyota Camry 2022 - Blue',
    },
    {
      'id': 'BK002',
      'customer': 'Bob Smith',
      'service': 'Interior Detail',
      'time': '10:30',
      'duration': '60 min',
      'price': 65.00,
      'status': 'Confirmed',
      'address': '456 Oak Ave, Westside',
      'car': 'Honda Civic 2021 - White',
    },
    {
      'id': 'BK003',
      'customer': 'Carol Davis',
      'service': 'Basic Wash',
      'time': '12:15',
      'duration': '30 min',
      'price': 25.00,
      'status': 'In Progress',
      'address': '789 Pine Rd, Eastside',
      'car': 'Ford Focus 2020 - Red',
    },
    {
      'id': 'BK004',
      'customer': 'David Wilson',
      'service': 'Full Service',
      'time': '14:00',
      'duration': '90 min',
      'price': 85.00,
      'status': 'Scheduled',
      'address': '321 Elm St, Northside',
      'car': 'BMW 3 Series 2023 - Black',
    },
  ];

  final List<Map<String, dynamic>> completedJobs = [
    {
      'id': 'BK100',
      'customer': 'Emma Brown',
      'service': 'Premium Wash',
      'completedTime': 'Yesterday, 16:30',
      'price': 45.00,
      'rating': 5,
      'tip': 10.00,
    },
    {
      'id': 'BK099',
      'customer': 'Frank Miller',
      'service': 'Basic Wash',
      'completedTime': 'Yesterday, 14:15',
      'price': 25.00,
      'rating': 4,
      'tip': 5.00,
    },
  ];

  final List<Map<String, dynamic>> earningsData = [
    {'day': 'Mon', 'earnings': 120.0},
    {'day': 'Tue', 'earnings': 180.0},
    {'day': 'Wed', 'earnings': 150.0},
    {'day': 'Thu', 'earnings': 220.0},
    {'day': 'Fri', 'earnings': 275.0},
    {'day': 'Sat', 'earnings': 310.0},
    {'day': 'Sun', 'earnings': 240.0},
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
        title: Text('Washer Dashboard'),
        backgroundColor: Colors.green[700],
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              _showNotifications();
            },
          ),
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              _showProfileDialog();
            },
          ),
        ],
      ),
      drawer: _buildDrawer(),
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.today),
            label: 'Today',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work),
            label: 'Jobs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            label: 'Earnings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Reviews',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green[700],
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton(
              backgroundColor: Colors.green[700],
              onPressed: () {
                _showAvailabilityDialog();
              },
              child: Icon(Icons.access_time),
            )
          : null,
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Colors.green[700]),
            accountName: Text(washerProfile['name']),
            accountEmail: Text('⭐ ${washerProfile['rating']} rating • ${washerProfile['totalJobs']} jobs'),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, size: 40, color: Colors.green[700]),
            ),
          ),
          ListTile(
            leading: Icon(Icons.today),
            title: Text('Today\'s Tasks'),
            onTap: () {
              setState(() => _selectedIndex = 0);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.work),
            title: Text('All Jobs'),
            onTap: () {
              setState(() => _selectedIndex = 1);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.attach_money),
            title: Text('Earnings'),
            onTap: () {
              setState(() => _selectedIndex = 2);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.star),
            title: Text('Reviews'),
            onTap: () {
              setState(() => _selectedIndex = 3);
              Navigator.pop(context);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.schedule),
            title: Text('Set Schedule'),
            onTap: () {
              Navigator.pop(context);
              _showScheduleDialog();
            },
          ),
          ListTile(
            leading: Icon(Icons.location_on),
            title: Text('Service Areas'),
            onTap: () {
              Navigator.pop(context);
              _showServiceAreasDialog();
            },
          ),
          ListTile(
            leading: Icon(Icons.directions_car),
            title: Text('Equipment Checklist'),
            onTap: () {
              Navigator.pop(context);
              _showEquipmentDialog();
            },
          ),
          Divider(),
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
        return _buildTodayView();
      case 1:
        return _buildJobsView();
      case 2:
        return _buildEarningsView();
      case 3:
        return _buildReviewsView();
      default:
        return _buildTodayView();
    }
  }

  Widget _buildTodayView() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTodaySummary(),
          SizedBox(height: 20),
          Text(
            'Today\'s Tasks',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          _buildTodayTasksList(),
          SizedBox(height: 20),
          Text(
            'Quick Stats',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          _buildQuickStats(),
        ],
      ),
    );
  }

  Widget _buildTodaySummary() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Today\'s Summary',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildSummaryItem(
                  Icons.calendar_today,
                  '${todayTasks.length}',
                  'Tasks',
                  Colors.blue,
                ),
                _buildSummaryItem(
                  Icons.attach_money,
                  '\$${todayTasks.fold(0.0, (sum, task) => sum + (task['price'] as double)).toStringAsFixed(0)}',
                  'Potential',
                  Colors.green,
                ),
                _buildSummaryItem(
                  Icons.star,
                  '${washerProfile['rating']}',
                  'Rating',
                  Colors.orange,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryItem(IconData icon, String value, String label, Color color) {
    return Column(
      children: [
        Icon(icon, size: 30, color: color),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildTodayTasksList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: todayTasks.length,
      itemBuilder: (context, index) {
        final task = todayTasks[index];
        return Card(
          margin: EdgeInsets.only(bottom: 8),
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: ExpansionTile(
            title: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task['customer'],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${task['service']} • ${task['time']}',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getTaskStatusColor(task['status']),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    task['status'],
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),
              ],
            ),
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('📍 ${task['address']}'),
                    SizedBox(height: 4),
                    Text('🚗 ${task['car']}'),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Text('💰 \$${task['price']}'),
                        Spacer(),
                        if (task['status'] == 'Scheduled')
                          ElevatedButton(
                            onPressed: () {
                              _startJob(task);
                            },
                            child: Text('Start Job'),
                          )
                        else if (task['status'] == 'In Progress')
                          ElevatedButton(
                            onPressed: () {
                              _completeJob(task);
                            },
                            child: Text('Complete'),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildQuickStats() {
    return Row(
      children: [
        Expanded(
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Text('Week Earnings', style: TextStyle(fontSize: 12, color: Colors.grey)),
                  Text('\$${washerProfile['weeklyEarnings']}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Text('Month Earnings', style: TextStyle(fontSize: 12, color: Colors.grey)),
                  Text('\$${washerProfile['monthlyEarnings']}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildJobsView() {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          TabBar(
            tabs: [
              Tab(text: 'Today'),
              Tab(text: 'This Week'),
              Tab(text: 'Completed'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                _buildTodayJobsList(),
                _buildWeekJobsList(),
                _buildCompletedJobsList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTodayJobsList() {
    return ListView.builder(
      padding: EdgeInsets.all(16.0),
      itemCount: todayTasks.length,
      itemBuilder: (context, index) {
        final task = todayTasks[index];
        return _buildJobCard(task);
      },
    );
  }

  Widget _buildWeekJobsList() {
    return ListView.builder(
      padding: EdgeInsets.all(16.0),
      itemCount: 8,
      itemBuilder: (context, index) {
        return _buildJobCard({
          'customer': 'Week Customer ${index + 1}',
          'service': 'Week Service',
          'time': 'Week Time',
          'status': 'Scheduled',
          'price': 35.0 + (index * 5),
        });
      },
    );
  }

  Widget _buildCompletedJobsList() {
    return ListView.builder(
      padding: EdgeInsets.all(16.0),
      itemCount: completedJobs.length,
      itemBuilder: (context, index) {
        final job = completedJobs[index];
        return Card(
          margin: EdgeInsets.only(bottom: 8),
          child: ListTile(
            title: Text(job['customer']),
            subtitle: Text('${job['service']} • ${job['completedTime']}'),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('\$${job['price']}'),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.star, size: 16, color: Colors.amber),
                    Text(' ${job['rating']}'),
                    if (job['tip'] > 0) Text(' +\$${job['tip']} tip'),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildJobCard(Map<String, dynamic> job) {
    return Card(
      margin: EdgeInsets.only(bottom: 8),
      child: ListTile(
        title: Text(job['customer']),
        subtitle: Text('${job['service']} • ${job['time']}'),
        trailing: Text('\$${job['price']}'),
      ),
    );
  }

  Widget _buildEarningsView() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildEarningsSummary(),
          SizedBox(height: 20),
          Text(
            'Weekly Breakdown',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          _buildEarningsChart(),
          SizedBox(height: 20),
          _buildEarningsDetails(),
        ],
      ),
    );
  }

  Widget _buildEarningsSummary() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Earnings Summary',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildEarningsItem('Today', '\$${washerProfile['todayEarnings']}', Colors.green),
                _buildEarningsItem('This Week', '\$${washerProfile['weeklyEarnings']}', Colors.blue),
                _buildEarningsItem('This Month', '\$${washerProfile['monthlyEarnings']}', Colors.purple),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEarningsItem(String period, String amount, Color color) {
    return Column(
      children: [
        Text(
          amount,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color),
        ),
        Text(
          period,
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildEarningsChart() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('This Week', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            Container(
              height: 200,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: earningsData.map((data) {
                  final height = (data['earnings'] as double) / 3.5;
                  return Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('\$${data['earnings'].toStringAsFixed(0)}'),
                          Container(
                            height: height,
                            decoration: BoxDecoration(
                              color: Colors.green[700],
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          Text(data['day']),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEarningsDetails() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Earnings Details', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            _buildEarningsDetailRow('Base Earnings', '\$${washerProfile['monthlyEarnings'] * 0.85}'),
            _buildEarningsDetailRow('Tips', '\$${washerProfile['monthlyEarnings'] * 0.12}'),
            _buildEarningsDetailRow('Bonuses', '\$${washerProfile['monthlyEarnings'] * 0.03}'),
            Divider(),
            _buildEarningsDetailRow('Total', '\$${washerProfile['monthlyEarnings']}', isTotal: true),
          ],
        ),
      ),
    );
  }

  Widget _buildEarningsDetailRow(String label, String amount, {bool isTotal = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontWeight: isTotal ? FontWeight.bold : FontWeight.normal)),
          Text(amount, style: TextStyle(fontWeight: isTotal ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }

  Widget _buildReviewsView() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRatingSummary(),
          SizedBox(height: 20),
          Text(
            'Recent Reviews',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          _buildReviewsList(),
        ],
      ),
    );
  }

  Widget _buildRatingSummary() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Rating',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Text(
                  '${washerProfile['rating']}',
                  style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.amber),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildRatingStars(washerProfile['rating']),
                    Text('Based on ${washerProfile['totalJobs']} reviews'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingStars(double rating) {
    return Row(
      children: List.generate(5, (index) {
        return Icon(
          index < rating.floor() ? Icons.star : Icons.star_border,
          color: Colors.amber,
          size: 20,
        );
      }),
    );
  }

  Widget _buildReviewsList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 3,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.only(bottom: 8),
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey[300],
                      child: Icon(Icons.person, size: 20),
                    ),
                    SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Customer ${index + 1}', style: TextStyle(fontWeight: FontWeight.bold)),
                        _buildRatingStars(4.5 - (index * 0.5)),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text('Great service! Very professional and thorough. Will definitely book again.'),
                SizedBox(height: 4),
                Text('2 days ago', style: TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
        );
      },
    );
  }

  Color _getTaskStatusColor(String status) {
    switch (status) {
      case 'Scheduled':
        return Colors.blue;
      case 'Confirmed':
        return Colors.orange;
      case 'In Progress':
        return Colors.green;
      case 'Completed':
        return Colors.grey;
      case 'Cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  void _startJob(Map<String, dynamic> task) {
    setState(() {
      task['status'] = 'In Progress';
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Started job for ${task['customer']}')),
    );
  }

  void _completeJob(Map<String, dynamic> task) {
    setState(() {
      task['status'] = 'Completed';
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Completed job for ${task['customer']}')),
    );
    _showJobCompletionDialog(task);
  }

  void _showJobCompletionDialog(Map<String, dynamic> task) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Job Completed!'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Great job on ${task['service']} for ${task['customer']}!'),
            SizedBox(height: 16),
            Text('Rate your experience:'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Icon(Icons.star_border),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                );
              }),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Skip'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }

  void _showNotifications() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Notifications'),
        content: Text('No new notifications'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showProfileDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Profile'),
        content: Text('Profile settings coming soon...'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showAvailabilityDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Set Availability'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SwitchListTile(
              title: Text('Available Today'),
              value: true,
              onChanged: (value) {},
            ),
            ListTile(
              title: Text('Working Hours: 8:00 AM - 6:00 PM'),
              onTap: () {},
            ),
          ],
        ),
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

  void _showScheduleDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Set Schedule'),
        content: Text('Schedule management coming soon...'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showServiceAreasDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Service Areas'),
        content: Text('Service areas management coming soon...'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showEquipmentDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Equipment Checklist'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CheckboxListTile(
              title: Text('Pressure Washer'),
              value: true,
              onChanged: (value) {},
            ),
            CheckboxListTile(
              title: Text('Vacuum Cleaner'),
              value: true,
              onChanged: (value) {},
            ),
            CheckboxListTile(
              title: Text('Cleaning Supplies'),
              value: true,
              onChanged: (value) {},
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
