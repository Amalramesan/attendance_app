import 'package:attendance_app/core/common_widgets/snackbar.dart';
import 'package:attendance_app/features/route/data/provider/route_provider.dart';
import 'package:attendance_app/features/route/view/widgets/route_search_field_widget.dart';
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

    final routeProvider = context.read<RouteProvider>();
    Future.microtask(() async {
      await routeProvider.fetchRoutes();
      if (!mounted) return;
      final error = routeProvider.errorMessage;
      if (error != null) {
        AppSnackbar.showError(context, error);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEEF2F1),
      appBar: AppBar(
        backgroundColor: const Color(0xffEEF2F1),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Image.asset('assets/icons/profile icon.png', height: 30),
          ),
        ],
      ),

      body: Consumer<RouteProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final routes = provider.routeResponse?.routeList ?? [];

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "My Route",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 20),

                const RouteSearchField(),

                const SizedBox(height: 20),

                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: routes.length,
                  itemBuilder: (context, index) {
                    final route = routes[index];

                    return RouteCard(
                      date: route.date,
                      markIn: route.markIn,
                      markOut: route.markOut,
                      onTap: () {
                        context.pushNamed(
                          'routeMap',
                          extra: {
                            'markInLat':
                                double.tryParse(
                                  route.markInLocation.latitude,
                                ) ??
                                0.0,
                            'markInLng':
                                double.tryParse(
                                  route.markInLocation.longitude,
                                ) ??
                                0.0,
                            'markOutLat':
                                double.tryParse(
                                  route.markOutLocation.latitude,
                                ) ??
                                0.0,
                            'markOutLng':
                                double.tryParse(
                                  route.markOutLocation.longitude,
                                ) ??
                                0.0,
                          },
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
