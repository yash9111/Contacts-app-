import 'package:contacts_app/features/contacts/domain/entity/user.dart';
import 'package:contacts_app/features/contacts/presentation/widgets/info_row.dart';
import 'package:contacts_app/features/contacts/presentation/widgets/user_info_card.dart';
import 'package:flutter/material.dart';

class UserDetailScreen extends StatelessWidget {
  final User user;

  const UserDetailScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.name),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserInfoCard(
              title: "Personal Information",
              children: [
                InfoRow(label: "Name", value: user.name),
                InfoRow(label: "Username", value: user.username),
                InfoRow(label: "Email", value: user.email),
                InfoRow(label: "Phone", value: user.phone),
                InfoRow(label: "Website", value: user.website),
              ],
            ),
            const SizedBox(height: 16.0),

            UserInfoCard(
              title: "Address",
              children: [
                InfoRow(label: "Street", value: user.address.street),
                InfoRow(label: "Suite", value: user.address.suite),
                InfoRow(label: "City", value: user.address.city),
                InfoRow(label: "Zipcode", value: user.address.zipcode),
                InfoRow(
                  label: "Geo",
                  value:
                      "Lat: ${user.address.geo.lat}, Lng: ${user.address.geo.lng}",
                ),
              ],
            ),
            const SizedBox(height: 16.0),

            UserInfoCard(
              title: "Company",
              children: [
                InfoRow(label: "Name", value: user.company.name),
                InfoRow(label: "CatchPhrase", value: user.company.catchPhrase),
                InfoRow(label: "Business", value: user.company.bs),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
