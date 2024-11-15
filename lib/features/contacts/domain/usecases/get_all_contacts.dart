import 'package:contacts_app/features/contacts/domain/entity/user.dart';
import 'package:contacts_app/features/contacts/domain/repo/contact_repo.dart';

class GetAllContactsUsecase {
  final ContactRepo contactRepo;

  GetAllContactsUsecase({required this.contactRepo});
  Future<List<User>> call() {
    return contactRepo.getAllContacts();
  }
}
