import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restouran_app/provider/scheduling_provider.dart';

class RestaurantSettingPage extends StatelessWidget {
  const RestaurantSettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text('Scheduling News'),
        trailing:
            Consumer<SchedulingProvider>(builder: (context, scheduled, _) {
          return Switch.adaptive(
            value: scheduled.isScheduled,
            onChanged: (value) async {
              scheduled.scheduledNews(value);
            },
          );
        }));
  }
}
