import 'package:flutter_google_pay/flutter_google_pay.dart';
import '../models/payment_result.dart';

class PaymentBloc {

  final String environment;

  PaymentBloc({ this.environment = 'test' });

  Future<PaymentResult> makePayemnt({ String paymentType = 'stripe' }) async {
    if (!(await FlutterGooglePay.isAvailable(environment))) {
      return PaymentResult(
        title: 'Sorry',
        text: 'Google Pay not available!',
      );
    } else {
      if (paymentType == 'stripe') {
        // Stripe Payment
        PaymentItem pm = PaymentItem(
          stripeToken: 'pk_test_1IV5H8NyhgGYOeK6vYV3Qw8f',
          stripeVersion: "2018-11-08",
          currencyCode: "usd",
          amount: "0.10",
          gateway: 'stripe'
        );

        return FlutterGooglePay.makePayment(pm).then((Result result) {
          if (result.status == ResultStatus.SUCCESS) {
            return PaymentResult(
              title: '${paymentType.toUpperCase()} Payment Success',
              text: result.description,
            );
          } else {
            return PaymentResult(
              title: '${paymentType.toUpperCase()} Payment Failed',
              text: result.error.toString(),
            );
          }
        }).catchError((dynamic error) {
          return PaymentResult(
            title: '${paymentType.toUpperCase()} Payment Error',
            text: error.toString(),
          );
        });

      } else {
        // Custom Payment
        // docs https://developers.google.com/pay/api/android/guides/tutorial
        PaymentBuilder pb = PaymentBuilder()
          ..addGateway(paymentType)
          ..addTransactionInfo("0.10", "USD")
          ..addAllowedCardAuthMethods(["PAN_ONLY", "CRYPTOGRAM_3DS"])
          ..addAllowedCardNetworks(["AMEX", "DISCOVER", "JCB", "MASTERCARD", "VISA"])
          ..addBillingAddressRequired(true)
          ..addPhoneNumberRequired(true)
          ..addShippingAddressRequired(true)
          ..addShippingSupportedCountries(["US", "GB"])
          ..addMerchantInfo(paymentType);

        return FlutterGooglePay.makeCustomPayment(pb.build()).then((Result result) {
          if (result.status == ResultStatus.SUCCESS) {
            return PaymentResult(
              title: '${paymentType.toUpperCase()} Payment Success',
              text: result.description,
            );
          } else {
            return PaymentResult(
              title: '${paymentType.toUpperCase()} Payment Failed',
              text: result.error.toString(),
            );
          }
        }).catchError((error) {
          return PaymentResult(
            title: '${paymentType.toUpperCase()} Payment Error',
            text: error.toString(),
          );
        });
      }
    }
  }

}
