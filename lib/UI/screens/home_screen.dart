import 'package:e_commerce_app/UI/screens/product_details_screen.dart';
import 'package:e_commerce_app/core/Models/get_product/get_product.dart';
import 'package:e_commerce_app/core/view_model/get_products/get_products_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetProductsBloc()..add(const GetProductsEvent.getProducts()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 171, 132, 238),
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {},
          ),
          title: const Text(
            'Ecommerce',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {},
            ),
          ],
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: BlocBuilder<GetProductsBloc, GetProductsState>(
            builder: (context, state) {
              return state.when(
                initial: () => _buildInitialUI(),
                loading: () => const Center(child: CircularProgressIndicator()),
                success: (products) => _buildProductList(products),
                failure: (error) => Center(child: Text(error)),
              );
            },
          ),
        ),
        backgroundColor: const Color(0xffffffff),
      ),
    );
  }

  Widget _buildInitialUI() {
    return const Center(
      child: Text('Welcome! Loading products...'),
    );
  }

  Widget _buildProductList(List<Product> products) {
    return ListView(
      padding: const EdgeInsets.all(10),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search products...',
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(
                  color: Colors.grey,
                  width: 1.5,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(
                  color: Colors.deepPurple,
                  width: 1.5,
                ),
              ),
              filled: true,
              fillColor: Colors.grey[200],
              contentPadding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
        CategorySection(title: "New Arrivals", products: products),
        const SizedBox(height: 20),
        CategorySection(title: "Trending Products", products: products),
      ],
    );
  }
}

class CategorySection extends StatelessWidget {
  final String title;
  final List<Product> products;

  const CategorySection({
    super.key,
    required this.title,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 250,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return ProductCard(product: product);
            },
          ),
        ),
      ],
    );
  }
}
class ProductCard extends StatelessWidget {
  final Product product;
  final String? lastViewedProductId;

  const ProductCard({super.key, required this.product, this.lastViewedProductId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (lastViewedProductId!= product.productId) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailsPage(product: {
                'id': product.productId,
                'name': product.name,
                'image': product.image,
                'price': product.price,
                'discount': product.discount,
                'rating': product.rating,
                'description': product.description,
              }),
            ),
          );
        }
      },
      child: Container(
        width: 160,
        margin: const EdgeInsets.only(right: 10),
        child: Card(
          color: const Color(0xffFFFFFF),
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: Image.network(
                    product.image ?? 'https://example.com/placeholder.jpg',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.broken_image, color: Colors.grey[300], size: 100);
                    },
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  product.name ?? 'Product Name',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  '\$${product.price}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.deepPurple,
                  ),
                ),
                Text(
                  '${product.discount}% off',
                  style: const TextStyle(fontSize: 12, color: Colors.red),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Colors.orange,
                      size: 14,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      product.rating.toString(),
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

