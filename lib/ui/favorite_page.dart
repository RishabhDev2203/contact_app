import 'dart:io';

import 'package:contact_app/ui/add_contact_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/contact_cubit.dart';
import '../dto/contact_dto.dart';
import '../utils/app_colors.dart';
import 'contact_detail_page.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  void initState() {
    context.read<ContactCubit>().loadFavoriteContacts();
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
                      // dense: true,
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
                      trailing: IconButton(
                        icon: Icon(
                          contact.isFavorite ? Icons.star : Icons.star_border,
                          color: contact.isFavorite
                              ? AppColors.red
                              : AppColors.primaryColorBlack,
                          size: 30,
                        ),
                        onPressed: () {
                          context.read<ContactCubit>().toggleFavorite(contact);
                        },
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
                      "assets/no_favorite.png",
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "No Favorites",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                    ),
                  ],
                ));
        },
      ),
    );
  }
}
