import 'package:dummy_blinkit/productModel.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

  class _MyAppState extends State<MyApp> {
  bool isDarkMode = false;

  void toggleTheme() {
  setState(() {
  isDarkMode = !isDarkMode;
  });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.lightGreen.shade50, brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.lightGreen.shade50, brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: MyHomePage(title: 'Blinkit',
        toggleTheme: toggleTheme,
        isDarkMode: isDarkMode,
      ),
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title,required this.toggleTheme, required this.isDarkMode,});
  final String title;
  final VoidCallback toggleTheme;
  final bool isDarkMode;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    super.initState();
    searchList = productList;
    }

  List<Product> productList = [
    Product(
      id: 1,
      name: 'Fresh Apples',
      price: 120,
      disPrice: 0,
      imageUrl: 'https://images.pexels.com/photos/102104/pexels-photo-102104.jpeg?auto=compress&cs=tinysrgb&w=600',
      categoryName: 'Fruits',
    ),
    Product(
      id: 2,
      name: 'Full Cream Milk',
      price: 55,
      disPrice: 40,
      imageUrl: 'https://images.pexels.com/photos/248412/pexels-photo-248412.jpeg?auto=compress&cs=tinysrgb&w=600',
      categoryName: 'Dairy',
    ),
    Product(
      id: 3,
      name: 'Organic Tomatoes',
      price: 80,
      disPrice: 70,
      imageUrl: 'https://images.pexels.com/photos/1391487/pexels-photo-1391487.jpeg?auto=compress&cs=tinysrgb&w=600',
      categoryName: 'Vegetables',
    ),
    Product(
      id: 4,
      name: 'Brown Bread',
      price: 45,
      disPrice: 0,
      imageUrl: 'https://images.pexels.com/photos/31765633/pexels-photo-31765633/free-photo-of-rustic-whole-grain-bread-on-wooden-board.jpeg?auto=compress&cs=tinysrgb&w=600',
      categoryName: 'Bakery',
    ),
    Product(
      id: 5,
      name: 'Paneer 200g',
      price: 90,
      disPrice: 65,
      imageUrl: 'https://images.pexels.com/photos/773253/pexels-photo-773253.jpeg?auto=compress&cs=tinysrgb&w=600',
      categoryName: 'Dairy',
    ),
    Product(
      id: 6,
      name: 'Bananas',
      price: 30,
      disPrice: 20,
      imageUrl: 'https://images.pexels.com/photos/1093038/pexels-photo-1093038.jpeg?auto=compress&cs=tinysrgb&w=600',
      categoryName: 'Fruits',
    ),

  ];
  List<Product> searchList = [];
  String emptyMassage = 'No product Found';
  TextEditingController _searchController = TextEditingController();
  List<String> categoryList =['Fruits', 'Dairy', 'Bakery', 'Vegetables'];

  void searchProducts(String item){
    searchList = [];
    for(Product product in productList){
      if(product.name.toLowerCase().contains(item.toLowerCase())){
        searchList.add(product);
      }
    }
    if(productList.isNotEmpty && searchList.isEmpty){
      emptyMassage = "Not found, Try search different";
    }
  }

  String? selectedCategory;

  void openFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Select Category', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  filterChip('All'),
                  filterChip('Fruits'),
                  filterChip('Dairy'),
                  filterChip('Vegetables'),
                  filterChip('Bakery'),
                ],
              ),
            ],
          ),
        );
      },
    );
  }


  Widget filterChip(String category) {
    return ChoiceChip(
      label: Text(category),
      selected: selectedCategory == category || (category == 'All' && selectedCategory == null),
      onSelected: (bool selected) {
        selectedCategory = category == 'All' ? null : category;
          if(category != 'All'){
            searchList = [];
            for(Product product in productList){
              if(product.categoryName == selectedCategory){
                searchList.add(product);
              }
            }
          }
          else{
            searchList = productList;
          }
          setState(() {});
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: GestureDetector(
        onTap: (){
      FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                SizedBox(height: 4,),
                SizedBox(
                  height: 40,
                  child: TextField(
                    onChanged: (value) {
                      searchProducts(value);
                      setState(() {});
                    },
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      hintStyle: const TextStyle(color: Colors.white70),
                      fillColor: Colors.white24,
                      filled: true,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: IconButton(
                          onPressed: (){
                            searchList = productList;
                            _searchController.clear();
                            FocusScope.of(context).unfocus();
                            setState(() {});
                          },
                          icon: Icon(Icons.close, size: 20,))
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            centerTitle: true,
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    InkWell(
                      onTap: (){
                        openFilterBottomSheet();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white, // background color
                          borderRadius: BorderRadius.circular(20), // roundness here
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.filter_list_off_rounded, size: 15,color: Colors.lightGreen,),
                            Text(
                              selectedCategory == null || selectedCategory == 'All' ? "Filter" : selectedCategory.toString(),
                              style: TextStyle(color: Colors.lightGreen), // optional: text color
                            ),
                          ],
                        ),
                      ),
                    ),
                    Switch(
                      value: widget.isDarkMode,
                      onChanged: (value) {
                        widget.toggleTheme();
                      },
                    )
                  ],
                ),
              ),
            ],
            bottom: TabBar(
                indicatorColor: Colors.white,
                tabs: [
                  Tab(child: Text("All Products")),
                  Tab(child: Text("Favourite products"))
                ]),
          ),
          body: TabBarView(
            children: <Widget>[
              searchList.isEmpty
                  ? Center(child: Text(emptyMassage))
                  :
        GridView.builder(
        shrinkWrap: true,  // important if inside a scrollable
        physics: const NeverScrollableScrollPhysics(), // disable GridView's own scrolling
        padding: const EdgeInsets.all(8),
        itemCount: searchList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // 3 products per row
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio: 0.6, // adjust height/width ratio
        ),
        itemBuilder: (context, index) {
          final product = searchList[index];
          return Card(
            child: Column(
              children: [
                Expanded(
                  flex: 6,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                    child: Image.network(
                      product.imageUrl,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: List.generate(
                            5,
                                (index) => Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 16,
                            ),
                          ),
                        ),
                        if(product.disPrice != 0)
                    Text(
                  "${product.price}% OFF",
                    style: const TextStyle(color: Colors.blue, fontSize: 10),
                  )
                            ,
                        Text(
                          "₹${product.price}",
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
            ),
              GridView.builder(
                shrinkWrap: true,  // important if inside a scrollable
                physics: const NeverScrollableScrollPhysics(), // disable GridView's own scrolling
                padding: const EdgeInsets.all(8),
                itemCount: searchList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // 3 products per row
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 0.6, // adjust height/width ratio
                ),
                itemBuilder: (context, index) {
                  final product = searchList[index];
                  return Card(
                    child: Column(
                      children: [
                        Expanded(
                          flex: 6,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                            child: Image.network(
                              product.imageUrl,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.name,
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: List.generate(
                                    5,
                                        (index) => Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 16,
                                    ),
                                  ),
                                ),
                                if(product.disPrice != 0)
                                  Text(
                                    "${product.price}% OFF",
                                    style: const TextStyle(color: Colors.blue, fontSize: 10),
                                  )
                                ,
                                Text(
                                  "₹${product.price}",
                                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
