import 'package:flutter/material.dart';
import 'package:frontend_mobile_flutter/modules/participant/home/home_controller.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        leading: const BackButton(),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              // backgroundImage: NetworkImage('https://via.placeholder.com/150'), // Placeholder for user image
            ),
            const SizedBox(width: 12.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome,',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  'Participant', // Replace with actual user name from controller
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            )
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () {
              // Navigate to profile page or show a menu
            },
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 1,
        scrolledUnderElevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(height: 16.0),
            // Search field
            TextField(
              decoration: InputDecoration(
                hintText: 'Search event...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
              ),
            ),
            const SizedBox(height: 16.0),
            // Filter buttons
            Row(
              children: [
                Expanded(
                  child: Wrap(
                    spacing: 8.0,
                    runSpacing: 4.0,
                    children: <Widget>[
                      FilterChip(
                          label: const Text('All'),
                          onSelected: (bool value) {},
                          selected: true,
                          showCheckmark: false),
                      FilterChip(
                          label: const Text('Upcoming'),
                          onSelected: (bool value) {},
                          showCheckmark: false),
                      FilterChip(
                          label: const Text('Past Events'),
                          onSelected: (bool value) {},
                          showCheckmark: false),
                    ],
                  ),
                ),
                IconButton(
                    onPressed: () {}, icon: const Icon(Icons.filter_list))
              ],
            ),
            const SizedBox(height: 16.0),
            // List of cards
            Expanded(
              child: ListView.builder(
                itemCount: 5, // example count
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.only(bottom: 16.0),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                          child: Image.network(
                            'https://via.placeholder.com/400x200', // Placeholder image
                            width: double.infinity,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Event Title ${index + 1}',
                                  style:
                                      Theme.of(context).textTheme.titleLarge),
                              const SizedBox(height: 8.0),
                              Row(
                                children: const [
                                  Icon(Icons.calendar_today,
                                      size: 16, color: Colors.grey),
                                  SizedBox(width: 8),
                                  Text('Event Date'),
                                ],
                              ),
                              const SizedBox(height: 4.0),
                              Row(
                                children: const [
                                  Icon(Icons.location_on_outlined,
                                      size: 16, color: Colors.grey),
                                  SizedBox(width: 8),
                                  Text('Event Location'),
                                ],
                              ),
                              const SizedBox(height: 16.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Wrap(
                                    spacing: 8.0,
                                    children: [
                                      ElevatedButton(
                                          onPressed: () {},
                                          child: const Text('Register')),
                                      OutlinedButton(
                                          onPressed: () {},
                                          child: const Text('View Details')),
                                    ],
                                  ),
                                  IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.favorite_border))
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
