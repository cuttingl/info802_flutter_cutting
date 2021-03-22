class Product {
  String name;
  int weight;
  int price;
  int quantity;

  int get prodPrice {
    return price;
  }

  void set prodPrice(int amount) {
    price = amount;
  }

  String get prodName {
    return name;
  }

  void set prodName(String nameProd) {
    name = prodName;
  }

  int get prodWeight {
    return weight;
  }

  void set prodWeight(int prodWeight) {
    weight = prodWeight;
  }

  int get prodQuantity {
    return quantity;
  }

  void set prodQuantity(int prodquantity) {
    quantity = prodquantity;
  }

  Product({
    this.weight,
    this.name,
    this.price,
    this.quantity,
  });
}
