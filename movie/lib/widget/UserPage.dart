import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:movie/widget/CalendarPage.dart';
import 'package:movie/widget/ui/Background.dart';
import 'package:movie/widget/workouts.dart';

import '../conf/global.dart';
import '../controllers/HomeController.dart';
import '../icons/my_flutter_app_icons.dart';
import '../services/DioService.dart';
import 'UploadPage.dart';

const List<String> scopes = <String>[
  'email',
  'profile',
];

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: scopes,
);

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  HomeController homeController = Get.find<HomeController>();

  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((event) {
      print("User Changed event");

      event?.authentication.then((value) {
        String accessToken = value.accessToken!;
        print('Access token from google $accessToken');
        homeController.isLoading.value=true;

        _getBeToken(accessToken);
      });
    }).onError((onError) => print(onError));
  }

  void _getBeToken(String accessToken) async {
    print("Trying token exchange");
    try {
      var res = await DioService()
          .getExchangeToken("$connectionUrlAuth/getGoogleToken", accessToken);
      print("Response token:" + res.data);

      homeController.setToken(res.data);

      var user = await DioService()
          .getWithBearer("$connectionUrlAuth/api/userextras/me", res.data);
      print("Response bank end service:" + user.data);

      homeController.setUser(user.data);
      homeController.setLoggedIn(true);

      var favs = await DioService()
          .getWithBearer("$connectionUrlAuth/api/workout/favorites", res.data);
      print("Response favorites " + favs.data);
      homeController.setUserFavorites(favs.data);

      homeController.isLoading.value=false;
    } catch (e) {
      print(e.toString());
      homeController.isLoading.value=false;
    }
  }

  late double _height;
  late double _width;

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Background(backgroundName: "background1.jpg"),
          Container(
            padding: EdgeInsets.fromLTRB(0, _height * 0.06, 0, 0),
            width: _width * 0.88,
            child: Column(
              children: [
                Container(
                  width: _width,
                  height: _height * 0.10,
                  decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: _width * 0.03,
                            ),
                            InkWell(
                              onTap: () => Navigator.pop(context),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.arrow_back_rounded,
                                    color: Colors.red,
                                  ),
                                  Container(
                                    child: SizedBox(
                                      width: _width * 0.3,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // SizedBox(
                            //   width: _width * 0.2,
                            // ),
                            // Container(
                            //   child: Obx(
                            //     () => homeController.loggedIn.value ? Icon(
                            //       Icons.favorite,
                            //       color: homeController.loggedIn.value
                            //           ? Colors.red
                            //           : Colors.white38,
                            //     ) :  SizedBox(
                            //       width: _width * 0.001,
                            //     ),
                            //   ),
                            // ),


                            Expanded(
                              child: Container(
                                child: Obx(
                                  () => homeController.loggedIn.value
                                      ? Text(
                                          "${homeController.user.value}",
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700),
                                        )
                                      : const Text(
                                          "Log in",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700),
                                        ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(child: _areaWidget()),
                _topDownWidget()
              ],
            ),
          )
        ],
      ),
    );
  }

  _areaWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        Obx(() =>
        homeController.isLoading.value
            ? Center(
          child: LoadingAnimationWidget.flickr(
            rightDotColor: Colors.black,
            leftDotColor: const Color(0xfffd0079),
            size: 30,
          ),
        )
            :

        CircleAvatar(
          // backgroundImage: const NetworkImage(
          //     '$connectionUrl/video/circle.png'),
          backgroundImage: const NetworkImage(
              "https://as1.ftcdn.net/v2/jpg/03/95/29/32/1000_F_395293226_A4boRgABAbfXmAmmynQHcjjIIB3MjDCj.jpg"),
          minRadius: MediaQuery.of(context).size.width / 4,
        )
        )
        ,


        // CircleAvatar(
        //   backgroundImage: const NetworkImage(
        //       "https://as1.ftcdn.net/v2/jpg/03/95/29/32/1000_F_395293226_A4boRgABAbfXmAmmynQHcjjIIB3MjDCj.jpg"),
        //   minRadius: MediaQuery.of(context).size.width / 4,
        // ),
        const SizedBox(
          height: 120,
        ),

        Obx(() => homeController.loggedIn.value
            ? Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  padding: const EdgeInsets.all(10.0),
                  onPressed: () => {signOut()},
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
                        child: Text("Sign out"),
                      ),
                    ],
                  ),
                ),
              )
            : Container(
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
              )),

        // Container(
        //   margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        //   child: MaterialButton(
        //     shape: RoundedRectangleBorder(
        //         borderRadius: BorderRadius.circular(20.0)),
        //     padding: const EdgeInsets.all(10.0),
        //     onPressed: () => Get.to(Workouts()),
        //     color: Colors.white,
        //     elevation: 5,
        //     child: const Row(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       crossAxisAlignment: CrossAxisAlignment.center,
        //       children: [
        //         CircleAvatar(
        //           backgroundImage: NetworkImage(
        //               "https://as1.ftcdn.net/v2/jpg/03/95/29/32/1000_F_395293226_A4boRgABAbfXmAmmynQHcjjIIB3MjDCj.jpg"),
        //         ),
        //         Padding(
        //           padding: EdgeInsets.only(left: 10.0),
        //           child: Text("Skip"),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
      ],
    );
  }

  signOut() {
    _googleSignIn.signOut();
    homeController.setLoggedIn(false);
  }


  _topDownWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(_height * 0.01),
            child: Container(
              width: _width * 0.2,
              height: _height * 0.08,
              decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(20.0)),
              child: InkWell(
                onTap: () => Get.to(UploadPage()),
                child: Icon(Icons.upload, color: Colors.red, fill: 0.2),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(_height * 0.01),
            child: Container(
              width: _width * 0.2,
              height: _height * 0.08,
              decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(20.0)),
              child:  InkWell(
                onTap: () =>  Get.to(()=>CalendarPage()),
                child:  Icon(
                  Icons.calendar_month_rounded,
                  color: Colors.red,
                  fill: 0.2,
                ),
              )
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(_height * 0.01),
            child: Container(
              width: _width * 0.2,
              height: _height * 0.08,
              decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(20.0)),
              child: InkWell(
                onTap: () => Get.to(UserPage()),
                child: Icon(
                  Icons.login_rounded,
                  color: Colors.red,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
              padding: EdgeInsets.all(_height * 0.01),
              child: Container(
                  width: _width * 0.2,
                  height: _height * 0.08,
                  decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Obx(
                        () => PopupMenuButton<String>(
                      initialValue: homeController.targetSelected.value,
                      onSelected: (value) =>
                          homeController.changeTargets(value),
                      itemBuilder: (BuildContext context) {
                        return <PopupMenuEntry<String>>[
                          ...homeController.targets
                              .map((element) => PopupMenuItem(
                            value: element,
                            child: Text(
                              element,
                              style: TextStyle(color: Colors.white),
                            ),
                          ))
                              .toList()
                        ];
                      },
                      icon: Icon(
                        MyFlutterApp.yoga_standing_forward_fold_pose,
                        color: Colors.red,
                      ),
                      color: Colors.black38,
                      constraints: BoxConstraints(
                        maxHeight: _height * 0.5,
                        maxWidth: _width * 0.2,
                      ),
                    ),
                  ))),
        ),
      ],
    );
  }


}
