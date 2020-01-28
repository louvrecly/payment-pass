import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import '../models/payment_result.dart';
import '../blocs/payment_bloc.dart';
import '../blocs/google_pay_bloc.dart';
import '../blocs/apple_pay_bloc.dart';
import 'dialog_box.dart';

class PayButton extends StatelessWidget {

  dynamic _makePayment(BuildContext context, PaymentBloc paymentBloc) async {
    PaymentResult paymentResult = await paymentBloc.makePayment();

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
    final platform = Theme.of(context).platform;
    String paymentType;
    PaymentBloc paymentBloc;

    switch(platform) {
      case TargetPlatform.iOS:
        paymentType = 'Apple';
        paymentBloc = Provider.of<ApplePayBloc>(context);
        break;
      case TargetPlatform.android:
        paymentType = 'Google';
        paymentBloc = Provider.of<GooglePayBloc>(context);
        break;
      default:
        paymentType = 'Unsupported';
        paymentBloc = null;
    }

    return RaisedButton(
      onPressed: paymentBloc == null ? null : () => _makePayment(context, paymentBloc),
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
          '$paymentType Pay',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }

}
