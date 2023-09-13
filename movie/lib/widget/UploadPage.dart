import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../controllers/UploadController.dart';
import 'Background.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({super.key});

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  FilePickerResult? result;
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
      child: Obx(
        ()=> uploadController.isLoading.value ? Center(
          child: LoadingAnimationWidget.flickr(
            rightDotColor: Colors.black,
            leftDotColor: const Color(0xfffd0079),
            size: 30,
          ),
        ) : Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: const Text(
                    "Video",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.white38),
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
                        onTap: () async {
                          result =
                          await FilePicker.platform.pickFiles(allowMultiple: false);
                          if (result == null) {
                            print("No file selected");
                          } else {
                            setState(() {});
                            uploadController.changeVideoSelected(true);
                            for (var element in result!.files) {
                              print(element.name);
                            }
                          }
                        },
                        child: Icon(Icons.video_collection,
                            color: Colors.red, fill: 0.2),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Text(result?.files[0].name ?? '',
                      style: const TextStyle(
                        color: Colors.white38,
                          fontSize: 14, fontWeight: FontWeight.bold)),
                ),

                Expanded(child: _upload())



              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _upload(){

     if(!uploadController.videoSelected.value) {
       return const Text('',
        style: TextStyle(
            color: Colors.white38,
            fontSize: 14, fontWeight: FontWeight.bold));


     }


     else if( uploadController.uploaded.value=="YET")
     {
       return Padding(
         padding: EdgeInsets.all(_height * 0.01),
         child: Container(
           width: _width * 0.2,
           height: _height * 0.08,
           decoration: BoxDecoration(
               color: Colors.black26,
               borderRadius: BorderRadius.circular(20.0)),
           child: InkWell(
             onTap : () => uploadController.uploadFile(name: result?.files[0].name ?? 'pippo', path: result?.files[0].path ?? "pluto"),
             child: Icon(Icons.upload, color: Colors.red, fill: 0.2),
           ),
         ),
       );


     }
  else {
       return InkWell(
         onTap: () => uploadController.uploaded.value="YET",
         child: Padding(
           padding: EdgeInsets.all(_height * 0.01),
           child: Container(
             width: _width * 0.2,
             height: _height * 0.08,
             decoration: BoxDecoration(
                 color: Colors.black26,
                 borderRadius: BorderRadius.circular(20.0)),
             child: Icon(uploadController.uploaded.value=="OK" ? Icons.vape_free : Icons.error, color: Colors.red, fill: 0.2),
           ),
         ),
       );
     }
  }

}
