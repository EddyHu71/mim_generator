import 'package:algostudio_test/utils/module.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;
import 'dart:math';
import 'dart:typed_data';

class AddPhoto extends StatefulWidget {
  AlgoScoped model;
  Memes meme;
  File images;
  AddPhoto({
    this.model,
    this.meme,
    this.images,
  });
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AddPhotoState();
  }
}

class AddPhotoState extends State<AddPhoto> {
  final GlobalKey globalKey = new GlobalKey();

  String headerText = "";
  File _imageFile, _memImage;
  Random random = new Random();

  getImage() async {
    File image;
    try {
      image = await ImagePicker.pickImage(source: ImageSource.gallery);
    } catch (platformException) {
      print("not allowing " + platformException);
    }
    setState(() {
      _memImage = image;
    });
    // new Directory('storage/emulated/0/' + 'MemeGenerator')
    //     .create(recursive: true);
  }

  editPhoto(bool shared) async {
    RenderRepaintBoundary boundary =
        globalKey.currentContext.findRenderObject();
    ui.Image image = await boundary.toImage();
    final directory = (await getApplicationDocumentsDirectory()).path;
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData.buffer.asUint8List();
    print(pngBytes);
    File imgFile = new File("$directory/screenshot${random.nextInt(100)}.png");
    setState(() {
      _imageFile = imgFile;
    });

    saveFile(_imageFile, shared);
    imgFile.writeAsBytes(pngBytes);
  }

  askPermission() async {
    Map<PermissionGroup, PermissionStatus> permissions =
        await PermissionHandler().requestPermissions([PermissionGroup.photos]);
  }

  saveFile(File file, bool shared) async {
    print(shared.toString());
    await askPermission();
    final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(await file.readAsBytes()));
    if (result != null) {
      Toast.show("Your photo has been saved in your phone directory", context,
          duration: Toast.LENGTH_LONG);
      if (shared == true) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    SharePhoto(images: file, model: widget.model)));
      } else {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => DetailPage(
                    images: file,
                    model: widget.model,
                  )),
          (Route<dynamic> route) => false,
        );
      }
    } else {
      Toast.show("Your image is null", context, duration: Toast.LENGTH_LONG);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ScopedModel<AlgoScoped>(
        model: widget.model,
        child: Scaffold(
            resizeToAvoidBottomPadding: false,
            appBar: Component.appBar(),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  RepaintBoundary(
                      key: globalKey,
                      child: Stack(
                        children: [
                          widget.images != null
                              ? Container(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.75,
                                  child: Image.file(
                                    widget.images,
                                    fit: BoxFit.fitHeight,
                                  ))
                              : Container(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.75,
                                  child: widget.meme.url == null
                                      ? Image.asset(
                                          URL.IMAGE_NOT_FOUND,
                                          fit: BoxFit.fitHeight,
                                        )
                                      : Image.network(
                                          widget.meme.url,
                                          fit: BoxFit.fitHeight,
                                        )),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 300,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                _memImage == null
                                    ? Container()
                                    : Image.file(_memImage, fit: BoxFit.fill),
                              ],
                            ),
                          ),
                        ],
                      )),
                  SizedBox(height: 16.0),
                  Container(
                    child: Row(
                      children: [
                        Expanded(
                            child: Component.primaryButton(
                                onPressed: () {
                                  getImage();
                                  // Navigator.of(context).pop();
                                },
                                text: "ADD AN IMAGE",
                                context: context))
                      ],
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Container(
                      child: Row(
                    children: [
                      Component.primaryButton(
                          onPressed: () {
                            editPhoto(false);
                          },
                          text: "SAVE",
                          context: context),
                      Expanded(child: SizedBox()),
                      Component.primaryButton(
                          onPressed: () {
                            editPhoto(true);
                          },
                          text: "SHARE",
                          context: context),
                    ],
                  ))
                ],
              ),
            )));
  }
}
