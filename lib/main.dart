import 'package:flutter/material.dart';
import 'package:weather_app/router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/blocs/list_adress_cubit.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  final ListAdressCubit listAdressCubit = ListAdressCubit();

  listAdressCubit.getSavedAddresses();

  runApp(MultiProvider(
    providers: [
      BlocProvider<ListAdressCubit>(
        create: (_) => listAdressCubit,
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: AppRouter.routes,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRouter.homePage,
    );
  }
}
