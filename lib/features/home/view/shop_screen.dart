import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShopPageMock extends StatefulWidget {
  const ShopPageMock({Key? key}) : super(key: key);

  @override
  State<ShopPageMock> createState() => _ShopPageMockState();
}

class _ShopPageMockState extends State<ShopPageMock> {
  int _currentIndex = 1;
  String selectedTab = 'Men';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
 
            AppBar(
              toolbarHeight: 60,
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              leadingWidth: 84,
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipOval(
                  child: Container(
               
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    child: Image.asset(
                      'assets/logos.png',
                      height: 50,
                      width: 50,
                    ),
                  ),
                ),
              ),
              title: const SizedBox(),
              actions: const [
                Padding(
                  padding: EdgeInsets.only(right: 16.0),
                  child: Icon(Icons.search, color: Colors.black),
                ),
              ],
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              _buildLogoRow(),
              const SizedBox(height: 16),
              _buildTabs(),
              const SizedBox(height: 16),
              Text(
                "This Week’s Highlights",
                style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              _buildHighlights(),
              const SizedBox(height: 16),
              _buildBanner('assets/drop1.png'),
              const SizedBox(height: 8),
              _buildBanner('assets/drop2.png'),
            ],
          ),
        ),
      ),
   
    );
  }

  Widget _buildLogoRow() {
    return Row(
      children: [
        
        
        Text("Shop", style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600)),
      ],
    );
  }

  Widget _buildTabs() {
    final tabs = ['Men', 'Women', 'Kids'];
    return Row(
      children: tabs.map((t) {
        final selected = t == selectedTab;
        return GestureDetector(
          onTap: () => setState(() => selectedTab = t),
          child: Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Text(
              t,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                color: selected ? Colors.black : Colors.black54,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

 Widget _buildHighlights() {
  return SizedBox(
    height: 350, // enough height to show two rows of cards
    child: GridView.count(
      crossAxisCount: 3,         // three cards per row
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      childAspectRatio: 0.8,     // same height/width ratio as before
      children: highlightItems.map(_highlightCard).toList(),
    ),
  );
}


 Widget _highlightCard(_Highlight h) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(8),
    child: SizedBox(
      height: 260, // increased height
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(h.imageUrl, fit: BoxFit.cover),
          Container(color: Colors.black26),
          Positioned(
            bottom: 8,
            left: 8,
            right: 8,
            child: Text(
              h.label,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}


  Widget _buildBanner(String imageUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.asset(
        imageUrl,
        width: double.infinity,
        height: 120,
        fit: BoxFit.cover,
      ),
    );
  }

 
}

class _Highlight {
  final String imageUrl, label;
  const _Highlight(this.imageUrl, this.label);
}

const highlightItems = [
  _Highlight('assets/new.png', 'New Arrivals'),
  _Highlight('assets/just.png', 'Just Dropped: Alphafly 3'),
  _Highlight('assets/peg.png', 'Nike Pegasus premium'),
  _Highlight('assets/air.png', 'Air Force 1'),
  _Highlight('assets/tennis.png', 'Tennis'),
  _Highlight('assets/shop.png', 'Shop All'),
];