import 'package:first_app/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorPayPaymentPage extends StatefulWidget {

  double amount;

  RazorPayPaymentPage({Key? key, required this.amount}) : super(key: key);

  @override
  _RazorPayPaymentPageState createState() => _RazorPayPaymentPageState();
}

class _RazorPayPaymentPageState extends State<RazorPayPaymentPage> {

  late Razorpay _razorpay;

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
      'amount': double.parse(widget.amount.toString().split(".").join("")+".0"),
      'currency' : 'INR',
      'name': 'Foodie',
      'description': 'Food Order',
      "image": "https://image.flaticon.com/icons/png/512/4521/4521016.png",
      'prefill': {
        "name": get_user_data!.name.toString(),
        // 'contact': get_user_data!.name.toString(),
        'email': get_user_data!.email.toString()
      },
      'external': {
        'wallets': ['paytm']
      },
      "theme": {
        // "color": "#3CD441"
        // "color": "#2BC631"
        "color": "#21BA27",
      }

    };

    try {
      _razorpay.open(options);
      print("Amount = ${double.parse(widget.amount.toString().split(".").join("")+".0")}");
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  void onPaymentSuccess(PaymentSuccessResponse response) {
    print(response.paymentId);
    // Navigate the User to a Successful Page
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