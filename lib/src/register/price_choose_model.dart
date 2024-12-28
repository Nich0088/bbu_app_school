class PriceChoose {
  double price;
  String namePrice;
  String namePriceKh;

  PriceChoose(
      {required this.price,
      required this.namePrice,
      required this.namePriceKh});

  factory PriceChoose.fromJson(Map<String, dynamic> json) => PriceChoose(
        price: json['price'],
        namePrice: json['name_price'],
        namePriceKh: json['name_price_kh'],
      );

  Map<String, dynamic> toJson() => {
        "price": price,
        "name_price": namePrice,
        "name_price_kh": namePriceKh,
      };
}
