import 'package:algostudio_test/utils/module.dart';

class Home extends StatefulWidget {
  AlgoScoped model;
  Home({
    this.model,
  });
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeState();
  }
}

class HomeState extends State<Home> {
  @override
  void initState() {
    widget.model.getMeme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ScopedModelDescendant<AlgoScoped>(builder: (context, build, model) {
      return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: Component.appBar(),
        body: Padding(
          padding: const EdgeInsets.all(4.0),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                  child: Container(
                      height: MediaQuery.of(context).size.height * 0.1,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                          child: IconButton(
                              icon: Icon(Icons.refresh, size: 24.0),
                              onPressed: () {
                                widget.model.getMeme();
                              })))),
              widget.model.adalistmeme == true
                  ? SliverToBoxAdapter(
                      child: Center(
                      child: CircularProgressIndicator(),
                    ))
                  : widget.model.listmeme.length == null
                      ? SliverToBoxAdapter(
                          child: Center(
                              child: Text("No Image",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                      fontSize: 24.0))),
                        )
                      : SliverGrid(
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => DetailPage(
                                                  memes: widget
                                                      .model.listmeme[index],
                                                  model: widget.model)));
                                    },
                                    child: Container(
                                      width:
                                          MediaQuery.of(context).size.width / 3,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              3,
                                      child: widget.model.listmeme[index].url ==
                                              null
                                          ? Image.asset(
                                              URL.IMAGE_NOT_FOUND,
                                              fit: BoxFit.fill,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  3,
                                            )
                                          : Image.network(
                                              widget.model.listmeme[index].url,
                                              fit: BoxFit.fill,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  3,
                                            ),
                                    )),
                              );
                            },
                            childCount: widget.model.listmeme.length,
                          ),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            ///no.of items in the horizontal axis
                            crossAxisCount: 3,
                          ),
                        )
            ],
          ),
        ),
      );
    });
  }
}
