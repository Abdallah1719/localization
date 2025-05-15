import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization/core/local_data_source/cache_helper.dart';
import 'package:localization/generated/l10n.dart';
import 'package:localization/l10n/cubit/local_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LocaleCubit()..loadSavedLocale(),
      child: BlocBuilder<LocaleCubit, String>(
        builder: (context, locale) {
          return MaterialApp(
            localizationsDelegates: LocaleCubit.localizationsDelegates,
            supportedLocales: S.delegate.supportedLocales,
            title: 'Flutter Demo',
            theme: ThemeData(
              appBarTheme: AppBarTheme(
                backgroundColor: Color.fromARGB(255, 22, 136, 241),
              ),
            ),
            home: const HomePage(),
            locale: Locale(locale),
          );
        },
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).AppBarTitle)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(S.of(context).bodyText),
            SizedBox(height: 50),
            SizedBox(
              // width: 120,
              child: ElevatedButton(
                onPressed: () => context.read<LocaleCubit>().toggleLocale(),
                child: Row(
                  mainAxisSize: MainAxisSize.min,

                  children: [
                    Icon(Icons.language),
                    Padding(
                      padding: EdgeInsets.only(
                        right: LocaleCubit.isArabic() ? 16 : 0,
                        left: LocaleCubit.isArabic() ? 0 : 16,
                      ),
                    ),
                    Text(
                      context.watch<LocaleCubit>().state == 'en'
                          ? 'العربية'
                          : 'English',
                    ),
                  ],
                ),
              ),

              //  ElevatedButton(
              //   onPressed: () {},
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [Text('English'), Icon(Icons.language)],
              //   ),
              // ),
            ),
          ],
        ),
      ),
    );
  }
}
