import 'package:flutter_apple_pay/flutter_apple_pay.dart';
import 'package:flutter/services.dart';
import '../models/payment_result.dart';
import 'bloc.dart';

class ApplePayBloc extends Bloc {

  final String environment;

  ApplePayBloc({ this.environment = 'test' });

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
      print(platformVersion);

      return PaymentResult(
        title: 'Apple Pay Success',
        text: platformVersion.toString(),
      );
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
      return PaymentResult(
        title: 'Apple Pay Failed',
        text: platformVersion.toString(),
      );
    }
  }

  @override
  void dispose() {
    print('ApplePayBloc.dispose()');
  }

}
