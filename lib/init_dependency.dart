import 'package:contacts_app/features/contacts/data/repo/contacts_repo_Impl.dart';
import 'package:contacts_app/features/contacts/data/sources/contacts_remote_datasource.dart';
import 'package:contacts_app/features/contacts/domain/repo/contact_repo.dart';
import 'package:contacts_app/features/contacts/domain/usecases/get_all_contacts.dart';
import 'package:contacts_app/features/contacts/presentation/bloc/contact_bloc.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;
void init() {
  serviceLocator.registerLazySingleton<ContactsRemoteDatasource>(
    () => ContactsRemoteDatasource());

  serviceLocator.registerFactory<ContactRepo>(
      () => ContactsRepoImpl(contactsRemoteDatasource: serviceLocator()));

  serviceLocator.registerFactory(
      () => GetAllContactsUsecase(contactRepo: serviceLocator()));

  serviceLocator.registerLazySingleton<ContactBloc>(
      () => ContactBloc(getAllContactsUsecase: serviceLocator()));
}

