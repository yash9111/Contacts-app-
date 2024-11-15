part of 'contact_bloc.dart';

sealed class ContactState {}

final class ContactInitial extends ContactState {}

class ContactsFetched extends ContactState {
  final List<User> contacts;

  ContactsFetched({required this.contacts});
}

class ContactsLoading extends ContactState {}

class ApiFailure extends ContactState {
  final String error;

  ApiFailure({required this.error});
}
