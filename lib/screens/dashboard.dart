import 'package:flutter/material.dart';
import 'package:news_app/screens/all_posts.dart';
import 'package:news_app/screens/all_users.dart';

import '../model/count.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  CountData? countData;

  @override
  void initState() {
    super.initState();
  }

  void fetchData() async {
    try {
      countData = await CountData.fetchData();
      setState(() {}); // Update the UI after fetching the data
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    fetchData();
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Dashboard')),
      ),
      body: Column(
        children: [
          const Center(
              child: Text(
            "Welcom Admin",
            style: TextStyle(fontSize: 25),
          )),
          SizedBox(
            height: MediaQuery.of(context).size.height * .5,
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              padding: const EdgeInsets.all(10.0),
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (ctx) => const AllPosts()));
                  },
                  child: DashboardCard(
                    title: 'Total Posts: ${countData!.table1[0].totalPosts}',
                    icon: Icons.newspaper,
                    color: Colors.orange,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (ctx) => const AllUsers()));
                  },
                  child: DashboardCard(
                    title: 'Total Users: ${countData!.table2[0].totalUsers}',
                    icon: Icons.people,
                    color: Colors.green,
                  ),
                ),
                DashboardCard(
                  title: 'Total Cat 4',
                  icon: Icons.category,
                  color: Colors.red,
                ),
                DashboardCard(
                  title: 'Card 4',
                  icon: Icons.shopping_cart,
                  color: Colors.blue,
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Divider(height: 2, color: Colors.red),
          ),
        ],
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;

  DashboardCard({required this.title, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            icon,
            size: 30.0,
            color: Colors.white,
          ),
          const SizedBox(height: 10.0),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
