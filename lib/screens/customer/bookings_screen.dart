import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Booking {
  final String id;
  final String service;
  final DateTime date;
  final TimeOfDay time;
  final String location;
  final String status;
  final double price;

  Booking({
    required this.id,
    required this.service,
    required this.date,
    required this.time,
    required this.location,
    required this.status,
    required this.price,
  });
}

class BookingsScreen extends StatefulWidget {
  const BookingsScreen({super.key});

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> {
  final List<Booking> bookings = [
    Booking(
      id: 'BK001',
      service: 'Wash Complet',
      date: DateTime.now().add(const Duration(days: 1)),
      time: const TimeOfDay(hour: 10, minute: 0),
      location: 'Avenue Mohammed V',
      status: 'Confirmed',
      price: 150.0,
    ),
    Booking(
      id: 'BK002',
      service: 'Nettoyage Intérieur',
      date: DateTime.now().add(const Duration(days: 3)),
      time: const TimeOfDay(hour: 14, minute: 30),
      location: 'Hay Riad',
      status: 'Pending',
      price: 120.0,
    ),
    Booking(
      id: 'BK003',
      service: 'Polissage',
      date: DateTime.now().add(const Duration(days: 5)),
      time: const TimeOfDay(hour: 9, minute: 0),
      location: 'Centre Ville',
      status: 'Completed',
      price: 200.0,
    ),
  ];

  String _formatDate(DateTime date) {
    return DateFormat('dd MMM yyyy').format(date);
  }

  String _formatTime(TimeOfDay time) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat('HH:mm').format(dt);
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'confirmed':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'completed':
        return Colors.blue;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'confirmed':
        return Icons.check_circle;
      case 'pending':
        return Icons.access_time;
      case 'completed':
        return Icons.done_all;
      case 'cancelled':
        return Icons.cancel;
      default:
        return Icons.help;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.blue[700],
        elevation: 0,
        title: const Text(
          'Mes Réservations',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
      ),
      body: bookings.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.calendar_today,
                    size: 80,
                    color: Colors.blue[200],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Aucune réservation',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Commencez par réserver un service',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[500],
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[700],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 15,
                      ),
                    ),
                    onPressed: () {
                      // Navigate to booking screen
                      Navigator.pushNamed(context, '/book');
                    },
                    child: const Text(
                      'Réserver maintenant',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: bookings.length,
              itemBuilder: (context, index) {
                final booking = bookings[index];
                return _buildBookingCard(booking);
              },
            ),
    );
  }

  Widget _buildBookingCard(Booking booking) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.blue[100]!.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  booking.service,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor(booking.status).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: _getStatusColor(booking.status).withOpacity(0.3),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        _getStatusIcon(booking.status),
                        size: 16,
                        color: _getStatusColor(booking.status),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        booking.status,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: _getStatusColor(booking.status),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.calendar_today, size: 16, color: Colors.blue[700]),
                const SizedBox(width: 8),
                Text(
                  _formatDate(booking.date),
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(width: 20),
                Icon(Icons.access_time, size: 16, color: Colors.blue[700]),
                const SizedBox(width: 8),
                Text(
                  _formatTime(booking.time),
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.location_on, size: 16, color: Colors.blue[700]),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    booking.location,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${booking.price.toStringAsFixed(2)} DH',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                Row(
                  children: [
                    if (booking.status == 'Pending')
                      TextButton(
                        onPressed: () {
                          _showCancelDialog(booking);
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.red,
                        ),
                        child: const Text('Annuler'),
                      ),
                    TextButton(
                      onPressed: () {
                        _showBookingDetails(booking);
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.blue,
                      ),
                      child: const Text('Détails'),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showBookingDetails(Booking booking) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: const Text('Détails de la réservation'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetailRow('Service:', booking.service),
              _buildDetailRow('Date:', _formatDate(booking.date)),
              _buildDetailRow('Heure:', _formatTime(booking.time)),
              _buildDetailRow('Lieu:', booking.location),
              _buildDetailRow('Statut:', booking.status),
              _buildDetailRow('Prix:', '${booking.price.toStringAsFixed(2)} DH'),
              _buildDetailRow('ID:', booking.id),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Fermer'),
          ),
        ],
      ),
    );
  }

  void _showCancelDialog(Booking booking) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: const Text('Annuler la réservation'),
        content: const Text(
          'Êtes-vous sûr de vouloir annuler cette réservation?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Non'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                final index = bookings.indexWhere((b) => b.id == booking.id);
                if (index != -1) {
                  bookings[index] = Booking(
                    id: booking.id,
                    service: booking.service,
                    date: booking.date,
                    time: booking.time,
                    location: booking.location,
                    status: 'Cancelled',
                    price: booking.price,
                  );
                }
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Réservation annulée avec succès'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text(
              'Oui, annuler',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}