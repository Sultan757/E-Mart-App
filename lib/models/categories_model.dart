// To parse this JSON data, do
//
//     final productCategories = productCategoriesFromJson(jsonString);

import 'dart:convert';

ProductCategories productCategoriesFromJson(String str) =>
    ProductCategories.fromJson(json.decode(str));

class ProductCategories {
  ProductCategories({
    required this.categories,
  });

  List<Category> categories;

  factory ProductCategories.fromJson(Map<String, dynamic> json) =>
      ProductCategories(
        categories: json["categories"] == null
            ? []
            : List<Category>.from(
                json["categories"]!.map((x) => Category.fromJson(x))),
      );
}

class Category {
  Category({
    required this.name,
    required this.subcategories,
  });

  String name;
  List<String> subcategories;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        name: json["name"],
        subcategories: List<String>.from(json["subcategories"].map((x) => x)),
      );
}
