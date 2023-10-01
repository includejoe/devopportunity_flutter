import 'dart:typed_data';
import 'package:dev_opportunity/base/di/get_it.dart';
import 'package:dev_opportunity/base/presentation/widgets/buttons/main_button.dart';
import 'package:dev_opportunity/base/presentation/widgets/inputs/text_input.dart';
import 'package:dev_opportunity/base/presentation/widgets/loader.dart';
import 'package:dev_opportunity/base/presentation/widgets/snackbar.dart';
import 'package:dev_opportunity/base/utils/input_validators/text.dart';
import 'package:dev_opportunity/base/utils/pick_image.dart';
import 'package:dev_opportunity/user/domain/models/user.dart';
import 'package:dev_opportunity/user/presentation/view_models/user_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _userViewModel = getIt<UserViewModel>();
  UserModel? _user;
  bool _isPageLoading = false;
  bool _isSaving = false;
  Uint8List? _profileImage;

  // controllers
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _headlineController = TextEditingController();
  final _bioController = TextEditingController();

  // focus nodes
  final _headlineFocusNode = FocusNode();
  final _bioFocusNode = FocusNode();

  // errors
  String? _nameError;
  String? _headlineError;

  void selectImage () async {
    Uint8List pickedImage = await pickImage(ImageSource.gallery);
    setState(() {
      _profileImage = pickedImage;
    });
  }

  void initialize() async {
    setState(() {_isPageLoading = true;});
    _user = await _userViewModel.getUserDetails();
    _emailController.text = _user?.email ?? "";
    _nameController.text = _user?.name ?? "";
    _headlineController.text = _user?.headline ?? "";
    _bioController.text = _user?.bio ?? "";
    setState(() {_isPageLoading = false;});
  }

  void updateProfile(context) async {
    setState(() {_isSaving = true;});
    bool successful = await _userViewModel.updateUser(
      name: _nameController.text,
      headline: _headlineController.text,
      bio: _bioController.text,
      profileImage: _profileImage,
      imageUrl: _user?.profilePic
    );

    if (successful) {
      UserModel? updatedUser = await _userViewModel.getUserDetails();
        setState(() {
          _user = updatedUser;
        });
      showSnackBar(context, "Profile updated successfully", Colors.green);
    } else {
      showSnackBar(context, "Something went wrong", Colors.redAccent);
    }

    setState(() {_isSaving = false;});
  }

  @override
  void initState() {
    super.initState();
    initialize();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final nameValidator = TextValidator(context);
    final headlineValidator = TextValidator(context);

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: theme.colorScheme.primary,
          title: Text(
            "Edit Profile",
            style: theme.textTheme.headlineMedium?.copyWith(
                color: theme.colorScheme.onPrimary
            ),
          ),
        ),
        body: _isPageLoading ? const Center(
          child: Loader(size: 24),
        ) : SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.08,),
                  Center(
                    child: Stack(
                      children: [
                        _profileImage != null ? CircleAvatar(
                          radius: 60,
                          backgroundImage: MemoryImage(_profileImage!),
                        ) : _user?.profilePic != null && _user?.profilePic != "" ? CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage(_user!.profilePic!),
                        ) : const CircleAvatar(
                          radius: 60,
                          backgroundImage: AssetImage("assets/avatar.jpg"),
                        ),
                        Positioned(
                            bottom: 0,
                            left: 75,
                            child: GestureDetector(
                              onTap: selectImage,
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    color: theme.colorScheme.primary,
                                    border: Border.all(
                                      color: theme.colorScheme.onPrimary,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(50)
                                ),
                                child:  Icon(
                                    Icons.add_a_photo,
                                    color: theme.colorScheme.onPrimary
                                ),
                              ),
                            )
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
                  TextInput(
                    controller: _emailController,
                    textInputType: TextInputType.emailAddress,
                    inputAction: TextInputAction.next,
                    prefixIcon: CupertinoIcons.envelope_fill,
                    enabled: false,
                    label: "Email",
                  ),
                  const SizedBox(height: 15,),
                  TextInput(
                    controller: _nameController,
                    textInputType: TextInputType.text,
                    inputAction: TextInputAction.next,
                    prefixIcon: CupertinoIcons.person_fill,
                    enabled: true,
                    label: "Name",
                    error: _nameError,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_headlineFocusNode);
                    },
                  ),
                  const SizedBox(height: 15,),
                  TextInput(
                    controller: _headlineController,
                    textInputType: TextInputType.text,
                    inputAction: TextInputAction.next,
                    prefixIcon: CupertinoIcons.bag_fill,
                    focusNode: _headlineFocusNode,
                    enabled: true,
                    label: "Headline",
                    error: _headlineError,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_bioFocusNode);
                    },
                  ),
                  const SizedBox(height: 15,),
                  TextInput(
                    controller: _bioController,
                    textInputType: TextInputType.text,
                    height: 100.0,
                    maxLines: 5,
                    focusNode: _bioFocusNode,
                    inputAction: TextInputAction.done,
                    enabled: true,
                    label: "Bio",
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).unfocus();
                    },
                  ),
                  const SizedBox(height: 25,),
                  _isSaving ? const Loader(size: 24) : Button(
                      onTap: () {
                        setState(() {
                          _nameError = nameValidator(_nameController.text);
                          _headlineError = headlineValidator(_headlineController.text);
                        });

                        final errors = [
                          _nameError,
                          _headlineError,
                        ];

                        if(errors.every((error) => error == null)) {
                          FocusScope.of(context).unfocus();
                          updateProfile(context);
                        }
                      },
                      text: "SAVE"
                  ),
                  const SizedBox(height: 25,),
                ]
            ),
          ),
        )
    );
  }
}