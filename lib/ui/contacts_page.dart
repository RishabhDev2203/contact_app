import 'dart:io';

import 'package:contact_app/ui/add_contact_widget.dart';
import 'package:contact_app/ui/contact_detail_page.dart';
import 'package:contact_app/utils/buttons/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/contact_cubit.dart';
import '../dto/contact_dto.dart';
import '../utils/app_colors.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  @override
  void initState() {
    context.read<ContactCubit>().loadContacts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ContactCubit, List<ContactDto>>(
        builder: (context, contacts) {
          return contacts != null && contacts.isNotEmpty
              ? ListView.separated(
                  itemCount: contacts.length,
                  itemBuilder: (context, index) {
                    final contact = contacts[index];
                    return ListTile(
                      tileColor: AppColors.lightBlack.withOpacity(0.5),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      leading: contact.imagePath != null
                          ? CircleAvatar(
                              backgroundImage:
                                  FileImage(File(contact.imagePath!)),
                            )
                          : const CircleAvatar(
                              child: Icon(Icons.person),
                            ),
                      title: Text(
                        contact.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            height: 1.2),
                      ),
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                context
                                    .read<ContactCubit>()
                                    .toggleFavorite(contact);
                              },
                              child: Icon(
                                contact.isFavorite
                                    ? Icons.star
                                    : Icons.star_border,
                                color: contact.isFavorite
                                    ? AppColors.red
                                    : AppColors.primaryColorBlack,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddContactWidget(
                                      contactDto: contact,
                                      isEdit: true,
                                    ),
                                  ),
                                );
                              },
                              child: const Icon(Icons.edit),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {
                                _showDeleteDialog(context,contact);
                              },
                              child: const Icon(Icons.delete),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ContactDetailPage(
                              contactDto: contact,
                            ),
                          ),
                        );
                      },
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 1,
                      color: AppColors.lightGrey,
                    );
                  },
                )
              : Center(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/no_contact.png",
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                    const Text(
                      "No Contacts",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    PrimaryButton(
                      text: "Add Contact",
                      width: MediaQuery.of(context).size.width / 2,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AddContactWidget()),
                        );
                      },
                    )
                  ],
                ));
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColorBlack,
        child: const Icon(
          Icons.add,
          color: AppColors.primaryColorWhite,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddContactWidget()),
          );
        },
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, ContactDto contact) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Contact'),
          content: Text('Are you sure you want to delete ${contact.name}?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                context
                    .read<ContactCubit>()
                    .deleteContact(contact.id!);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
