import 'package:algostudio_test/utils/module.dart';

class DetailPage extends StatefulWidget {
  AlgoScoped model;
  Memes memes;
  File images;
  DetailPage({
    this.model,
    this.memes,
    this.images,
  });
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DetailPageState();
  }
}

class DetailPageState extends State<DetailPage> {
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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                widget.images == null
                    ? Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.75,
                        child: widget.memes.url == null
                            ? Image.asset(
                                URL.IMAGE_NOT_FOUND,
                                fit: BoxFit.fitHeight,
                              )
                            : Image.network(
                                widget.memes.url,
                                fit: BoxFit.fitHeight,
                              ))
                    : Image.file(widget.images, fit: BoxFit.fitHeight),
                Expanded(child: SizedBox()),
                Container(
                    child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Component.primaryButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddPhoto(
                                        images: widget.images,
                                        meme: widget.memes,
                                        model: widget.model,
                                      )));
                        },
                        text: "Add Photo",
                        context: context),
                    Expanded(child: SizedBox()),
                    Component.primaryButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddContent(
                                        images: widget.images,
                                        meme: widget.memes,
                                        model: widget.model,
                                      )));
                        },
                        text: "Add Text",
                        context: context),
                  ],
                ))
              ],
            ),
          )),
    );
  }
}
