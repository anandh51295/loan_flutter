import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loan_app/support/database.dart';
import 'package:loan_app/model/customer.dart';
class AddCust extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Add Customer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: AddForm(),
    );
  }
}

class AddForm extends StatefulWidget {
  @override
  _AddFormState createState() => _AddFormState();
}

class _AddFormState extends State<AddForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  int lyear = DateTime.now().year;
  int lmonth = DateTime.now().month;
  var txt = TextEditingController();
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1947, 8),
        lastDate: DateTime(lyear,lmonth+1));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        final dateFormatter = DateFormat('yyyy-MM-dd');
        final dateString = dateFormatter.format(selectedDate);
        txt.text = dateString.toString();
      });
  }

  @override
  Widget build(BuildContext context) {
    var mid, mname, mdob;
    return Scaffold(
        appBar: new AppBar(
          title: Text('Add Customer'),
        ),
        body: Padding(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Customer ID',
                    ),
                    keyboardType: TextInputType.number,
                    validator: (String value) {
                      if (value.trim().isEmpty) {
                        return 'Enter Customer ID';
                      }
                      else if (value.length > 8) {
                        return 'Enter 8 digit number';
                      }
                      else{
                        mid=value;
                      }
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Customer Name',
                    ),
                    validator: (String value) {
                      if (value.trim().isEmpty) {
                        return 'Enter Customer Name';
                      }else{
                        mname=value;
                      }
                    },
                  ),
                  const SizedBox(height: 16.0),
                  InkWell(
                    onTap: () {
                      _selectDate(context);
                    },
                    child: IgnorePointer(
                      child: new TextFormField(
                        controller: txt,

                        decoration: new InputDecoration(hintText: 'DOB'),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Please Select DOB';
                          }else{

                            final dateFormatter = DateFormat('yyyy-MM-dd');
                            final dateString = dateFormatter.format(selectedDate);
                            mdob=dateString.toString();
                          }
                        },
                        onSaved: (String val) {},
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    children: <Widget>[
                      const Spacer(),
                      OutlineButton(
                        highlightedBorderColor: Colors.black,
                          onPressed: () async {

                            if (_formKey.currentState.validate()) {
                              // If the form is valid, we want to show a Snackbar

                              Customer testCustomer =
                              Customer(customerId: mid, customerName: mname, dob: mdob);
                              await DBProvider.db.newCustomer(testCustomer);
//                              Scaffold.of(context).showSnackBar(SnackBar(
//                                  content: Text('Customer Inserted Successfully...!')));
                              Navigator.pop(context);
                            }
                          },
                        child: const Text('Submit'),
                      ),
                    ],
                  ),
                ],
              ),
            )));
  }
}
