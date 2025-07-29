import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Image.asset('assets/logos.png', height: 50),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.shopping_bag_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Good Morning Sreejith',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            _buildSectionHeader('Top Picks for You', 'Recommended products'),
            const SizedBox(height: 16),
            SizedBox(
              height: 260,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  ProductCard(
                    name: 'Air Jordan 1 Low',
                    description: "Women's Shoes",
                    price: '₹8,295.00',
                    imageUrl: 'assets/shoe1.png',
                  ),
                  SizedBox(width: 16),
                  ProductCard(
                    name: 'Nike SB Dunk',
                    description: "Men's Shoes",
                    price: '₹23,795.00',
                    imageUrl: 'assets/shoe2.png',
                  ),
                  SizedBox(width: 16),
                  ProductCard(
                    name: 'Nike SB Dunk',
                    description: "Men's Shoes",
                    price: '₹23,795.00',
                    imageUrl: 'assets/shoe1.png',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            _buildSectionHeader('New From Nike', 'View All'),
            const SizedBox(height: 16),
            SizedBox(
              height: 400,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: newFromNike.length,
                itemBuilder: (context, index) {
                  final product = newFromNike[index];
                  return _NewNikeCard(product: product);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, String subtitle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text(subtitle, style: const TextStyle(fontSize: 14, color: Colors.grey)),
          ],
        ),
        TextButton(
          onPressed: () {},
          child: const Text('View All',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        ),
      ],
    );
  }
}

class ProductCard extends StatelessWidget {
  final String name;
  final String description;
  final String price;
  final String imageUrl;

  const ProductCard({
    super.key,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product image
          Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              image: DecorationImage(
                image: AssetImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
                const SizedBox(height: 8),
                Text(
                  'MRP: $price',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NewNikeCard extends StatelessWidget {
  final _Product product;

  const _NewNikeCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, spreadRadius: 1),
        ],
      ),
      child: Column(
        children: [
          SizedBox(
            height: 300,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                  child: Image.network(
                    product.imageUrl,
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,
                  ),
                ),
                const Positioned(
                  top: 6,
                  right: 6,
                  child: Icon(Icons.favorite_border, color: Colors.white, size: 28),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(product.title,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis),
              const SizedBox(height: 4),
              Text(product.subtitle,
                  style: const TextStyle(fontSize: 14, color: Colors.black54)),
              const SizedBox(height: 6),
              Text('MRP: ${product.price}',
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            ]),
          ),
        ],
      ),
    );
  }
}

class _Product {
  final String imageUrl, title, subtitle, price;
  const _Product(this.imageUrl, this.title, this.subtitle, this.price);
}

const List<_Product> newFromNike = [
  _Product(
    'https://cdn.sanity.io/images/c1chvb1i/production/a0479c253b26a9fec066b696305577ab9836f48a-1100x735.jpg?w=1760&h=1176&q=75&fit=max&auto=format',
    'New Nike 1',
    "Men's Shoes",
    '₹ 9,999.00',
  ),
  _Product(
    'https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/99486859-0ff3-46b4-949b-2d16af2ad421/custom-nike-dunk-high-by-you-shoes.png',
    'New Nike 2',
    "Women's Shoes",
    '₹ 14,295.00',
  ),
  _Product(
    'https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/99486859-0ff3-46b4-949b-2d16af2ad421/custom-nike-dunk-high-by-you-shoes.png',
    'New Nike 3',
    "Men’s Shoes",
    '₹ 19,395.00',
  ),
];
