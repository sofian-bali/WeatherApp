import 'package:flutter/material.dart';
import 'package:weather_app/blocs/home_cubit.dart';
import 'package:weather_app/blocs/week_cubit.dart';
import 'package:weather_app/router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/blocs/favory_cubit.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  final FavoryCubit favoryCubit = FavoryCubit();
  final HomeCubit homeCubit = HomeCubit();
  final WeekCubit weekCubit = WeekCubit();

  favoryCubit.getSavedAddresses();

  runApp(MultiProvider(
    providers: [
      BlocProvider<FavoryCubit>(
        create: (_) => favoryCubit,
      ),
      BlocProvider<HomeCubit>(
        create: (_) => homeCubit,
      ),
      BlocProvider<WeekCubit>(
        create: (_) => weekCubit,
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
