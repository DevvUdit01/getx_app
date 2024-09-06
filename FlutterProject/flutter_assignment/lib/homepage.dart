import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:badges/badges.dart' as badges;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _pageController = PageController(viewportFraction: 0.9);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Column(
        children: [
          buildTabBar(),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                buildBanner(),
                const SizedBox(height: 5),
                buildSectionTitle('New Arrival'),
                buildProductList(),
                const SizedBox(height: 15),
                buildSectionTitle('Recommendation'),
                buildProductList(),
                const SizedBox(height: 15),
                buildSectionTitle('Popular Jacket'),
                buildProductList(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search, color: Colors.black),
                hintText: 'Search or enter URL',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
          ),
          const SizedBox(width: 10),
          buildIcon(Icons.notifications_none_rounded, badgeCount: 3),
          buildIcon(Icons.shopping_bag_outlined, badgeCount: 5),
        ],
      ),
    );
  }

  

Widget buildIcon(IconData icon, {int badgeCount = 0}) {
  return 
     Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.black, width: 0.2),
      ),
      child: badges.Badge(
    position: badges.BadgePosition.topEnd(top: 4, end: 8),
    badgeContent:Text(
            '$badgeCount',
            style: const TextStyle(color: Colors.white, fontSize: 10),
          ),
      child: IconButton(
        icon: Icon(icon, color: Colors.black),
        onPressed: () {},
      ),
  ),
     );
}

  Widget buildTabBar() {
    return TabBar(
      controller: _tabController,
      labelColor: Colors.black,
      isScrollable: false,
      indicatorColor: Colors.black,
      tabs: const [
        Tab(text: 'Jacket'),
        Tab(text: 'Pants'),
        Tab(text: 'Shoes'),
        Tab(text: 'Dress'),
        Tab(text: 'Accessories'),
      ],
    );
  }


  Widget buildBanner() {
    return Column(
      children: [
        SizedBox(
          height: 180,
          child: PageView.builder(
            controller: _pageController,
            itemCount: 5, 
            itemBuilder: (context, index) {
              return buildSingleBanner();
            },
          ),
        ),
        const SizedBox(height: 8),
        SmoothPageIndicator(
          controller: _pageController,
          count: 5,
          effect: const ExpandingDotsEffect(
            dotHeight: 8,
            dotWidth: 8,
            activeDotColor: Colors.black,
            dotColor: Colors.grey,
          ),
        ),
      ],
    );
  }

  
  Widget buildSingleBanner() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: const DecorationImage(
          image: NetworkImage(
              "https://www.shutterstock.com/image-photo/young-stylish-multiethnic-couple-black-260nw-2206657801.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text(
              'New Season Essentials',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            const Text(
              'Discount up to 50%',
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                "Get it now",
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  
  Widget buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Text(
            'See All',
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }

  Widget buildProductList() {
    return SizedBox(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 4, 
        itemBuilder: (context, index) {
          return buildProductCard();
        },
      ),
    );
  }


Widget buildProductCard() {
  return Container(
    height: 310,
    width: MediaQuery.of(context).size.width * 0.42,
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey, width: 1),
      borderRadius: BorderRadius.circular(20),
    ),
    margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
    clipBehavior: Clip.hardEdge, // Ensure borderRadius applies to children
    child: Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.1888, // Adjusted height for image
              width: double.infinity, // Ensure the image takes full width of container
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                image: DecorationImage(
                  image: NetworkImage('https://m.media-amazon.com/images/I/319BiERxPcL._SL500_.jpg'),
                  fit: BoxFit.cover, // Ensure the image fits properly
                ),
              ),
            ),
            const Divider(),
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Seamless Down Parka',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'IDR 300.000',
                    style: TextStyle(
                      decoration: TextDecoration.lineThrough,
                      fontSize: 14,
                      color: Colors.red,
                    ),
                  ),
                  Text(
                    'IDR 240.000',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 6,
          right: 6,
          child: IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () {
              // Your onPressed logic
            },
          ),
        ),
      ],
    ),
  );
}


  
  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: 'Wishlist'),
        BottomNavigationBarItem(icon: Icon(Icons.category_outlined), label: 'Category'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
    );
  }
}
