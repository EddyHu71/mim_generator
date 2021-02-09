import 'package:algostudio_test/utils/module.dart';

class SharePhoto extends StatefulWidget {
  AlgoScoped model;
  File images;
  SharePhoto({
    this.model,
    this.images,
  });
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SharePhotoState();
  }
}

class SharePhotoState extends State<SharePhoto> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ScopedModel<AlgoScoped>(
      model: widget.model,
      child: Scaffold(
          appBar: Component.appBar(),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.75,
                    child: widget.images == null
                        ? Image.asset(
                            URL.IMAGE_NOT_FOUND,
                            fit: BoxFit.fitHeight,
                          )
                        : Image.file(
                            widget.images,
                            fit: BoxFit.fitHeight,
                          )),
                SizedBox(
                  height: 20,
                ),
                Container(
                    child: Row(
                  children: [
                    Component.primaryButton(
                        onPressed: () {},
                        text: "SHARE TO FB",
                        context: context),
                    Expanded(child: SizedBox()),
                    Component.primaryButton(
                        onPressed: () {},
                        text: "SHARE TO TWITTER",
                        context: context),
                  ],
                ))
              ],
            ),
          )),
    );
  }
}
