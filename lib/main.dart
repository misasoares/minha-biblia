import 'package:flutter/material.dart';
import 'data/app_database.dart';
import 'api/api_bible_client.dart';
import 'repositories/bible_repository.dart';
import 'stores/sync_store.dart';
import 'services/sync_service.dart';
import 'ui/manage_translations_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final api = ApiBibleClient();
    final db = AppDatabase();
    final repo = BibleRepository(db);
    final store = SyncStore();
    final service = SyncService(api: api, repo: repo, store: store);
    return MaterialApp(
      title: 'Minha Biblia',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 0, 170, 255),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.dark,
      home: ManageTranslationsScreen(
        api: api,
        repo: repo,
        store: store,
        service: service,
      ),
    );
  }
}
