class CCard {
  CCard({
    this.cardNumber,
    this.name,
    this.month,
    this.year,
    this.cvv2,
    this.id,
  });

  String? cardNumber;
  String? name;
  String? month;
  String? year;
  String? cvv2;
  String? id;

  factory CCard.fromJson(Map<String, dynamic> json) => CCard(
    cardNumber: json["card_number"],
    name: json["name"],
    month: json["month"],
    year: json["year"],
    cvv2: json["cvv2"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "card_number": cardNumber,
    "name": name,
    "month": month,
    "year": year,
    "cvv2": cvv2,
    "id": id,
  };
}