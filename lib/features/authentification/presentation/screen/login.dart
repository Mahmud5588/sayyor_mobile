import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sayyor/core/l10n/app_localizations.dart';
import 'package:sayyor/core/themes/app_colors.dart';
import 'package:sayyor/core/themes/app_sizes.dart';
import 'package:sayyor/core/utils/images.dart';
import 'package:sayyor/features/authentification/presentation/screen/register.dart';
import 'package:sayyor/features/main/presentation/screen/main_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isObscure = false;
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text(l10n.loginTitle)),
      body: Padding(
        padding: AppSizes.padding20,
        child: Column(
          children: [
            Image.asset(ImagesUrls.logo),
            TextFormField(
              decoration: InputDecoration(hintText: l10n.loginEmailHint),
            ),
            AppSizes.gH12,
            TextFormField(
              decoration: InputDecoration(
                hintText: l10n.loginPasswordHint,
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      isObscure = !isObscure;
                    });
                  },
                  icon: Icon(
                    isObscure
                        ? CupertinoIcons.eye_slash_fill
                        : CupertinoIcons.eye_fill,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              obscureText: isObscure,
            ),
            AppSizes.gH24,
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const MainScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(
                  MediaQuery.sizeOf(context).width,
                  AppSizes.h48,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: AppSizes.borderRadius16,
                ),
              ),
              child: Text(l10n.loginButton),
            ),
            AppSizes.gH16,
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  l10n.loginNoAccount,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(color: AppColors.kGray600),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return RegisterScreen();
                        },
                      ),
                    );
                  },
                  child: Text(
                    l10n.loginRegister,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.kPrimaryDark,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
