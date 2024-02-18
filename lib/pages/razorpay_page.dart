import 'package:flutter/material.dart';
import 'package:homaze/model/util.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorPayPaymentPage extends StatefulWidget {

  RazorPayPaymentPage({Key? key}) : super(key: key);

  @override
  _RazorPayPaymentPageState createState() => _RazorPayPaymentPageState();
}

class _RazorPayPaymentPageState extends State<RazorPayPaymentPage> {

  late Razorpay _razorpay;
  int amount = 500;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, onPaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void openCheckout() async {
    var options = {
      'key': 'rzp_test_1DP5mmOlF5G5ag',
      'amount': amount*100,
      'name': 'Homaze',
      'description': 'Premium Plan',
      'prefill': {'contact': Util.appUser!.name.toString(), 'email': Util.appUser!.email.toString()},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  void onPaymentSuccess(PaymentSuccessResponse response) {
    Navigator.pop(context, 1);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Navigator.pop(context, 0);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Navigator.pop(context, 2);
  }


  @override
  Widget build(BuildContext context) {

    openCheckout();

    return Center(
      child: CircularProgressIndicator(),
    );
  }
}