import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movie/conf/global.dart';
import 'package:movie/services/DioService.dart';
import 'package:movie/widget/workouts.dart';

const List<String> scopes = <String>[
  'email',
  'profile',
];

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: scopes,
);

class UserLogin extends StatefulWidget {
  const UserLogin({super.key});

  @override
  State<UserLogin> createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((event) {
      print("On currentUser changed ----");

      event?.authentication.then((value) {
        String accessToken = value.accessToken!;
        print('Access token from google $accessToken');

        _getBeToken(accessToken);

        // _login("google", accessToken);
      });
    }).onError((onError) => print(onError));
  }

  void _getBeToken(String accessToken) async {
    print("Trying token exchange");
    try {
      var res = await DioService().getExchangeToken(
          "$connectionUrlAuth/getGoogleToken",
          accessToken);
      print("Response token:" + res.data);

      var user = await DioService().getWithBearer(
          "$connectionUrlAuth/api/userextras/me",
          res.data);
      print("Response bank end service:" + user.data);
    } catch (e) {
      print(e.toString());
    }
  }

  void _login(String provider, String accessToken) async {
    print("Trying token exchange");
    try {
      var dio = Dio();
      var response = await dio.post(
        'https://e6d6-93-35-222-121.ngrok-free.app/realms/company-services/protocol/openid-connect/token',
        options: Options(
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
          },
        ),
        data: {
          'client_id': 'movies-app',
          'subject_token': '${accessToken}',
          'subject_issuer': 'google',
          'grant_type': 'urn:ietf:params:oauth:grant-type:token-exchange',
          'requested_token_type':
              'urn:ietf:params:oauth:token-type:access_token',
        },
      );
      print("Response from tokenExchange keycloak:");
      var chunkSize = 1024; // Adjust chunk size as needed
      var data = response.data.toString();
      for (var i = 0; i < data.length; i += chunkSize) {
        print(data.substring(
            i, i + chunkSize > data.length ? data.length : i + chunkSize));
      }
      debugPrint(json.encode(response.data));
      var accessTokenExchange = response.data['access_token'];
      print('Access Token exchange: $accessTokenExchange');

      var data2 = accessTokenExchange.toString();
      for (var i = 0; i < data2.length; i += chunkSize) {
        print(data2.substring(
            i, i + chunkSize > data2.length ? data2.length : i + chunkSize));
      }

      try {
        var res = await DioService().getWithBearer(
            "https://2e05-93-35-222-121.ngrok-free.app/api/userextras/noAuth",
            accessTokenExchange);
        print(res.data);
        // var dio2 = Dio();
        // dio2.options.headers['authorization'] = 'Bearer ${accessTokenExchange}';
        // dio2.options.headers['Content-Type'] = 'application/json';
        // dio2.options.headers['Accept'] = 'application/json';
        //
        //
        // var response2 = await dio2.get('https://2e05-93-35-222-121.ngrok-free.app/api/userextras/me');
        //
        // print(response2.data);
      } catch (e) {
        print(e.toString());
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Social Login Example"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundImage: const NetworkImage(
                "https://as1.ftcdn.net/v2/jpg/03/95/29/32/1000_F_395293226_A4boRgABAbfXmAmmynQHcjjIIB3MjDCj.jpg"),
            minRadius: MediaQuery.of(context).size.width / 4,
          ),
          const SizedBox(
            height: 120,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              padding: const EdgeInsets.all(10.0),
              onPressed: () => _googleSignIn.signIn(),
              color: Colors.white,
              elevation: 5,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://storage.googleapis.com/gd-wagtail-prod-assets/original_images/evolving_google_identity_videoposter_006.jpg"),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text("Login with Google    "),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              padding: const EdgeInsets.all(10.0),
              onPressed: () => _googleSignIn.signOut(),
              color: Colors.white,
              elevation: 5,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://as1.ftcdn.net/v2/jpg/03/95/29/32/1000_F_395293226_A4boRgABAbfXmAmmynQHcjjIIB3MjDCj.jpg"),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text("Sign out"),
                  ),
                ],
              ),
            ),
          ),    Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              padding: const EdgeInsets.all(10.0),
              onPressed: () => Get.to(Workouts()),
              color: Colors.white,
              elevation: 5,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://as1.ftcdn.net/v2/jpg/03/95/29/32/1000_F_395293226_A4boRgABAbfXmAmmynQHcjjIIB3MjDCj.jpg"),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text("Skip"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
