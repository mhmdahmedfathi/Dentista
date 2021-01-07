import 'package:dentista/Authentication/Signin.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:dentista/Models/Alerts.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  setUp(() {});
  tearDown(() {});


  group("Testing SignIn", (){


    testWidgets("Empty Password and Email", (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: SignIn()));

      //1-find widgets needed
      final textfieldemail = find.byKey(Key("emailtextformfield"));
      expect(textfieldemail, findsOneWidget);
      final textfieldpassword = find.byKey(Key("passwordtextformfield"));
      expect(textfieldpassword, findsOneWidget);
      final buttonsignin = find.byKey(Key("Signin"));
      expect(buttonsignin, findsOneWidget);

      //2-execute the actual test
      await tester.enterText(textfieldemail, "");
      await tester.enterText(textfieldpassword, "");
      await tester.tap(buttonsignin);
      await tester.pump(Duration(seconds: 5));

      //3-check results
      expect(find.text("Log in Failed"), findsOneWidget);
    });

    testWidgets("Empty Email", (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: SignIn()));

      //1-find widgets needed
      final textfieldemail = find.byKey(Key("emailtextformfield"));
      expect(textfieldemail, findsOneWidget);
      final textfieldpassword = find.byKey(Key("passwordtextformfield"));
      expect(textfieldpassword, findsOneWidget);
      final buttonsignin = find.byKey(Key("Signin"));
      expect(buttonsignin, findsOneWidget);

      //2-execute the actual test
      await tester.enterText(textfieldemail, "");
      await tester.enterText(textfieldpassword, "Weaam@91");
      await tester.tap(buttonsignin);
      await tester.pump(Duration(seconds: 5));

      //3-check results
      expect(find.text("Log in Failed"), findsOneWidget);
    });

    testWidgets("Empty Password", (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: SignIn()));

      //1-find widgets needed
      final textfieldemail = find.byKey(Key("emailtextformfield"));
      expect(textfieldemail, findsOneWidget);
      final textfieldpassword = find.byKey(Key("passwordtextformfield"));
      expect(textfieldpassword, findsOneWidget);
      final buttonsignin = find.byKey(Key("Signin"));
      expect(buttonsignin, findsOneWidget);

      //2-execute the actual test
      await tester.enterText(textfieldemail, "weaam.wewe91@gmail.com");
      await tester.enterText(textfieldpassword, "");
      await tester.tap(buttonsignin);
      await tester.pump(Duration(seconds: 5));

      //3-check results
      expect(find.text("Log in Failed"), findsOneWidget);
    });

    testWidgets("Sign in with no registed account", (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: SignIn()));

      //1-find widgets needed
      final textfieldemail = find.byKey(Key("emailtextformfield"));
      expect(textfieldemail, findsOneWidget);
      final textfieldpassword = find.byKey(Key("passwordtextformfield"));
      expect(textfieldpassword, findsOneWidget);
      final buttonsignin = find.byKey(Key("Signin"));
      expect(buttonsignin, findsOneWidget);

      //2-execute the actual test
      await tester.enterText(textfieldemail, "HAHA");
      await tester.enterText(textfieldpassword, "HAHA");
      await tester.tap(buttonsignin);
      await tester.pump(Duration(seconds: 5));

      //3-check results
      expect(find.text("Log in Failed"), findsOneWidget);
    });

    testWidgets("Successful Sign In", (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: SignIn()));

      //1-find widgets needed
      final textfieldemail = find.byKey(Key("emailtextformfield"));
      expect(textfieldemail, findsOneWidget);
      final textfieldpassword = find.byKey(Key("passwordtextformfield"));
      expect(textfieldpassword, findsOneWidget);
      final buttonsignin = find.byKey(Key("Signin"));
      expect(buttonsignin, findsOneWidget);

      //2-execute the actual test
      await tester.enterText(textfieldemail, "weaam.wewe91@gmail.com");
      await tester.enterText(textfieldpassword, "Weaam@91");
      await tester.tap(buttonsignin);
      await tester.pump(Duration(seconds: 5));

      //3-check results
      expect(find.text("Log in Failed"), findsNothing);
    });

  });
  

  
}
