import 'package:chain_arithmetics/gen/strings.g.dart';
import 'package:chain_arithmetics/pages/guess_operators/home.dart';
import 'package:chain_arithmetics/pages/operations/home.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  LocaleSettings.useDeviceLocale();
  runApp(TranslationProvider(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chain arithmetics',
      locale: TranslationProvider.of(context).flutterLocale,
      supportedLocales: AppLocaleUtils.supportedLocales,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _gotoStandardExercisesPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx2) {
          return StandardExercisesHomePage();
        },
      ),
    );
  }

  void _gotoGuessOperatorExercisesPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx2) {
          return GuessOperatorHomePage();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(t.pages.home.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 15,
          children: [
            ElevatedButton(
              onPressed: () => _gotoStandardExercisesPage(context),
              child: Text(t.pages.home.buttons.standard_exercises),
            ),
            ElevatedButton(
              onPressed: () => _gotoGuessOperatorExercisesPage(context),
              child: Text(t.pages.home.buttons.guess_operator),
            ),
          ],
        ),
      ),
    );
  }
}
