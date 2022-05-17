import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  String? error;
  Product({
    required this.productItems,
    required this.totalPrice,
  });

  List<ProductItem>? productItems;
  double? totalPrice;
@override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Product &&
          runtimeType == other.runtimeType &&
          totalPrice == other.totalPrice 
          ;

  @override
  int get hashCode => totalPrice.hashCode;
  factory Product.fromJson(Map<String, dynamic> json) => Product(
        productItems: json["product_items"] == null
            ? null
            : List<ProductItem>.from(
                json["product_items"].map((x) => ProductItem.fromJson(x))),
        totalPrice: 0,
      );

  Map<String, dynamic> toJson() => {
        "product_items": productItems == null
            ? null
            : List<dynamic>.from(productItems!.map((x) => x.toJson())),
      };
  Product.withError(String errorMessage) {
    error = errorMessage;
  }
}

class ProductItem {
  ProductItem({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.quantity,
  });

  int id;
  String name;
  String imageUrl;
  double price;
  int quantity;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductItem &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          id == other.id &&
          imageUrl == other.imageUrl &&
          price == other.price &&
quantity == other.quantity
          ;

  @override
  int get hashCode => name.hashCode;
  factory ProductItem.fromJson(Map<String, dynamic> json) => ProductItem(
        id: json["id"]! == null ? null : json["id"],
        name: json["name"]! == null ? null : json["name"],
        imageUrl: json["image_url"]! == null ? null : json["image_url"],
        price: json["price"]! == null ? null : json["price"],
        quantity: 1,
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "image_url": imageUrl == null ? null : imageUrl,
        "price": price == null ? null : price,
        "quantity": 1,
      };
}
