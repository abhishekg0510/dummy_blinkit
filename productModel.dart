class Product {
  final int id;
  final String name;
  final int price;
  final int disPrice;
  final String imageUrl;
  final String categoryName;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.categoryName,
    required this.disPrice,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      imageUrl: json['imageUrl'],
      categoryName: json['categoryName'],
      disPrice: json['disPrice'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'price': price,
    'imageUrl': imageUrl,
    'categoryName': categoryName,
    'disPrice': disPrice,
  };
}
