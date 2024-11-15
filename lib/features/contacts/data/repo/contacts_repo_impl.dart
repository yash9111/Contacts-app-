import 'package:contacts_app/features/contacts/data/sources/contacts_remote_datasource.dart';
import 'package:contacts_app/features/contacts/domain/entity/user.dart';
import 'package:contacts_app/features/contacts/domain/repo/contact_repo.dart';

class ContactsRepoImpl implements ContactRepo {
  final ContactsRemoteDatasource contactsRemoteDatasource;

  ContactsRepoImpl({required this.contactsRemoteDatasource});
  @override
  Future<List<User>> getAllContacts() {
    return contactsRemoteDatasource.getAllContacts();
  }
}
