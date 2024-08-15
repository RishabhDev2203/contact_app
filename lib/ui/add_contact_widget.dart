// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../bloc/contact_cubit.dart';
import '../dto/contact_dto.dart';
import '../utils/app_colors.dart';
import '../utils/buttons/primary_button.dart';

class AddContactWidget extends StatefulWidget {
  final ContactDto? contactDto;
  final bool isEdit;

  const AddContactWidget({super.key, this.contactDto, this.isEdit = false});

  @override
  _AddContactWidgetState createState() => _AddContactWidgetState();
}

class _AddContactWidgetState extends State<AddContactWidget> {
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _mobileNumber = TextEditingController();
  final TextEditingController _emailAddress = TextEditingController();
  final formGlobalKey = GlobalKey<FormState>();
  File? imageFile;

  @override
  void initState() {
    if (widget.isEdit) {
      getData();
    }
    super.initState();
  }

  void getData() {
    if (widget.contactDto != null) {
      _firstName.text = widget.contactDto!.name.split(" ").first.toString();
      _lastName.text = widget.contactDto!.name.split(" ").last.toString();
      _mobileNumber.text = widget.contactDto!.phoneNumber.toString();
      _emailAddress.text = widget.contactDto!.email.toString();
      imageFile = File(widget.contactDto!.imagePath!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: AppColors.primaryColorBlack,
          leading: BackButton(
            color: AppColors.primaryColorWhite,
          ),
          title: Text(
            "Add Contact",
            style: TextStyle(
                color: AppColors.primaryColorWhite,
                fontWeight: FontWeight.w500),
          ),
        ),
        body: ListView(
          children: [
            SizedBox(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Form(
                  key: formGlobalKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: _pickImage,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: AppColors.primaryColorBlack,
                          backgroundImage:
                              imageFile != null ? FileImage(imageFile!) : null,
                          child: imageFile == null
                              ? Icon(Icons.person,
                                  color: AppColors.primaryColorWhite, size: 40)
                              : null,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.name,
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.primaryColorBlack, width: 2.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.primaryColorBlack, width: 1.0),
                          ),
                          hintText: 'First Name',
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        ),
                        controller: _firstName,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter First Name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.name,
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.primaryColorBlack, width: 2.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.primaryColorBlack, width: 1.0),
                          ),
                          hintText: 'Last Name',
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        ),
                        controller: _lastName,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Last First Name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.primaryColorBlack, width: 2.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.primaryColorBlack, width: 1.0),
                          ),
                          hintText: 'Mobile Number',
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        ),
                        controller: _mobileNumber,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter Mobile Number';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.primaryColorBlack, width: 2.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.primaryColorBlack, width: 1.0),
                          ),
                          hintText: 'Email Address',
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        ),
                        controller: _emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter Email Address';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      PrimaryButton(
                        text: "Save",
                        width: MediaQuery.of(context).size.width / 1.5,
                        onPressed: () {
                          if (formGlobalKey.currentState!.validate()) {
                            _insertData();
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  void _insertData() async {
    if (widget.isEdit) {
      final contactDto = ContactDto(
        id: widget.contactDto?.id,
        name: "${_firstName.text} ${_lastName.text}",
        phoneNumber: _mobileNumber.text,
        email: _emailAddress.text,
        imagePath: imageFile?.path,
      );
      context.read<ContactCubit>().updateContact(contactDto);
      Navigator.pop(context);
    } else {
      final contactDto = ContactDto(
        name: "${_firstName.text} ${_lastName.text}",
        phoneNumber: _mobileNumber.text,
        email: _emailAddress.text,
        imagePath: imageFile?.path,
      );
      context.read<ContactCubit>().addContact(contactDto);
      Navigator.pop(context);
    }
  }
}
