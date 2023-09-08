import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:movie/controllers/HomeController.dart';
import 'package:movie/widget/bar.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.red,
        body: Container(
          child: Column(
            children: [
              Padding(
                  padding: EdgeInsets.only(
                      bottom: 0, left: 0, right: 0, top: size.height * 0.05)),
              Center(
                child: Obx(
                  ()=> Text(
                    ' ${homeController.title}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(
                      bottom: 0, left: 0, right: 0, top: size.height * 0.05)),
              Container(height: size.height * 0.05,width: size.width*0.98,child: Bar(size: size))
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabBar(size) {
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: homeController.orders.length,
        itemBuilder: (ctx, i) {
          return Obx(
            () => GestureDetector(
              onTap: () {
                homeController.selectedIndex.value = i;
                // homeController.ordersFunc(homeController.orders[i]);
              },
              child: AnimatedContainer(
                  margin: EdgeInsets.fromLTRB(i == 0 ? 15 : 5, 0, 5, 0),
                  width: size.width*0.2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(
                        i == homeController.selectedIndex.value ? 18 : 15)),
                    color: i == homeController.selectedIndex.value
                        ? Colors.grey[700]
                        : Colors.grey[200],
                  ),
                  duration: const Duration(milliseconds: 300),
                  child: Center(
                    child: Text(
                      homeController.orders[i],
                      style: TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w500,
                        color: i == homeController.selectedIndex.value
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  )),
            ),
          );
        });
  }
}
