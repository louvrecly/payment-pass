import 'package:flutter_apple_pay/flutter_apple_pay.dart';
import 'package:flutter/services.dart';
import '../models/payment_result.dart';
import 'payment_bloc.dart';

class ApplePayBloc extends PaymentBloc {

  final String environment;

  ApplePayBloc({ this.environment = 'test' });

  @override
  Future<PaymentResult> makePayment() async {
    dynamic platformVersion;
    PaymentItem paymentItems = PaymentItem(label: 'Label', amount: 0.10);

    try {
      platformVersion = await FlutterApplePay.makePayment(
        countryCode: "US",
        currencyCode: "USD",
        paymentNetworks: [PaymentNetwork.visa, PaymentNetwork.mastercard],
        merchantIdentifier: "merchant.stripeApplePayTest",
        paymentItems: [paymentItems],
        stripePublishedKey: "pk_test_TYooMQauvdEDq54NiTphI7jx"
      );
      final String text = platformVersion['message'];

      return PaymentResult(
        title: 'Apple Pay Result',
        text: text,
      );
    } on PlatformException catch(err) {
      platformVersion = 'Failed to get platform version.';

      return PaymentResult(
        title: platformVersion.toString(),
        text: err.toString(),
      );
    }
  }

  @override
  void dispose() {
    print('ApplePayBloc.dispose()');
  }

}
