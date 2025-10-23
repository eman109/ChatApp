import 'package:chat/core/routing/routing_generation.dart';
import 'package:chat/core/service_locator/service_locator.dart';
import 'package:chat/features/auth/presentation/view_model/cubit/auth_cubit.dart';
import 'package:chat/features/contacts/presentation/cubit/contacts_cubit.dart';
import 'package:chat/features/details/presentation/cubit/details_cubit.dart';
import 'package:chat/features/room/presentation/cubit/message_cubit.dart';
import 'package:chat/features/room/presentation/cubit/room_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setUpServiceLocator();
  await dotenv.load(fileName: ".env");
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getit<AuthCubit>()),
        BlocProvider(
          create: (context) => getit<ContactsCubit>()..fetchContact(),
        ),
        BlocProvider(create: (context) => getit<DetailsCubit>()..getMyInfo()),
        BlocProvider(create: (context) => getit<RoomCubit>()),
        BlocProvider(create: (context) => getit<MessageCubit>()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(390, 844),
      builder: (context, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          // locale: context.locale,
          // supportedLocales: context.supportedLocales,
          // localizationsDelegates: context.localizationDelegates,
          title: "PWS",
          // theme: //mythemestl.whatever,
          routerConfig: RouterGeneration.goRouter,
        );
      },
    );
  }
}
