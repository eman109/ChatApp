import 'package:chat/features/auth/presentation/view/screens/login_screen.dart';
import 'package:chat/features/auth/presentation/view/screens/register_screen.dart';
import 'package:chat/features/contacts/presentation/views/screens/contacts.dart';
import 'package:chat/features/details/presentation/views/details_screen.dart';
import 'package:chat/features/room/data/model/rooms_model.dart';
import 'package:chat/features/room/presentation/views/screens/chat_screen.dart';
import 'package:chat/features/room/presentation/views/screens/room_screen.dart';
import 'package:chat/features/splash/presentation/views/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RouterGeneration {
  static const String splash = "/splash";
  static const String login = "/login";
  static const String register = "/register";
  static const String contacts = "/contacts";
  static const String details = "/details";
  static const String room = "/room";
  static const String chat = "/chat";

  static GoRouter goRouter = GoRouter(
    initialLocation: register,
    routes: [
      GoRoute(
        path: splash,
        builder: (context, state) {
          return SplashScreen();
        },
      ),
      GoRoute(
        path: register,
        builder: (context, state) {
          return RegisterScreen();
        },
      ),
      GoRoute(
        path: login,
        builder: (context, state) {
          return LoginScreen();
        },
      ),
      GoRoute(
        path: contacts,
        builder: (context, state) {
          return Contacts();
        },
      ),
      GoRoute(
        path: details,
        builder: (context, state) {
          return DetailsScreen();
        },
      ),
      GoRoute(
        path: room,
        builder: (context, state) {
          return RoomScreen();
        },
      ),
      GoRoute(
        path: chat,
        builder: (context, state) {
          final room = state.extra as RoomsModel;
          return ChatScreen(room: room);
        },
      ),
    ],
    debugLogDiagnostics: true,
    errorPageBuilder:
        (context, state) => MaterialPage(
          child: Scaffold(body: Center(child: Text("Page Not Found"))),
        ),
  );
}
