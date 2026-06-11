// Simple navigation constants
// All our app routes here
// Easy to use and remember!

import 'package:flutter/material.dart';
import '../features/feed/screens/feed_screen.dart';
import '../features/profile/screens/profile_screen.dart';
import '../features/chat/chat_screen.dart';
import '../features/rsvp/rsvp_screen.dart';
import '../features/rsvp/event_model.dart';

// Route names (like nicknames for our screens
class AppRoutes {
  static const String feed = '/';
  static const String profile = '/profile';
  static const String chat = '/chat';
  static const String rsvp = '/rsvp';
}

// Simple navigation functions to go to different screens
class AppNavigator {
  // Go to feed screen
  static void goToFeed(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.feed);
  }

  // Go to profile screen
  static void goToProfile(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.profile);
  }

  // Go to chat screen
  static void goToChat(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.chat);
  }

  // Go to RSVP screen for an event
  static void goToRsvp(BuildContext context, Event event) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RsvpScreen(event: event),
      ),
    );
  }
}
