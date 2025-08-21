import 'package:flutter/material.dart';
import 'package:carwash/models/product.dart';
import 'package:carwash/screens/customer/shop_screen.dart';

class AdminShopScreen extends StatefulWidget {
  const AdminShopScreen({Key? key}) : super(key: key);

  @override
  _AdminShopScreenState createState() => _AdminShopScreenState();
}

class _AdminShopScreenState extends State<AdminShopScreen> {
  final List<Product> _products = [
    Product(
      id: '1',
      name: 'Car Shampoo',
      price: '12.99',
      image: 'assets/products/car_shampoo.jpg',
      description: 'Premium car shampoo for deep cleaning and shine.',
    ),
    Product(
      id: '2',
      name: 'Microfiber Towels',
      price: '8.99',
      image: 'assets/products/microfiber_towels.jpg',
      description: 'Ultra-soft microfiber towels for scratch-free cleaning.',
    ),
    Product(
      id: '3',
      name: 'Car Wax',
      price: '24.99',
      image: 'assets/products/car_wax.jpg',
      description: 'High-quality car wax for long-lasting protection.',
    ),
    Product(
      id: '4',
      name: 'Interior Cleaner',
      price: '15.99',
      image: 'assets/products/interior_cleaner.jpg',
      description: 'All-purpose interior cleaner for dashboards and upholstery.',
    ),
    Product(
      id: '5',
      name: 'Tire Shine',
      price: '9.99',
      image: 'assets/products/tire_shine.jpg',
      description: 'Professional tire shine for a glossy finish.',
    ),
    Product(
      id: '6',
      name: 'Glass Cleaner',
      price: '7.99',
      image: 'assets/products/glass_cleaner.jpg',
      description: 'Streak-free glass cleaner for crystal clear windows.',
    ),
  ];

  void _addProduct() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ShopScreen()),
    );
  }

  void _editProduct(Product product) {
    // For now, navigate to the shop screen
    // In a full implementation, this would open an edit form
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ShopScreen()),
    );
  }

  void _deleteProduct(String productId) {
    setState(() {
      _products.removeWhere((product) => product.id == productId);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Product deleted successfully')),
    );
  }

  void _showDeleteConfirmation(Product product) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Product'),
          content: Text('Are you sure you want to delete "${product.name}"?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _deleteProduct(product.id);
                Navigator.pop(context);
              },
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
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
        title: const Text('Shop Management'),
        backgroundColor: Colors.blue[800],
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addProduct,
            tooltip: 'Add New Product',
          ),
        ],
      ),
      body: _products.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.store, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'No products available',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Tap the + button to add products',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _products.length,
              itemBuilder: (context, index) {
                final product = _products[index];
                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(12),
                    leading: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.shopping_bag, color: Colors.grey),
                    ),
                    title: Text(
                      product.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(
                          product.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '\$${product.price}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => _editProduct(product),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _showDeleteConfirmation(product),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}