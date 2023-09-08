import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  File? image;
  int frame = 1;
  bool isFrame = false;
  void pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
// Pick an image.
    final image = await picker.pickImage(source: source);
    var file = await ImageCropper().cropImage(
        sourcePath: image!.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 0.85));
    final imageTemoparary = File(file!.path);
    setState(() {
      this.image = imageTemoparary;
    });
  }
  void showSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      backgroundColor: Colors.teal,
      content: Text('Please Select Image First'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text('Choose Frame'),
          actions: <Widget>[
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      child: const Text('Heart'),
                      onPressed: () {
                        setState(() {
                          if(image==null){
                            showSnackBar(context);
                          }
                          frame = 1;
                          isFrame = true;
                        });
                      },
                    ),
                    TextButton(
                      child: const Text('Square'),
                      onPressed: () {
                        setState(() {
                          if(image==null){
                            showSnackBar(context);
                            return;
                          }
                          frame = 2;
                          isFrame = true;
                        });
                      },
                    ),
                    TextButton(
                      child: const Text('Circle'),
                      onPressed: () {
                        setState(() {
                          if(image==null){
                            showSnackBar(context);
                            return;
                          }
                          frame = 3;
                          isFrame = true;
                        });
                      },
                    ),
                    TextButton(
                      child: const Text('Rectangle'),
                      onPressed: () {
                        setState(() {
                          if(image==null){
                            showSnackBar(context);
                            return;
                          }
                          frame = 4;
                          isFrame = true;
                        });
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            if(image==null){
                              showSnackBar(context);
                              return;
                            }
                            isFrame=false;
                          });
                        },
                        child: Text('No Frame')),
                    ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('Done')),
                  ],
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: InkWell(
          onTap: () => SystemNavigator.pop(),
          child: Icon(Icons.close),
        ),
        title: Text('Add An Image'),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(),
              child: TextButton(
                onPressed: () => pickImage(ImageSource.gallery),
                child: Text('Upload An Image'),
              ),
            ),
            ElevatedButton(
              onPressed: () => _dialogBuilder(context),
              child: Text('Change Frame'),
            ),
            if (image != null)
              Container(
                height: 400,
                child: Stack(alignment: AlignmentDirectional.center, children: [
                  Image.file(
                    image!,
                    height: 400,
                  ),
                  if (isFrame == true)
                    Image.asset(
                      'assets/user_image_frame_$frame.png',
                      color: Colors.white,
                      colorBlendMode: BlendMode.xor,
                    ),
                ]),
              ),
          ],
        ),
      ),
    );
  }
}

// image != null
// ? Image.file(
// image!,
// )
// : FlutterLogo(),
