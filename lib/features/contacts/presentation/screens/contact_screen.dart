import 'package:contacts_app/features/contacts/domain/entity/user.dart';
import 'package:contacts_app/features/contacts/presentation/bloc/contact_bloc.dart';
import 'package:contacts_app/features/contacts/presentation/screens/user_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  List<User> contacts = [];
  List<User> filteredContacts = [];
  List<User> selectedContacts = [];  
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ContactBloc>().add(GetAllContacts());
    searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    searchController.removeListener(_onSearchChanged);
    searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = searchController.text.toLowerCase();
    setState(() {
      filteredContacts = contacts.where((contact) {
        return contact.name.toLowerCase().contains(query) ||
            contact.email.toLowerCase().contains(query);
      }).toList();
    });
  }

  Future<void> _refreshContacts() async {
    context.read<ContactBloc>().add(GetAllContacts());
  }

  void _onContactLongPress(User contact) {
    setState(() {
      if (!selectedContacts.contains(contact)) {
        selectedContacts.add(contact);    }
    });
  }

  void _toggleSelection(User contact) {
    setState(() {
      if (selectedContacts.contains(contact)) {
        selectedContacts.remove(contact); 
      } else {
        selectedContacts.add(contact);  
      }
    });
  }

  void _deleteSelectedContacts() {
    setState(() {
      contacts.removeWhere((contact) => selectedContacts.contains(contact));
      filteredContacts.removeWhere((contact) => selectedContacts.contains(contact));
      selectedContacts.clear(); 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        actions: [
          if (selectedContacts.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: _deleteSelectedContacts,
            ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: ContactSearchDelegate(contacts),
              );
            },
          ),
        ],
      ),
      body: BlocConsumer<ContactBloc, ContactState>(
        listener: (context, state) {
          if (state is ContactsFetched) {
            contacts = state.contacts;
            filteredContacts = contacts;
          }
          if (state is ApiFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  "Something went wrong",
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is ContactsLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.blueAccent,
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: _refreshContacts,
            color: Colors.blueAccent,
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: filteredContacts.length,
              itemBuilder: (context, index) {
                final contact = filteredContacts[index];
                return GestureDetector(
                  onTap: () {
                    if (selectedContacts.isEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserDetailScreen(user: contact),
                        ),
                      );
                    } else {
                      _toggleSelection(contact); 
                    }
                  },
                  onLongPress: () => _onContactLongPress(contact),
                  child: Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16.0),
                      leading: CircleAvatar(
                        backgroundColor: Colors.blueAccent,
                        child: Text(
                          contact.name[0],
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      title: Text(
                        contact.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                      subtitle: Text(
                        contact.email,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14.0,
                        ),
                      ),
                      trailing: selectedContacts.contains(contact)
                          ? const Icon(
                              Icons.check_circle,
                              color: Colors.blueAccent,
                            )
                          : null,  
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class ContactSearchDelegate extends SearchDelegate {
  final List<User> contacts;

  ContactSearchDelegate(this.contacts);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = contacts.where((contact) {
      return contact.name.toLowerCase().contains(query.toLowerCase()) ||
          contact.email.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final contact = results[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.blueAccent,
            child: Text(
              contact.name[0],
              style: const TextStyle(color: Colors.white),
            ),
          ),
          title: Text(contact.name),
          subtitle: Text(contact.email),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UserDetailScreen(user: contact),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = contacts.where((contact) {
      return contact.name.toLowerCase().contains(query.toLowerCase()) ||
          contact.email.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final contact = suggestions[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.blueAccent,
            child: Text(
              contact.name[0],
              style: const TextStyle(color: Colors.white),
            ),
          ),
          title: Text(contact.name),
          subtitle: Text(contact.email),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UserDetailScreen(user: contact),
            ),
          ),
        );
      },
    );
  }
}
