import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../Components/components.dart';

class PaymentController extends GetxController {
  Map<String, dynamic>? paymentIntentData;

  Future<bool> makePayment(
      {required String amount, required String currency}) async {
    try {
      paymentIntentData = await createPaymentIntent(amount, currency);
      if (paymentIntentData != null) {
        await Stripe.instance.initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
              merchantDisplayName: 'Prospects',
              merchantCountryCode: "US",
              customerId: paymentIntentData!['customer'],
              paymentIntentClientSecret: paymentIntentData!['client_secret'],
              customerEphemeralKeySecret: paymentIntentData!['ephemeralKey'],
              testEnv: true,
              applePay: true,
              googlePay: true,
              primaryButtonColor: Colors.deepOrange,
            ));
       await displayPaymentSheet();
      }
    } catch (e) {
      return false;
    }
    return true;
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();

      // deleteCart();
      payment=true;
    } on Exception catch (e) {
      if (e is StripeException) {
      } else {
      }
    }
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization': 'Bearer sk_test_51MWIzPKNFf4yjl9RDAs6bjc2fopcNcxUMZ9XTr3fghJFrSZr3OgWfVUkt2B5uYSTojH0uo3lRk0CaUcK5APEtsW100neybqUgz',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      return jsonDecode(response.body);
    } catch (err) {
    }
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a.toString();
  }
}

