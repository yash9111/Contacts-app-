import 'package:contacts_app/features/contacts/domain/entity/user.dart';
import 'package:contacts_app/features/contacts/domain/usecases/get_all_contacts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'contact_event.dart';
part 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  final GetAllContactsUsecase getAllContactsUsecase;
  ContactBloc({required this.getAllContactsUsecase}) : super(ContactInitial()) {
    on<ContactEvent>((event, emit) {
      emit(ContactsLoading());
    });

    on<GetAllContacts>(
      (event, emit) async {
        try {
          final contacts = await getAllContactsUsecase();
          emit(ContactsFetched(contacts: contacts));
        } catch (e) {
          emit(ApiFailure(error: e.toString()));
        }
      },
    );
  }
}
