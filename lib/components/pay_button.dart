import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/payment_result.dart';
// import '../blocs/google_pay_bloc.dart';
import '../blocs/apple_pay_bloc.dart';
import 'dialog_box.dart';

class PayButton extends StatelessWidget {

  final String title;

  PayButton(this.title);

  // dynamic _makePayment(BuildContext context, GooglePayBloc googlePayBloc) async {
  dynamic _makePayment(BuildContext context, ApplePayBloc applePayBloc) async {
    // PaymentResult paymentResult = await googlePayBloc.makePayment(paymentType: 'custom');
    PaymentResult paymentResult = await applePayBloc.makePayment();

    return DialogBox().show(
      context: context,
      title: paymentResult.title,
      content: Text(paymentResult.text),
      actions: <Widget>[
        FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Close'),
        )
      ]
    );
  }

  @override
  Widget build(BuildContext context) {
    // final GooglePayBloc googlePayBloc = Provider.of<GooglePayBloc>(context);
    final ApplePayBloc applePayBloc = Provider.of<ApplePayBloc>(context);
    return RaisedButton(
      // onPressed: () => _makePayment(context, googlePayBloc),
      onPressed: () => _makePayment(context, applePayBloc),
      textColor: Colors.white,
      padding: const EdgeInsets.all(0.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              Color(0xFF0D47A1),
              Color(0xFF1976D2),
              Color(0xFF42A5F5),
            ],
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 30.0,
          vertical: 10.0,
        ),
        child: Text(
          title,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }

}
