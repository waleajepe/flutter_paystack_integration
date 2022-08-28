class Product {
  Product(
      { required this.name, required this.shop, required this.image, required this.price});

  String name;
  String shop;
  String image;
  String price;
}

List<Product> products = [
  Product(
      name: 'HP Laptop',
      shop: 'PTamo',
      image: 'assets/images/product1.jpg',
      price: '85'),
  Product(
      name: 'Lenovo Laptop',
      shop: 'Beta Jin',
      image: 'assets/images/product2.jpg',
      price: '92'),
];