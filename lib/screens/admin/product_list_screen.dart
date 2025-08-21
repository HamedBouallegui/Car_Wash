import 'package:flutter/material.dart';
import 'package:carwash/models/product.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final List<Product> _products = [
    Product(id: '1', name: 'Basic Wash', price: '10.00', description: 'Exterior wash', image: 'assets/images/lavage1.jpg'),
    Product(id: '2', name: 'Deluxe Wash', price: '15.00', description: 'Exterior wash + interior vacuum', image: 'assets/images/lavage1.jpg'),
    Product(id: '3', name: 'Premium Wash', price: '20.00', description: 'Exterior wash + interior vacuum + tire shine', image: 'assets/images/lavage1.jpg'),
  ];

  void _addProduct(Product newProduct) {
    setState(() {
      _products.add(newProduct);
    });
  }

  void _editProduct(int index, Product updatedProduct) {
    setState(() {
      _products[index] = updatedProduct;
    });
  }

  void _deleteProduct(int index) {
    setState(() {
      _products.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Management'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _showProductForm(context);
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _products.length,
        itemBuilder: (context, index) {
          final product = _products[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(product.name),
              subtitle: Text('\$${product.price} - ${product.description}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      _showProductForm(context, product: product, index: index);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      _deleteProduct(index);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showProductForm(BuildContext context, {Product? product, int? index}) {
    final TextEditingController nameController = TextEditingController(text: product?.name);
    final TextEditingController priceController = TextEditingController(text: product?.price);
    final TextEditingController descriptionController = TextEditingController(text: product?.description);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(product == null ? 'Add Product' : 'Edit Product'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Product Name'),
              ),
              TextField(
                controller: priceController,
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final newName = nameController.text;
                final newPrice = priceController.text;
                final newDescription = descriptionController.text;

                if (newName.isNotEmpty && newPrice.isNotEmpty && newDescription.isNotEmpty) {
                  final newProduct = Product(
                    id: product?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
                    name: newName,
                    price: newPrice,
                    description: newDescription,
                    image: product?.image ?? 'assets/images/lavage1.jpg', // Default image for new products
                  );
                  if (product == null) {
                    _addProduct(newProduct);
                  } else {
                    _editProduct(index!, newProduct);
                  }
                  Navigator.of(context).pop();
                }
              },
              child: Text(product == null ? 'Add' : 'Save'),
            ),
          ],
        );
      },
    );
  }
}