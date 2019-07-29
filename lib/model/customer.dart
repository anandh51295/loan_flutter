import 'dart:convert';

Customer customerFromJson(String str) {
  final jsonData = json.decode(str);
  return Customer.fromMap(jsonData);
}

String customerToJson(Customer data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Customer {
  int id;
  String customerId;
  String customerName;
  String dob;

  Customer({
    this.id,
    this.customerId,
    this.customerName,
    this.dob,
  });

  factory Customer.fromMap(Map<String, dynamic> json) => new Customer(
    id: json["id"],
    customerId: json["customerid"],
    customerName: json["cutomername"],
    dob: json["dob"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "customerid": customerId,
    "customername": customerName,
    "dob": dob,
  };
}