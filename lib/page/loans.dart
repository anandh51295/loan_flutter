import 'package:flutter/material.dart';

class Loans extends StatelessWidget{
  final String cid;
  Loans({Key key, @required this.cid}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Loan List',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: Llist(),
    );
  }
}
class Llist extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }

}