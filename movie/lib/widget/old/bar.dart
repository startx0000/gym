import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controllers/HomeController.dart';

class Bar extends StatelessWidget {
  final size;

  Bar({super.key,required  this.size});
  HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: homeController.orders.length,
        itemBuilder: (ctx, i) {
          return Obx(
                () => GestureDetector(
              onTap: () {
                homeController.selectedIndex.value = i;
                homeController.changeTitle();
                // homeController.ordersFunc(homeController.orders[i]);
              },
              child: AnimatedContainer(
                  margin: EdgeInsets.fromLTRB(i == 0 ? 15 : 5, 0, 5, 0),
                  width: size.width*0.2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(
                        i == homeController.selectedIndex.value ? 18 : 15)),
                    color: i == homeController.selectedIndex.value
                        ? Colors.grey[800]
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
