class Product {
  final int id;
  final String title;
  final double price;
  final double discount;
  final String thumbnail;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.discount,
    required this.thumbnail,
  });

  double get discountedPrice => price * (1 - discount / 100);

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      price: json['price'].toDouble(),
      discount: json['discountPercentage'].toDouble(),
      thumbnail: json['thumbnail'],
    );
  }
}
