import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:uni/controller/local_storage/app_shared_preferences.dart';
import 'package:uni/controller/on_start_up.dart';
import 'package:uni/model/providers/bus_stop_provider.dart';
import 'package:uni/model/providers/calendar_provider.dart';
import 'package:uni/model/providers/exam_provider.dart';
import 'package:uni/model/providers/faculty_locations_provider.dart';
import 'package:uni/model/providers/favorite_cards_provider.dart';
import 'package:uni/model/providers/home_page_editing_mode_provider.dart';
import 'package:uni/model/providers/last_user_info_provider.dart';
import 'package:uni/model/providers/lecture_provider.dart';
import 'package:uni/model/providers/library_occupation_provider.dart';
import 'package:uni/model/providers/profile_state_provider.dart';
import 'package:uni/model/providers/restaurant_provider.dart';
import 'package:uni/model/providers/session_provider.dart';
import 'package:uni/model/providers/state_providers.dart';
import 'package:uni/model/providers/user_faculties_provider.dart';
import 'package:uni/utils/drawer_items.dart';
import 'package:uni/view/about/about.dart';
import 'package:uni/view/bug_report/bug_report.dart';
import 'package:uni/view/bus_stop_next_arrivals/bus_stop_next_arrivals.dart';
import 'package:uni/view/calendar/calendar.dart';
import 'package:uni/view/common_widgets/page_transition.dart';
import 'package:uni/view/course_units/course_units.dart';
import 'package:uni/view/exams/exams.dart';
import 'package:uni/view/home/home.dart';
import 'package:uni/view/locations/locations.dart';
import 'package:uni/view/logout_route.dart';
import 'package:uni/view/navigation_service.dart';
import 'package:uni/view/library/library.dart';
import 'package:uni/view/restaurant/restaurant_page_view.dart';
import 'package:uni/view/schedule/schedule.dart';
import 'package:uni/view/splash/splash.dart';
import 'package:uni/view/theme.dart';
import 'package:uni/view/theme_notifier.dart';
import 'package:uni/view/useful_info/useful_info.dart';

SentryEvent? beforeSend(SentryEvent event) {
  return event.level == SentryLevel.info ? event : null;
}

Future<void> main() async {
  final stateProviders = StateProviders(
      LectureProvider(),
      ExamProvider(),
      BusStopProvider(),
      RestaurantProvider(),
      ProfileStateProvider(),
      SessionProvider(),
      CalendarProvider(),
      LibraryOccupationProvider(),
      FacultyLocationsProvider(),
      LastUserInfoProvider(),
      UserFacultiesProvider(),
      FavoriteCardsProvider(),
      HomePageEditingModeProvider());

  OnStartUp.onStart(stateProviders.sessionProvider);
  WidgetsFlutterBinding.ensureInitialized();
  final savedTheme = await AppSharedPreferences.getThemeMode();
  await SentryFlutter.init((options) {
    options.dsn =
        'https://a2661645df1c4992b24161010c5e0ecb@o553498.ingest.sentry.io/5680848';
  },
      appRunner: () => {
            runApp(MultiProvider(
                providers: [
                  ChangeNotifierProvider(
                      create: (context) => stateProviders.lectureProvider),
                  ChangeNotifierProvider(
                      create: (context) => stateProviders.examProvider),
                  ChangeNotifierProvider(
                      create: (context) => stateProviders.busStopProvider),
                  ChangeNotifierProvider(
                      create: (context) => stateProviders.restaurantProvider),
                  ChangeNotifierProvider(
                      create: (context) => stateProviders.profileStateProvider),
                  ChangeNotifierProvider(
                      create: (context) => stateProviders.sessionProvider),
                  ChangeNotifierProvider(
                      create: (context) => stateProviders.calendarProvider),
                  ChangeNotifierProvider(
                      create: (context) =>
                          stateProviders.libraryOccupationProvider),
                  ChangeNotifierProvider(
                      create: (context) =>
                          stateProviders.facultyLocationsProvider),
                  ChangeNotifierProvider(
                      create: (context) => stateProviders.lastUserInfoProvider),
                  ChangeNotifierProvider(
                      create: (context) =>
                          stateProviders.userFacultiesProvider),
                  ChangeNotifierProvider(
                      create: (context) =>
                          stateProviders.favoriteCardsProvider),
                  ChangeNotifierProvider(
                      create: (context) => stateProviders.homePageEditingMode),
                ],
                child: ChangeNotifierProvider<ThemeNotifier>(
                  create: (_) => ThemeNotifier(savedTheme),
                  child: const MyApp(),
                )))
          });
}

/// Manages the state of the app
///
/// This class is necessary to track the app's state for
/// the current execution
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => MyAppState();
}

/// Manages the app depending on its current state
class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, _) => MaterialApp(
          title: 'uni',
          theme: applicationLightTheme,
          darkTheme: applicationDarkTheme,
          themeMode: themeNotifier.getTheme(),
          home: const SplashScreen(),
          navigatorKey: NavigationService.navigatorKey,
          onGenerateRoute: (RouteSettings settings) {
            final Map<String, Route<dynamic>> transitions = {
              '/${DrawerItem.navPersonalArea.title}':
                  PageTransition.makePageTransition(
                      page: const HomePageView(), settings: settings),
              '/${DrawerItem.navSchedule.title}':
                  PageTransition.makePageTransition(
                      page: const SchedulePage(), settings: settings),
              '/${DrawerItem.navExams.title}':
                  PageTransition.makePageTransition(
                      page: const ExamsPageView(), settings: settings),
              '/${DrawerItem.navStops.title}':
                  PageTransition.makePageTransition(
                      page: const BusStopNextArrivalsPage(),
                      settings: settings),
              '/${DrawerItem.navCourseUnits.title}':
                  PageTransition.makePageTransition(
                      page: const CourseUnitsPageView(), settings: settings),
              '/${DrawerItem.navLocations.title}':
                  PageTransition.makePageTransition(
                      page: const LocationsPage(), settings: settings),
              '/${DrawerItem.navRestaurants.title}':
                  PageTransition.makePageTransition(
                      page: const RestaurantPageView(), settings: settings),
              '/${DrawerItem.navCalendar.title}':
                  PageTransition.makePageTransition(
                      page: const CalendarPageView(), settings: settings),
              '/${DrawerItem.navLibrary.title}':
                  PageTransition.makePageTransition(
                      page: const LibraryPageView(), settings: settings),
              '/${DrawerItem.navUsefulInfo.title}':
                  PageTransition.makePageTransition(
                      page: const UsefulInfoPageView(), settings: settings),
              '/${DrawerItem.navAbout.title}':
                  PageTransition.makePageTransition(
                      page: const AboutPageView(), settings: settings),
              '/${DrawerItem.navBugReport.title}':
                  PageTransition.makePageTransition(
                      page: const BugReportPageView(),
                      settings: settings,
                      maintainState: false),
              '/${DrawerItem.navLogOut.title}': LogoutRoute.buildLogoutRoute()
            };

            return transitions[settings.name];
          }),
    );
  }
}
