import '../models/payment_result.dart';
import 'bloc.dart';

abstract class PaymentBloc extends Bloc {

  Future<PaymentResult> makePayment();

  @override
  void dispose();

}
