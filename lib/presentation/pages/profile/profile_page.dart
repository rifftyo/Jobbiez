// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:jobbiez/common/constants.dart';
import 'package:jobbiez/common/routes/app_routes.dart';
import 'package:jobbiez/common/state_enum.dart';
import 'package:jobbiez/presentation/provider/profile_user_provider.dart';
import 'package:jobbiez/presentation/provider/update_profile_provider.dart';
import 'package:jobbiez/presentation/widgets/user_avatar.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController usernameController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    super.dispose();
  }

  Future<void> _handleUpdateProfile(BuildContext context) async {
    final provider = Provider.of<UpdateProfileProvider>(context, listen: false);
    final userProvider = Provider.of<ProfileUserProvider>(
      context,
      listen: false,
    );

    final username = usernameController.text;

    if (username.isEmpty && provider.fotoProfileFile == null) {
      Navigator.pop(context);
      return;
    }

    await provider.fetchUpdateProfile(username);

    if (provider.state == RequestState.Loaded) {
      await userProvider.getProfileUser();

      Navigator.pop(context);

      _showToast(
        context,
        provider.message ?? 'Profile updated successfully',
        true,
      );
    } else {
      Navigator.pop(context);

      _showToast(
        context,
        provider.message ?? 'Failed to update profile',
        false,
      );
    }
  }

  void _showToast(BuildContext context, String message, bool isSuccess) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        backgroundColor: isSuccess ? Colors.green : Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Consumer<ProfileUserProvider>(
                builder: (context, value, child) {
                  final user = value.user;
                  final state = value.state;

                  return UserAvatar(
                    username: user!.username,
                    fotoProfile: user.fotoProfile,
                    radius: 125,
                    state: state,
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Consumer<ProfileUserProvider>(
                builder: (context, value, _) {
                  final user = value.user;
                  return Text(
                    user!.username,
                    style: kManropeHeading1.copyWith(fontSize: 28),
                  );
                },
              ),
            ),
            const SizedBox(height: 35),
            ProfileMenu(
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.applications);
              },
              title: 'Job Applications',
              subTitle: 'View the jobs you have applied to',
              icon: Icons.list_alt,
            ),
            const SizedBox(height: 15),
            ProfileMenu(
              onTap: () {
                _showToast(context, 'Cooming Soon', true);
              },
              title: 'Akun',
              subTitle: 'Manage your personal information and settings',
              icon: Icons.key,
            ),
            const SizedBox(height: 15),
            ProfileMenu(
              onTap: () async {
                await showModalBottomSheet(
                  context: context,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  builder: (context) {
                    return Container(
                      width: double.infinity,
                      height: 500,
                      padding: EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 32,
                      ),
                      child: Consumer<UpdateProfileProvider>(
                        builder: (context, provider, child) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Text(
                                  'Update Profile',
                                  style: kManropeHeading1.copyWith(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(height: 48),
                              Consumer<UpdateProfileProvider>(
                                builder: (context, updateProvider, child) {
                                  return GestureDetector(
                                    onTap: () {
                                      updateProvider.pickFile();
                                    },
                                    child: Center(
                                      child: Consumer<ProfileUserProvider>(
                                        builder: (
                                          context,
                                          userProvider,
                                          child,
                                        ) {
                                          final user = userProvider.user;
                                          final state = userProvider.state;

                                          Widget avatarWidget;

                                          if (updateProvider.fotoProfileFile !=
                                              null) {
                                            avatarWidget = CircleAvatar(
                                              radius: 65,
                                              backgroundImage: FileImage(
                                                updateProvider.fotoProfileFile!,
                                              ),
                                            );
                                          } else {
                                            avatarWidget = UserAvatar(
                                              username: '',
                                              fotoProfile: user!.fotoProfile,
                                              radius: 65,
                                              state: state,
                                            );
                                          }

                                          return Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              avatarWidget,
                                              Positioned(
                                                bottom: 0,
                                                right: 0,
                                                child: InkWell(
                                                  onTap: () {
                                                    updateProvider.pickFile();
                                                  },
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(6),
                                                    decoration: BoxDecoration(
                                                      color: Colors.blue,
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                        color: Colors.white,
                                                        width: 2,
                                                      ),
                                                    ),
                                                    child: const Icon(
                                                      Icons.edit,
                                                      size: 16,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(height: 24),
                              Text("New Username", style: kManropeHeading5),
                              const SizedBox(height: 8),
                              TextField(
                                controller: usernameController,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  hintText: 'New Username',
                                  hintStyle: TextStyle(color: Colors.grey[400]),
                                  filled: true,
                                  fillColor: kWhite,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: kLightGray,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 24),
                              Consumer<UpdateProfileProvider>(
                                builder: (context, provider, child) {
                                  return SizedBox(
                                    width: double.infinity,
                                    height: 50,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        provider.state == RequestState.Loading
                                            ? null
                                            : _handleUpdateProfile(context);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: kYellow,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            25,
                                          ),
                                        ),
                                      ),
                                      child:
                                          provider.state == RequestState.Loading
                                              ? const Center(
                                                child:
                                                    CircularProgressIndicator(
                                                      color: kWhite,
                                                    ),
                                              )
                                              : Text(
                                                'Update Now',
                                                style: kManropeHeading5
                                                    .copyWith(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                              ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          );
                        },
                      ),
                    );
                  },
                ).whenComplete(() {
                  usernameController.clear();
                  final updateProvider = Provider.of<UpdateProfileProvider>(
                    context,
                    listen: false,
                  );
                  updateProvider.resetPickedFile();
                });
              },
              title: 'Avatar',
              subTitle: 'Update your profile picture or Username',
              icon: Icons.account_circle_outlined,
            ),
            const SizedBox(height: 15),
            ProfileMenu(
              onTap: () {
                _showToast(context, 'Cooming Soon', true);
              },
              title: 'App Language',
              subTitle: 'Choose your preferred language',
              icon: Icons.language,
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileMenu extends StatelessWidget {
  final Function() onTap;
  final String title;
  final String subTitle;
  final IconData icon;

  const ProfileMenu({
    super.key,
    required this.onTap,
    required this.title,
    required this.subTitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        child: Row(
          children: [
            Icon(icon, size: 35),
            const SizedBox(width: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: kManropeHeading5),
                Text(subTitle, style: kManropeBodyText.copyWith(fontSize: 12)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
