import 'package:algostudio_test/utils/module.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AlgoScoped model = new AlgoScoped();
  @override
  Widget build(BuildContext context) {
    return ScopedModel<AlgoScoped>(
      model: model,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "AlgoStudio",
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Home(model: model),
      ),
    );
  }
}
