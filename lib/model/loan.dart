import 'dart:convert';

Loan LoanFromJson(String str) {
  final jsonData = json.decode(str);
  return Loan.fromMap(jsonData);
}

String LoanToJson(Loan data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Loan {
  int id;
  int customerid;
  int accountid;
  double amount;
  String date;

  Loan({
    this.id,
    this.customerid,
    this.accountid,
    this.amount,
    this.date
  });

  factory Loan.fromMap(Map<String, dynamic> json) => new Loan(
    id: json["id"],
    customerid: json["customerid"],
    accountid: json["accountid"],
    amount: json["amount"],
    date: json["date"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "customerid": customerid,
    "accountid": accountid,
    "amount": amount,
    "date": date,
  };
}