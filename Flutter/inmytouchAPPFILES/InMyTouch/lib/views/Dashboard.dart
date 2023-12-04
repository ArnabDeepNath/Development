import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Image.asset(
          'assets/logo/logo.png',
          height: 144,
          width: 144,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              color: Colors.blueAccent,
            ),
          ),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(85),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.home,
                        size: 38,
                        color: Colors.blueAccent,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.people,
                        size: 38,
                        color: Colors.blueAccent,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.person,
                        size: 38,
                        color: Colors.blueAccent,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.call,
                        size: 38,
                        color: Colors.blueAccent,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.menu,
                        size: 38,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ],
                ),
              ),
              // ListView Builder goes Here
              NotificationWidget(
                NotificationName: 'WhatsApp Call',
                Time: '10:01 PM',
                Location: 'Delhi',
                URL:
                    'https://images.unsplash.com/photo-1603112579965-e24332cc453a?auto=format&fit=crop&q=80&w=2070&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
              ),
              NotificationWidget(
                NotificationName: 'Normal Call',
                Time: '9:45 PM',
                Location: 'Near Manoj Cafe , South Delhi',
                URL:
                    'https://images.unsplash.com/photo-1542491218-cdf4a1eb1e0e?auto=format&fit=crop&q=80&w=1874&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
              ),
              NotificationWidget(
                NotificationName: 'WhatsApp Message',
                Time: '6:01 PM',
                Location: 'Metro Cafe ,Delhi',
                URL:
                    'https://images.unsplash.com/photo-1612000529646-f424a2aa1bff?auto=format&fit=crop&q=80&w=2070&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
              ),
              NotificationWidget(
                NotificationName: 'Normal Message',
                Time: '5:55 AM',
                Location: 'IITG , Guwahati',
                URL:
                    'https://images.unsplash.com/photo-1566396084807-d74c3e84b48f?auto=format&fit=crop&q=80&w=2070&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NotificationWidget extends StatelessWidget {
  String NotificationName;
  String Time;
  String Location;
  String URL;
  NotificationWidget({
    super.key,
    required this.NotificationName,
    required this.Time,
    required this.Location,
    required this.URL,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Container(
          height: 200,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    '$Time ',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '| $Location |',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    NotificationName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Image(
                image: NetworkImage('$URL'),
                height: 150,
              ),
              const Divider()
            ],
          ),
        ),
      ),
    );
  }
}
