import 'package:flutter/material.dart';

class BookScreen extends StatefulWidget {
  const BookScreen({super.key});

  @override
  State<BookScreen> createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  String? selectedService;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  String? selectedLocation;

  final List<String> services = [
    'Wash Simple',
    'Wash Complet',
    'Polissage',
    'Nettoyage Intérieur',
    'Cire & Protection',
    'Lustrage des jantes'
  ];

  final List<String> locations = [
    'Avenue Mohammed V',
    'Quartier Hassan',
    'Route de Casa',
    'Centre Ville',
    'Hay Riad',
    'Agdal'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.blue[700],
        elevation: 0,
        title: const Text(
          'Réservez votre lavage',
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with blue gradient
              Container(
                height: 120,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue[700]!, Colors.blue[400]!],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.local_car_wash,
                        size: 40,
                        color: Colors.white,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Service Premium',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Service Selection
              _buildSectionTitle('Choisissez votre service'),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.blue[300]!, width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue[100]!,
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: DropdownButtonFormField<String>(
                  value: selectedService,
                  hint: const Text('Sélectionner un service'),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.cleaning_services, color: Colors.blue),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.blue[300]!),
                    ),
                  ),
                  items: services.map((service) {
                    return DropdownMenuItem(
                      value: service,
                      child: Text(service),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedService = value;
                    });
                  },
                ),
              ),
              const SizedBox(height: 20),

              // Date Selection
              _buildSectionTitle('Date de rendez-vous'),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 30)),
                    builder: (context, child) {
                      return Theme(
                        data: ThemeData.light().copyWith(
                          colorScheme: ColorScheme.light(
                            primary: Colors.blue[700]!,
                            onPrimary: Colors.white,
                            surface: Colors.grey[50]!,
                            onSurface: Colors.blue[700]!,
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );
                  if (date != null) {
                    setState(() {
                      selectedDate = date;
                    });
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.blue[300]!, width: 1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue[100]!,
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today, color: Colors.blue[700]),
                      const SizedBox(width: 12),
                      Text(
                        selectedDate != null
                            ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
                            : 'Sélectionner une date',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Time Selection
              _buildSectionTitle('Heure de rendez-vous'),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                    builder: (context, child) {
                      return Theme(
                        data: ThemeData.light().copyWith(
                          colorScheme: ColorScheme.light(
                            primary: Colors.blue[700]!,
                            onPrimary: Colors.white,
                            surface: Colors.grey[50]!,
                            onSurface: Colors.blue[700]!,
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );
                  if (time != null) {
                    setState(() {
                      selectedTime = time;
                    });
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.blue[300]!, width: 1),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.access_time, color: Colors.blue[700]),
                      const SizedBox(width: 12),
                      Text(
                        selectedTime != null
                            ? selectedTime!.format(context)
                            : 'Sélectionner une heure',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Location Selection
              _buildSectionTitle('Lieu de service'),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.blue[300]!, width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue[100]!,
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: DropdownButtonFormField<String>(
                  value: selectedLocation,
                  hint: const Text('Sélectionner un lieu'),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.location_on, color: Colors.blue),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.blue[300]!),
                    ),
                  ),
                  items: locations.map((location) {
                    return DropdownMenuItem(
                      value: location,
                      child: Text(location),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedLocation = value;
                    });
                  },
                ),
              ),
              const SizedBox(height: 32),

              // Book Button
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[700],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5,
                  ),
                  onPressed: (selectedService != null && selectedDate != null && 
                             selectedTime != null && selectedLocation != null)
                      ? () {
                          // Handle booking logic
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text('Rendez-vous réservé avec succès!'),
                              backgroundColor: Colors.blue[700],
                            ),
                          );
                        }
                      : null,
                  child: const Text(
                    'Réserver Maintenant',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.blue[700],
      ),
    );
  }
}