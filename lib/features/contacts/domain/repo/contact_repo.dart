import 'package:contacts_app/features/contacts/domain/entity/user.dart';

abstract class ContactRepo {
  Future<List<User>> getAllContacts();
}
