import 'package:assignment_myapp/common/loader.dart';
import 'package:assignment_myapp/common/search_product.dart';
import 'package:assignment_myapp/models/products.dart';
import 'package:assignment_myapp/screens/audioplayer_screen.dart';
import 'package:assignment_myapp/screens/form_screen.dart';
import 'package:assignment_myapp/screens/productdetail_screen.dart';
import 'package:assignment_myapp/services/product_service.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Product>? products;

  final ProductService productService = ProductService();

  @override
  void initState() {
    super.initState();
    getAllProduct();
  }

  getAllProduct() async {
    products = await productService.fetchProducts();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(
          'Product',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FormScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.music_note),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AudioPlayerScreen()),
              );
            },
          ),
        ],
      ),
      body: products == null
          ? const Loader()
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: products!.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailScreen(
                          product: products![index],
                        ),
                      ),
                    );
                  },
                  child: SearchedProduct(
                    product: products![index],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
