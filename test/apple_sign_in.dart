// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

void main() {
  runApp(
    const MaterialApp(
      title: 'Google Sign In',
      home: SignInDemo(),
    ),
  );
}

class SignInDemo extends StatefulWidget {
  const SignInDemo({super.key});

  @override
  State createState() => _SignInDemoState();
}

class _SignInDemoState extends State<SignInDemo> {
  AuthorizationCredentialAppleID? credential = null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Google Sign In'),
        ),
        body: ListView(
          children: [
            SignInWithAppleButton(
              onPressed: () async {
                credential = await SignInWithApple.getAppleIDCredential(
                  scopes: [
                    AppleIDAuthorizationScopes.email,
                    AppleIDAuthorizationScopes.fullName,
                  ],
                );
                setState(() {});
              },
            ),
            const SelectableText("credential?.authorizationCode"),
            SelectableText("${credential?.authorizationCode}"),
            const SelectableText("credential?.email"),
            SelectableText("${credential?.email}"),
            const SelectableText("credential?.familyName"),
            SelectableText("${credential?.familyName}"),
            const SelectableText("credential?.givenName"),
            SelectableText("${credential?.givenName}"),
            const SelectableText("credential?.identityToken"),
            SelectableText("${credential?.identityToken}"),
            const SelectableText("credential?.state"),
            SelectableText("${credential?.state}"),
            const SelectableText("credential?.userIdentifier"),
            SelectableText("${credential?.userIdentifier}"),
            const SelectableText("credential"),
            SelectableText("$credential")
          ],
        ));
  }
}
