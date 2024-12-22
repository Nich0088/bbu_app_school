import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/src/common/helpers/local_storage.dart';
import 'package:school_app/src/common/app_setting.dart';
import 'package:school_app/src/core/auth/login/screen/login_screen.dart';
import 'package:school_app/src/core/auth/role_selection/screen/role_selection_screen.dart';
import 'package:school_app/src/core/splash_screen/screen/splash_screen.dart';
import 'package:school_app/src/modules/about_us/screen/about_us_screen.dart';
import 'package:school_app/src/modules/apply/screen/apply_screen.dart';
import 'package:school_app/src/modules/attendant/screen/attendant_screen.dart';
import 'package:school_app/src/modules/calendar/screen/calendar_screen.dart';
import 'package:school_app/src/modules/campus/screen/campus_screen.dart';
import 'package:school_app/src/modules/contact/screen/contact_screen.dart';
import 'package:school_app/src/modules/dashboard/models/certificate_format_item.dart';
import 'package:school_app/src/modules/dashboard/models/language.dart';
import 'package:school_app/src/modules/dashboard/models/user_type.dart';
import 'package:school_app/src/modules/dashboard/screen/certificate_format_screen.dart';
import 'package:school_app/src/modules/dashboard/screen/dashboard_screen.dart';
import 'package:school_app/src/modules/event/models/event_new_data.dart';
import 'package:school_app/src/modules/event/screen/event_detail_screen.dart';
import 'package:school_app/src/modules/event/screen/events_screen.dart';
import 'package:school_app/src/modules/location/screen/location_screen.dart';
import 'package:school_app/src/modules/registration_application/screen/registration_application_screen.dart';
import 'package:school_app/src/modules/scholarship/screen/scholarship_screen.dart';
import 'package:school_app/src/modules/user_dashboard/screen/user_dashboard_screen.dart';
import 'package:school_app/src/modules/video/screen/video_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await LocalStorage.init();

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('km', 'KH'),
      ],
      startLocale: const Locale('en', 'US'),
      fallbackLocale: const Locale('en', 'US'),
      path: 'assets/translations',
      child: const MyApp(),
    ),
  );
}

final GoRouter _goRouter = GoRouter(
  initialLocation: AppScreen.splashScreen.path,
  routes: [
    GoRoute(
      path: AppScreen.dashboardScreen.path,
      builder: (context, state) {
        final UserType? userType = state.extra as UserType?;
        return DashboardScreen(userType: userType);
      },
    ),
    GoRoute(
      path: AppScreen.splashScreen.path,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: AppScreen.roleSelectionScreen.path,
      builder: (context, state) => const RoleSelectionScreen(),
    ),
    GoRoute(
      path: AppScreen.loginScreen.path,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: AppScreen.scholarshipScreen.path,
      builder: (context, state) => const ScholarshipScreen(),
    ),
    GoRoute(
      path: AppScreen.aboutUsScreen.path,
      builder: (context, state) => const AboutUsScreen(),
    ),
    GoRoute(
      path: AppScreen.eventsScreen.path,
      builder: (context, state) => const EventsScreen(),
    ),
    GoRoute(
      path: AppScreen.contactScreen.path,
      builder: (context, state) => const ContactScreen(),
    ),
    GoRoute(
      path: AppScreen.locationScreen.path,
      builder: (context, state) => const LocationScreen(),
    ),
    GoRoute(
      path: AppScreen.userDashboardScreen.path,
      builder: (context, state) => const UserDashboardScreen(),
    ),
    GoRoute(
      path: AppScreen.registrationApplicationScreen.path,
      builder: (context, state) => const RegistrationApplicationScreen(),
    ),
    GoRoute(
      path: AppScreen.campusScreen.path,
      builder: (context, state) => const CampusScreen(),
    ),
    GoRoute(
      path: AppScreen.videoScreen.path,
      builder: (context, state) => const VideoScreen(),
    ),
    GoRoute(
      path: AppScreen.applyScreen.path,
      builder: (context, state) => const ApplyScreen(),
    ),
    GoRoute(
      path: AppScreen.calendarScreen.path,
      builder: (context, state) => const CalendarScreen(),
    ),
    GoRoute(
      path: AppScreen.attendantScreen.path,
      builder: (context, state) => const AttendantScreen(),
    ),
    GoRoute(
      path: AppScreen.eventDetailScreen.path,
      builder: (context, state) {
        final EventData? eventData = state.extra as EventData?;
        return EventDetailScreen(
          eventData: eventData,
        );
      },
    ),
    GoRoute(
      path: AppScreen.certificateFormatScreen.path,
      builder: (context, state) {
        final CertificateFormatItem? certificateFormatItem =
            state.extra as CertificateFormatItem?;
        return CertificateFormatScreen(
          certificateFormatItem: certificateFormatItem,
        );
      },
    ),
  ],
);

enum AppScreen {
  dashboardScreen("/"),
  splashScreen("/splash"),
  roleSelectionScreen("/role-selection"),
  loginScreen("/login"),
  contactScreen("/contact-screen"),
  scholarshipScreen("/scholarship"),
  aboutUsScreen("/about-us"),
  eventsScreen("/events"),
  userDashboardScreen("/user-dashboard"),
  registrationApplicationScreen("/registration-application"),
  locationScreen("/location"),
  campusScreen("/campus"),
  videoScreen("/video"),
  applyScreen("/apply"),
  calendarScreen("/calendar"),
  attendantScreen("/attendant"),
  certificateFormatScreen("/certificateFormat"),
  eventDetailScreen("/event-detail");

  final String path;

  const AppScreen(this.path);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      routerConfig: _goRouter,
      theme: ThemeData(
        fontFamily:
            Language.getLanguage(languageKey: context.locale.languageCode) ==
                    Language.english
                ? 'sourceSansThree'
                : 'notoSansKhmer',
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: AppColor.textPrimaryColor),
          backgroundColor: Colors.white,
          elevation: 5,
          shadowColor: Color(0x1A000000),
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 16,
            color: AppColor.textPrimaryColor,
          ),
        ),
        iconTheme: const IconThemeData(color: AppColor.textPrimaryColor),
        primaryColor: AppColor.primaryColor,
        cardColor: AppColor.cardColor,
        disabledColor: AppColor.textPrimaryColor,
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 26,
            color: AppColor.textPrimaryColor,
          ),
          displayMedium: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 24,
            color: AppColor.textPrimaryColor,
          ),
          displaySmall: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 22,
            color: AppColor.textPrimaryColor,
          ),
          headlineMedium: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 20,
            color: AppColor.textPrimaryColor,
          ),
          headlineSmall: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 18,
            color: AppColor.textPrimaryColor,
          ),
          titleLarge: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 16,
            color: AppColor.textPrimaryColor,
          ),
          bodyLarge: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: AppColor.textPrimaryColor,
          ),
          bodyMedium: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 12,
            color: AppColor.textPrimaryColor,
          ),
          bodySmall: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 10,
            color: AppColor.textPrimaryColor,
          ),
        ),
      ),
    );
  }
}
