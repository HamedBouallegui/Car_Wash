import 'package:flutter/material.dart';
import 'package:carwash/models/product.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  final Map<Product, int> _cartItems = {};

  void _addToCart(Product product) {
    setState(() {
      _cartItems.update(product, (value) => value + 1, ifAbsent: () => 1);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product.name} added to cart! Quantity: ${_cartItems[product]}'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _showCart() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Your Cart'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _cartItems.length,
              itemBuilder: (context, index) {
                final product = _cartItems.keys.elementAt(index);
                final quantity = _cartItems[product];
                return ListTile(
                  leading: Image.asset(product.image, width: 40, height: 40, fit: BoxFit.cover),
                  title: Text('${product.name} x$quantity'),
                  subtitle: Text('\$${(double.parse(product.price) * quantity!).toStringAsFixed(2)}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          setState(() {
                            if (quantity > 1) {
                              _cartItems.update(product, (value) => value - 1);
                            } else {
                              _cartItems.remove(product);
                            }
                          });
                          Navigator.of(context).pop(); // Close current dialog
                          _showCart(); // Re-open dialog to reflect changes
                        },
                      ),
                      Text('$quantity'),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            _cartItems.update(product, (value) => value + 1);
                          });
                          Navigator.of(context).pop(); // Close current dialog
                          _showCart(); // Re-open dialog to reflect changes
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Total: \$${_cartItems.entries.fold(0.0, (sum, entry) => sum + (double.parse(entry.key.price) * entry.value)).toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close cart dialog
                _showPaymentOptions();
              },
              child: const Text('Proceed to Payment'),
            ),
          ],
        );
      },
    );
  }

  void _showPaymentOptions() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Choose Payment Method'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.money),
                title: const Text('Cash on Delivery'),
                onTap: () {
                  Navigator.of(context).pop();
                  _simulatePayment('Cash on Delivery');
                },
              ),
              ListTile(
                leading: const Icon(Icons.paypal),
                title: const Text('PayPal'),
                onTap: () {
                  Navigator.of(context).pop();
                  _simulatePayment('PayPal');
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _simulatePayment(String paymentMethod) {
    double total = _cartItems.entries.fold(0.0, (sum, entry) => sum + (double.parse(entry.key.price) * entry.value));
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Payment Confirmation'),
          content: Text('Total amount: \$${total.toStringAsFixed(2)}\n\nPayment Method: $paymentMethod\n\nSimulating payment...\n\nPayment successful!'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                setState(() {
                  _cartItems.clear(); // Clear cart after simulated payment
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Car Care Shop'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: _showCart,
          ),
        ],
        backgroundColor: Colors.blue[700],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Featured Products',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              _buildProductGrid(),
              const SizedBox(height: 24),
              const Text(
                'Categories',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              _buildCategories(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductGrid() {
    final products = [
      Product(id: '1', name: 'Premium Car Shampoo', description: 'A high-quality car shampoo for a spotless finish.', price: '24.99', image: 'assets/images/images.jpg'),
      Product(id: '2', name: 'Microfiber Towels Set', description: 'Ultra-soft and absorbent towels for streak-free drying.', price: '19.99', image: 'assets/images/images1.jpg'),
      Product(id: '3', name: 'Wheel Cleaner', description: 'Effective cleaner for removing brake dust and grime from wheels.', price: '15.99', image: 'assets/images/images2.jpg'),
      Product(id: '4', name: 'Car Wax', description: 'Provides a brilliant shine and long-lasting protection for your car\'s paint.', price: '29.99', image: 'assets/images/images3.jpg'),
      Product(id: '5', name: 'Tire Shine', description: 'Gives tires a deep, rich, and long-lasting shine.', price: '12.99', image: 'assets/images/images4.jpg'),
      Product(id: '6', name: 'Interior Cleaner', description: 'All-purpose cleaner for car interiors, safe on all surfaces.', price: '17.99', image: 'assets/images/images5.jpg'),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.8,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Check if the image is a local asset path
                Image.asset(
                  product.image,
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 8),
                Text(
                  product.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  '\$${product.price}',
                  style: TextStyle(
                    color: Colors.blue[700],
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    _addToCart(product);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[700],
                    minimumSize: const Size(double.infinity, 32),
                  ),
                  child: const Text('Add to Cart'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCategories() {
    final categories = [
      {'name': 'Cleaning', 'icon': '🧽'},
      {'name': 'Tools', 'icon': '🔧'},
      {'name': 'Accessories', 'icon': '🎨'},
      {'name': 'Interior', 'icon': '🪑'},
    ];

    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return Container(
            width: 80,
            margin: const EdgeInsets.only(right: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Text(
                      category['icon']!,
                      style: const TextStyle(fontSize: 30),
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  category['name']!,
                  style: const TextStyle(fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}