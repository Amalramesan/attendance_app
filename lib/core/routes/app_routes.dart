import 'package:attendance_app/features/dashboard/view/dashboard_view.dart';
import 'package:attendance_app/features/leave/view/leave_view.dart';
import 'package:attendance_app/features/leave_list/view/leavelist_view.dart';
import 'package:attendance_app/features/login/view/login_view.dart';
import 'package:attendance_app/features/registration/view/registration_view.dart';
import 'package:attendance_app/features/route/route_view.dart';
import 'package:attendance_app/features/route/view/route_map_view.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  AppRoutes._();

  static final router = GoRouter(
    initialLocation: '/login',

    routes: [
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => LoginView(),
      ),

      GoRoute(
        path: '/registration',
        name: 'registration',
        builder: (context, state) => RegisterView(),
      ),

      GoRoute(
        path: '/dashboard',
        name: 'dashboard',
        builder: (context, state) => const DashboardView(),
      ),

      GoRoute(
        path: '/applyleave',
        name: 'applyleave',
        builder: (context, state) => const ApplyLeaveView(),
      ),
      GoRoute(
        path: '/leavelist',
        name: 'leavelist',
        builder: (context, state) => const LeaveListView(),
      ),
      GoRoute(
        path: '/routelist',
        name: 'routelist',
        builder: (context, state) => const RouteListView(),
      ),
      GoRoute(
  path: '/route-map',
  name: 'routeMap',
  builder: (context, state) {
    final data = state.extra as Map<String, double>;

    return RouteMapView(
      markInLat: data['markInLat']!,
      markInLng: data['markInLng']!,
      markOutLat: data['markOutLat']!,
      markOutLng: data['markOutLng']!,
    );
  },
),
    ],
  );
}
