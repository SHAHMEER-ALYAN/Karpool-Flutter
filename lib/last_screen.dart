import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Contact {
  final String name;
  final String phoneNumber;
  final String address;

  Contact({
    required this.name,
    required this.phoneNumber,
    required this.address,
  });
}

void main() {
  runApp(lastScreen());
}

class lastScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ContactListScreen(),
    );
  }
}

class ContactListScreen extends StatelessWidget {
  final List<Contact> contacts = [
    Contact(name: 'John Doe', phoneNumber: '+1234567890', address: '123 Main St'),
    // Add more contacts here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact List'),
      ),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          final contact = contacts[index];
          return ContactCard(contact: contact);
        },
      ),
    );
  }
}

class ContactCard extends StatelessWidget {
  final Contact contact;

  ContactCard({required this.contact});

  void _launchWhatsApp() async {
    final url = 'https://api.whatsapp.com/send?phone=${contact.phoneNumber}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch WhatsApp';
    }
  }

  void _launchPhoneCall() async {
    final url = 'tel:${contact.phoneNumber}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch phone call';
    }
  }

  void _launchSms() async {
    final url = 'sms:${contact.phoneNumber}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch SMS';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${contact.name}'),
            Text('Phone Number: ${contact.phoneNumber}'),
            Text('Address: ${contact.address}'),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Icon(Icons.call),
                  onPressed: _launchPhoneCall,
                ),
                IconButton(
                  icon: Icon(Icons.message),
                  onPressed: _launchSms,
                ),
                IconButton(
                  icon: Icon(Icons.message),
                  onPressed: _launchWhatsApp,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
