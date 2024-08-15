import 'dart:io';

import 'package:contact_app/utils/buttons/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../dto/contact_dto.dart';
import '../utils/app_colors.dart';

class ContactDetailPage extends StatefulWidget {
  final ContactDto? contactDto;

  const ContactDetailPage({super.key, this.contactDto});

  @override
  State<ContactDetailPage> createState() => _ContactDetailPageState();
}

class _ContactDetailPageState extends State<ContactDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: AppColors.primaryColorWhite,
        ),
        backgroundColor: AppColors.primaryColorBlack,
        // centerTitle: true,
        title: const Text(
          "Contact Info",
          style: TextStyle(
              color: AppColors.primaryColorWhite, fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 25,
              ),
              widget.contactDto?.imagePath != null
                  ? SizedBox(
                      height: 100,
                      width: 100,
                      child: CircleAvatar(
                        backgroundImage:
                            FileImage(File(widget.contactDto!.imagePath!)),
                      ),
                    )
                  : const SizedBox(
                      height: 100,
                      width: 100,
                      child: CircleAvatar(child: Icon(Icons.person))),
              const SizedBox(
                height: 10,
              ),
              Text(
                widget.contactDto!.name.toString(),
                style:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  const Icon(Icons.email_outlined),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    widget.contactDto!.email.toString(),
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Icon(Icons.call),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    widget.contactDto!.phoneNumber.toString(),
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              PrimaryButton(
                text: "Call",
                boxColor: Colors.lightGreen,
                borderColor: Colors.transparent,
                onPressed: () {
                  _makingPhoneCall(widget.contactDto!.phoneNumber.toString());
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _makingPhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    try {
      if (await canLaunchUrl(launchUri)) {
        await launchUrl(launchUri);
      } else {
        throw 'Could not launch $phoneNumber';
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
