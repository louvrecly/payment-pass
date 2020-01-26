import 'package:flutter/material.dart';
import 'package:flutter_google_pay/flutter_google_pay.dart';
import './dialog_box.dart';

class PayButton extends StatelessWidget {

  final String environment;

  PayButton({ this.environment = 'test' });

  dynamic _makePayment({ BuildContext context, String paymentType = 'stripe' }) async {
    if (!(await FlutterGooglePay.isAvailable(environment))) {
      return DialogBox().show(
        context: context,
        title: 'Sorry',
        content: Text(
          'Google Pay not available!'
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          )
        ],
      );
    } else {
      if (paymentType == 'stripe') {
        // Stripe Payment
        PaymentItem pm = PaymentItem(
            stripeToken: 'pk_test_1IV5H8NyhgGYOeK6vYV3Qw8f',
            stripeVersion: "2018-11-08",
            currencyCode: "usd",
            amount: "0.10",
            gateway: 'stripe');

        FlutterGooglePay.makePayment(pm).then((Result result) {
          if (result.status == ResultStatus.SUCCESS) {
            return DialogBox().show(
              context: context,
              title: '${paymentType.toUpperCase()} Payment Success',
              content: Text(
                result.description
              ),
              actions: <Widget>[
                FlatButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Close'),
                )
              ],
            );
          }
        }).catchError((dynamic error) {
          return DialogBox().show(
            context: context,
            title: error.toString(),
            content: Wrap(),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Close'),
              )
            ],
          );
        });

      } else {
        // Custom Payment
        // docs https://developers.google.com/pay/api/android/guides/tutorial
        PaymentBuilder pb = PaymentBuilder()
          ..addGateway(paymentType)
          ..addTransactionInfo("0.10", "USD")
          ..addAllowedCardAuthMethods(["PAN_ONLY", "CRYPTOGRAM_3DS"])
          ..addAllowedCardNetworks(
              ["AMEX", "DISCOVER", "JCB", "MASTERCARD", "VISA"])
          ..addBillingAddressRequired(true)
          ..addPhoneNumberRequired(true)
          ..addShippingAddressRequired(true)
          ..addShippingSupportedCountries(["US", "GB"])
          ..addMerchantInfo(paymentType);

        FlutterGooglePay.makeCustomPayment(pb.build()).then((Result result) {
          if (result.status == ResultStatus.SUCCESS) {
            return DialogBox().show(
              context: context,
              title: '${paymentType.toUpperCase()} Payment Success',
              content: Wrap(),
              actions: <Widget>[
                FlatButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Close'),
                )
              ],
            );
          } else if (result.error != null) {
            return DialogBox().show(
              context: context,
              title: '${paymentType.toUpperCase()} Payment Failed',
              content: Text(
                result.error.toString()
              ),
              actions: <Widget>[
                FlatButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Close'),
                )
              ],
            );
          }
        }).catchError((error) {
          return DialogBox().show(
            context: context,
            title: 'Error',
            content: Text(
              error.toString()
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Close'),
              )
            ],
          );
        });
      }

    }
  }

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () => _makePayment(context: context),
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
