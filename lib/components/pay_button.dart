import 'package:flutter/material.dart';
import '../models/payment_result.dart';
import '../blocs/payment_bloc.dart';
import './dialog_box.dart';

class PayButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final PaymentBloc paymentBloc = PaymentBloc(environment: 'test');
    return RaisedButton(
      onPressed: () async {
        PaymentResult paymentResult = await paymentBloc.makePayemnt(paymentType: 'custom');
        print('paymentResult = $paymentResult');
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
      },
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
        child: const Text(
          'Pay Now!',
          style: TextStyle(fontSize: 20)
        ),
      ),
    );
  }

}
