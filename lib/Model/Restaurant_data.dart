class Restaurant{

  String? name;
  String? category;
  String? price;
  String? ratings;
  String? url;

  Restaurant({this.name, this.category, this.price, this.ratings, this.url});

  @override
  String toString() {
    return 'Restaurant{name: $name, category: $category, price: $price, ratings: $ratings, url: $url}';
  }


  Map<String, dynamic> toMap(){
    return {
      'name': name,
      'category': category,
      'price': price,
      'ratings': ratings,
      'url': url
    };
  }
}