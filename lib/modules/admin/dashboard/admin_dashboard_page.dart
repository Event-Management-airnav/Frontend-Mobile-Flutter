import 'package:flutter/material.dart';

/// A dashboard page for the admin side of the Event Management app.
///
/// This page mirrors the design shown in the provided screenshot. It features a
/// custom header with the application name and organization name, a set of
/// summary cards indicating event statuses, and a bottom navigation bar. The
/// layout uses standard Flutter widgets and does not depend on any third-party
/// packages.
class AdminDashboardPage extends StatefulWidget {
  const AdminDashboardPage({Key? key}) : super(key: key);

  @override
  State<AdminDashboardPage> createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage> {
  // Index of the currently selected bottom navigation item.
  int _currentIndex = 0;

  // A list of dummy page titles for demonstration purposes. In a real
  // application, these would correspond to different pages or views.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F8),
      // A custom app bar is used here instead of the default AppBar widget to
      // achieve the design shown in the screenshot. The height is increased
      // slightly and the background is white, with a logo and notification icon.
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              // Leading icon to represent the app or organization. In the
              // original design this would be the Airnav Indonesia logo; here
              // we use a generic event icon as a placeholder.
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.event,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(width: 12),
              // Title and subtitle for the app name and organization.
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Event Management',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Airnav Indonesia',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              // Notification icon aligned to the far right.
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.notifications,
                  color: Colors.orange,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            // First card: Event Coming Soon
            _buildStatusCard(
              icon: Icons.calendar_today,
              iconBackground: Colors.blue.shade50,
              iconColor: Colors.blue,
              count: 67,
              title: 'Event Coming Soon',
            ),
            const SizedBox(height: 16),
            // Second card: Event OnGoing
            _buildStatusCard(
              icon: Icons.arrow_forward,
              iconBackground: Colors.yellow.shade50,
              iconColor: Colors.amber,
              count: 67,
              title: 'Event OnGoing',
            ),
            const SizedBox(height: 16),
            // Third card: Event Close
            _buildStatusCard(
              icon: Icons.block,
              iconBackground: Colors.red.shade50,
              iconColor: Colors.red,
              count: 67,
              title: 'Event Close',
            ),
          ],
        ),
      ),
      // A simple BottomNavigationBar to navigate between pages. Only three
      // items are provided here: Dashboard, Acara (Events), and Profile.
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'Acara',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  /// Builds a card that displays the status of events along with an icon and
  /// count. Each card has a colored icon container, a large count, and a
  /// descriptive label.
  Widget _buildStatusCard({
    required IconData icon,
    required Color iconBackground,
    required Color iconColor,
    required int count,
    required String title,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          // Icon container
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: iconBackground,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: iconColor,
            ),
          ),
          const SizedBox(width: 16),
          // Count displayed prominently
          Text(
            '$count',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 16),
          // Event status label
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
