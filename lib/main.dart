import 'package:flutter/material.dart';
import 'package:mapbox_implementation/ui/pages/home_page.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  String ACCESS_TOKEN = const String.fromEnvironment("ACCESS_TOKEN");
  MapboxOptions.setAccessToken(ACCESS_TOKEN);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mapbox Implementation App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
