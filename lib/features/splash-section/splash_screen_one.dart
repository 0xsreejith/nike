import 'package:flutter/material.dart';
import 'package:nike/features/auth/controller/auth_controller.dart';
import 'package:nike/features/auth/views/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPager extends StatefulWidget {
  const SplashPager({super.key});

  @override
  State<SplashPager> createState() => _SplashPagerState();
}

class _SplashPagerState extends State<SplashPager> {
  final PageController _controller = PageController();
  int selectedOption = -1;

  List<String> options = ["Men's", "Women's", "Boys'", "Girls'"];
  List<String> images = [
    'https://i.pravatar.cc/100?img=1',
    'https://i.pravatar.cc/100?img=2',
    'https://i.pravatar.cc/100?img=3',
    'https://i.pravatar.cc/100?img=4',
  ];

  void nextPage() {
    _controller.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Future<void> finishSplash() async {
    await AuthController.to.setSplashSeen();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          // Splash 1
          Center(child: Text('Splash 1')), // Replace with your splash content
          // Splash 2
          Center(child: Text('Splash 2')), // Replace with your splash content
          // Splash 3
          Center(child: Text('Splash 3')), // Replace with your splash content
          // Last Splash: call finishSplash
          Center(
            child: ElevatedButton(
              onPressed: finishSplash,
              child: const Text('Finish'),
            ),
          ),
        ],
      ),
    );
  }
}

// Screen 1: Product Selection
class ProductSelectionScreen extends StatefulWidget {
  const ProductSelectionScreen({super.key});

  @override
  _ProductSelectionScreenState createState() => _ProductSelectionScreenState();
}

class _ProductSelectionScreenState extends State<ProductSelectionScreen> {
  final List<String> _products = [
    'Matrix',
    'Womens',
    'Any others?',
    'Boys',
    'Girls',
  ];
  final List<bool> _selections = [false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            'assets/nike_header.jpg', // Replace with your image path
            height: 180,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 24),
          const Text(
            'To personalize your experience and connect you to sport.',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),
          const Text(
            'Which products do you use the most?',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: List.generate(_products.length, (index) {
              return FilterChip(
                label: _products[index],
                selected: _selections[index],
                onSelected: (value) {
                  setState(() => _selections[index] = value);
                },
              );
            }),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

// Screen 2: Location Services
class LocationPermissionScreen extends StatelessWidget {
  const LocationPermissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            'assets/location_header.jpg', // Replace with your image path
            height: 180,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 24),
          const Text(
            'Want to use location Services to help you find the closest Nike Store, access in-store and location-based features, and see experiences near you?',
            style: TextStyle(fontSize: 16),
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () {}, // Handle location permission
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
            ),
            child: const Text('Enable Location Services'),
          ),
        ],
      ),
    );
  }
}

// Screen 3: App Tracking
class AppTrackingScreen extends StatelessWidget {
  const AppTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            'assets/tracking_header.jpg', // Replace with your image path
            height: 180,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 24),
          const Text(
            'Get personalised ads by enabling app tracking',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const Text(
            'Our personalized tips add on options platforms based on your app activity.',
            style: TextStyle(fontSize: 16),
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () {}, // Handle tracking permission
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
            ),
            child: const Text('Enable App Tracking'),
          ),
        ],
      ),
    );
  }
}

// Screen 4: Logistics
class LogisticsScreen extends StatelessWidget {
  const LogisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            'assets/logistics_header.jpg', // Replace with your image path
            height: 180,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 24),
          const Text(
            'On one side priority: If you select a link, sign up to their own entry line that answers this step.',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 24),
          const Text(
            'LOGISTIC TOPICS',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const Text(
            'CITIC, our permission is required to track and display on the app and in which it\'s on the website at any time there your device settings.',
            style: TextStyle(fontSize: 16),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

// Custom Chip Widget
class FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final Function(bool) onSelected;

  const FilterChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: onSelected,
      selectedColor: Colors.black,
      labelStyle: TextStyle(color: selected ? Colors.white : Colors.black),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: Colors.grey),
      ),
    );
  }
}
