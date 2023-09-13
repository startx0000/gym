import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie/controllers/UploadController.dart';
import 'package:movie/widget/Background.dart';
import 'package:movie/widget/workouts.dart';

class Upload extends StatelessWidget {
  Upload({super.key});

  UploadController uploadController = Get.put(UploadController());

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
          Background(),
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
                              child: const Icon(
                                Icons.arrow_back_rounded,
                                color: Colors.red,
                              ),
                            ),
                            SizedBox(
                              width: _width * 0.3,
                            ),
                            const Text(
                              "Upload workout",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(child: _areaWidget())
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _areaWidget() {
    return Container(
      height: _height * 0.83,
      padding: EdgeInsets.symmetric(vertical: _height * 0.01),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                "Video",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.white38),
              ),
              Padding(
                padding: EdgeInsets.all(_height * 0.01),
                child: Container(
                  width: _width * 0.2,
                  height: _height * 0.08,
                  decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(20.0)),
                  child: InkWell(
                    onTap: () async {
                      uploadController.result?.value = (await FilePicker.platform
                          .pickFiles(allowMultiple: true))!;
                    },
                    child: Icon(Icons.video_collection,
                        color: Colors.red, fill: 0.2),
                  ),
                ),
              ),
               Text(
                uploadController.result?.value.files[0].name ?? "",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.white38),
              )

            ],
          )
        ],
      ),
    );
  }
}
