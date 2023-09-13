import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie/widget/Background.dart';

import '../controllers/HomeController.dart';

class FilePickerDemo extends StatefulWidget {
  const FilePickerDemo({super.key, required this.title});

  final String title;

  @override
  State<FilePickerDemo> createState() => _FilePickerDemoState();
}

class _FilePickerDemoState extends State<FilePickerDemo> {
  HomeController homeController = Get.find<HomeController>();

  FilePickerResult? result;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: Colors.black, //change your color here
            ),
            title: Text("Upload"),
            centerTitle: true,
          ),
        body: Stack(
          children:[
            Background(),
            Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (result != null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Selected file:',
                          style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10,),
                        ListView.separated(
                          shrinkWrap: true,
                          itemCount: result?.files.length ?? 0,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Center(child: InkWell(
                                    onTap : () => homeController.uploadFile(name: result?.files[index].name ?? 'pippo', path: result?.files[index].path ?? "pluto"),
                                    child: Text('upload', style: TextStyle(fontSize: 14,color: Colors.red),)),),
                                InkWell(
                                  // onTap : () => homeController.uploadFile(name: result?.files[index].name ?? 'pippo', path: result?.files[index].path ?? "pluto") ),

                                  child: const Text('',
                                      style: TextStyle(
                                          fontSize: 16, fontWeight: FontWeight.bold)),
                                ),
                                Text(result?.files[index].name ?? '',
                                    style: const TextStyle(
                                        fontSize: 16, fontWeight: FontWeight.bold)),
                              ],
                            );
                          }, separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(height: 5,);
                        },)
                      ],
                    ),
                  ),
                const Spacer(),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      result =
                      await FilePicker.platform.pickFiles(allowMultiple: true);
                      if (result == null) {
                        print("No file selected");
                      } else {
                        setState(() {});
                        for (var element in result!.files) {
                          print(element.name);
                        }
                      }
                    },
                    child: const Text("File Picker"),
                  ),
                ),
              ],
            ),
          ),]
        ),
      );

  }

}