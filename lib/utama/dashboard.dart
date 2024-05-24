import 'package:flutter/material.dart';
import 'favorite_page.dart';
import 'profile_page.dart';

void main() {
  runApp(DashboardApp());
}

class DashboardApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DashboardPage(),
    );
  }
}

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _currentIndex = 0; // Variabel untuk melacak tab yang dipilih

  final List<Widget> _pages = [
    DashboardPageContent(), // Konten halaman dashboard utama
    FavoritePage(), // Halaman favorit
    ProfilePage(), // Halaman profil
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Tangani aksi pencarian
            },
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              // Tangani aksi keranjang belanja
            },
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          // Tampilan latar belakang
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/ground.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Konten halaman
          _pages[_currentIndex],
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex, // Tentukan tab yang dipilih
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Perbarui tab yang dipilih
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class DashboardPageContent extends StatefulWidget {
  @override
  _DashboardPageContentState createState() => _DashboardPageContentState();
}

class _DashboardPageContentState extends State<DashboardPageContent> {
  final List<bool> _isFavoriteList = List.filled(6, false);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildCategories(),
          _buildPopularProducts(),
        ],
      ),
    );
  }

  Widget _buildCategories() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Categories',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildCategoryButton(Icons.bakery_dining, 'Roti'),
              _buildCategoryButton(Icons.cake, 'Kue'),
              _buildCategoryButton(Icons.donut_small, 'Donat'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryButton(IconData icon, String title) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            // Tangani penekanan tombol kategori
            print('Pressed $title');
          },
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            padding: EdgeInsets.all(20),
            backgroundColor: Colors.blue.shade100, // <-- Warna tombol
            foregroundColor: Colors.blue, // <-- Warna splash
          ),
          child: Icon(
            icon,
            size: 30,
            color: Colors.blue,
          ),
        ),
        SizedBox(height: 5),
        Text(title),
      ],
    );
  }

  Widget _buildPopularProducts() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Popular Products',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: List.generate(6, (index) {
              return _buildProductItem(
                'Roti Item $index',
                50.0 + index * 10,
                _isFavoriteList[index],
                index,
                'assets/roti${index + 1}.jpg',
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildProductItem(
      String title, double price, bool isFavorite, int index, String imageUrl) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Center(
              child: Image.asset(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
                Text('\$$price', style: TextStyle(color: Colors.red)),
                Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _isFavoriteList[index] = !_isFavoriteList[index];
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
