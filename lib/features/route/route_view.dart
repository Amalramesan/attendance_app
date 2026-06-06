import 'package:attendance_app/features/route/data/provider/route_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'view/widgets/route_card_widget.dart';

class RouteListView extends StatefulWidget {
  const RouteListView({super.key});

  @override
  State<RouteListView> createState() => _RouteListViewState();
}

class _RouteListViewState extends State<RouteListView> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<RouteProvider>().fetchRoutes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Route')),

      body: Consumer<RouteProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final routes = provider.routeResponse?.routeList ?? [];

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: routes.length,
            itemBuilder: (context, index) {
              final route = routes[index];

              return RouteCard(
                date: route.date,
                markIn: route.markIn,
                markOut: route.markOut,

                onTap: () {
                  print(route.markInLocation.latitude);
                  print(route.markInLocation.longitude);

                  print(route.markOutLocation.latitude);
                  print(route.markOutLocation.longitude);
                  context.pushNamed(
                    'routeMap',
                    extra: {
                      'markInLat': double.parse(route.markInLocation.latitude),
                      'markInLng': double.parse(route.markInLocation.longitude),
                      'markOutLat': double.parse(
                        route.markOutLocation.latitude,
                      ),
                      'markOutLng': double.parse(
                        route.markOutLocation.longitude,
                      ),
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
