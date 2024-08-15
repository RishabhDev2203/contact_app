import 'package:contact_app/sqlite/database_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../dto/contact_dto.dart';


class ContactCubit extends Cubit<List<ContactDto>> {
  final DatabaseManager _dbManager;

  ContactCubit(this._dbManager) : super([]);

  void loadContacts() async {
    final contacts = await _dbManager.getContacts();
    emit(contacts);
  }

  void addContact(ContactDto contact) async {
    await _dbManager.insertContact(contact);
    loadContacts();
  }

  void updateContact(ContactDto contact) async {
    await _dbManager.updateContact(contact);
    loadContacts();
  }

  void deleteContact(int id) async {
    await _dbManager.deleteContact(id);
    loadContacts();
  }

  void toggleFavorite(ContactDto contact) async {
    final updatedContact = ContactDto(
      id: contact.id,
      name: contact.name,
      phoneNumber: contact.phoneNumber,
      email: contact.email,
      imagePath: contact.imagePath,
      isFavorite: !contact.isFavorite,
    );
    await _dbManager.updateContact(updatedContact);
    loadContacts();
  }

  void loadFavoriteContacts() async {
    final allContacts = await _dbManager.getContacts();
    final favoriteContacts = allContacts.where((c) => c.isFavorite).toList();
    emit(favoriteContacts);
  }
}
