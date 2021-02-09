import 'package:algostudio_test/utils/module.dart';

class Component {
  static AppBar appBar() => AppBar(
        centerTitle: true,
        title: Text("MimGenerator"),
      );
  static Material primaryButton({
    @required VoidCallback onPressed,
    @required String text,
    @required BuildContext context,
  }) =>
      Material(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(4.0),
          child: MaterialButton(
            //minWidth: MediaQuery.of(context).size.width / 3,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                // fontWeight: FontWeight.bold,
                // fontSize: 10.0
              ),
            ),
            onPressed: onPressed,
          ));
}
