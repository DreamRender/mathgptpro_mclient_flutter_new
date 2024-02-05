import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:mathgptpro_mclient_flutter/constant/app_info.dart';
import 'package:mathgptpro_mclient_flutter/dev/stripe/config.dart';
import 'package:mathgptpro_mclient_flutter/dev/stripe/example_scaffold.dart';

Future<void> main() async {
  // 确保所有的Widget都已经加载完成
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // Stipe配置
  Stripe.publishableKey = MathGPTProAppInfo.stripePublishableKey;
  Stripe.merchantIdentifier = 'merchant.com.mathgptpro';
  Stripe.urlScheme = 'flutterstripe';
  await Stripe.instance.applySettings();

  runApp(
    MaterialApp(
      title: 'Google Sign In',
      home: ApplePayScreen(),
    ),
  );
}

class ApplePayScreen extends StatefulWidget {
  @override
  _ApplePayScreenState createState() => _ApplePayScreenState();
}

class _ApplePayScreenState extends State<ApplePayScreen> {
  final items = [
    ApplePayCartSummaryItem.immediate(
      label: 'Product Test',
      amount: '0.01',
    )
  ];

  final shippingMethods = [
    ApplePayShippingMethod(
      identifier: 'free',
      detail: 'Arrives by July 2',
      label: 'Free Shipping',
      amount: '0.0',
    ),
    ApplePayShippingMethod(
      identifier: 'standard',
      detail: 'Arrives by June 29',
      label: 'Standard Shipping',
      amount: '3.21',
    )
  ];

  @override
  void initState() {
    Stripe.instance.isPlatformPaySupportedListenable.addListener(update);
    super.initState();
  }

  @override
  void dispose() {
    Stripe.instance.isPlatformPaySupportedListenable.removeListener(update);
    super.dispose();
  }

  void update() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      title: 'Apple Pay',
      tags: ['iOS'],
      padding: EdgeInsets.all(16),
      children: [
        if (Stripe.instance.isPlatformPaySupportedListenable.value)
          PlatformPayButton(
            onShippingContactSelected: (contact) async {
              debugPrint('Shipping contact updated $contact');

              // Mandatory after entering a shipping contact
              await Stripe.instance.updatePlatformSheet(
                params: PlatformPaySheetUpdateParams.applePay(
                  summaryItems: items,
                  shippingMethods: shippingMethods,
                  errors: [],
                ),
              );

              return;
            },
            onShippingMethodSelected: (method) async {
              debugPrint('Shipping method updated $method');
              // Mandatory after entering a shipping contact
              await Stripe.instance.updatePlatformSheet(
                params: PlatformPaySheetUpdateParams.applePay(
                  summaryItems: items,
                  shippingMethods: shippingMethods,
                  errors: [],
                ),
              );

              return;
            },
            onCouponCodeEntered: (couponCode) {
              debugPrint('set coupon $couponCode');
            },
            onOrderTracking: () async {
              debugPrint('set order tracking');

              /// Provide a URL to your web service that will provide the order details
              ///
              await Stripe.instance.configurePlatformOrderTracking(
                  orderDetails: PlatformPayOrderDetails.applePay(
                orderTypeIdentifier: 'orderTypeIdentifier',
                orderIdentifier: 'https://your-web-service.com/v1/orders/',
                webServiceUrl: 'webServiceURL',
                authenticationToken: 'token',
              ));
            },
            type: PlatformButtonType.buy,
            appearance: PlatformButtonStyle.whiteOutline,
            onPressed: () => _handlePayPress(
              summaryItems: items,
              shippingMethods: shippingMethods,
            ),
          )
        else
          Text('Apple Pay is not available in this device'),
      ],
    );
  }

  Future<void> _handlePayPress({
    required List<ApplePayCartSummaryItem> summaryItems,
    required List<ApplePayShippingMethod> shippingMethods,
  }) async {
    try {
      // 1. fetch Intent Client Secret from backend
      final response = await fetchPaymentIntentClientSecret();
      final clientSecret = response['clientSecret'];

      // 2. Confirm apple pay payment
      await Stripe.instance.confirmPlatformPayPaymentIntent(
        clientSecret: clientSecret,
        confirmParams: PlatformPayConfirmParams.applePay(
          applePay: ApplePayParams(
              cartItems: items,
              requiredShippingAddressFields: [
                ApplePayContactFieldsType.name,
                ApplePayContactFieldsType.postalAddress,
                ApplePayContactFieldsType.emailAddress,
                ApplePayContactFieldsType.phoneNumber,
              ],
              shippingMethods: shippingMethods,
              merchantCountryCode: 'Es',
              currencyCode: 'EUR',
              supportsCouponCode: true,
              couponCode: 'Coupon'),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Apple Pay payment succesfully completed')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
      rethrow;
    }
  }

  Future<Map<String, dynamic>> fetchPaymentIntentClientSecret() async {
    final url = Uri.parse('$kApiUrl/create-payment-intent');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'email': 'example@gmail.com',
        'currency': 'usd',
        'items': ['id-1'],
        'request_three_d_secure': 'any',
      }),
    );
    return json.decode(response.body);
  }
}
