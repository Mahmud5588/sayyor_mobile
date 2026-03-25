import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sayyor/features/authentification/presentation/screen/login.dart';

import '../../../../core/themes/app_colors.dart';
import '../../../../core/themes/app_sizes.dart';
import '../../../../core/utils/images.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isObscure = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("Register")),
      body: Padding(
        padding: AppSizes.padding20,
        child: Column(
          children: [
            Image.asset(ImagesUrls.logo),
            TextFormField(decoration: InputDecoration(hintText: "Email")),
            AppSizes.gH12,
            TextFormField(
              decoration: InputDecoration(
                hintText: "New Parol",
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
            AppSizes.gH16,
            TextFormField(
              decoration: InputDecoration(
                hintText: "Repeat Parol",
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
            AppSizes.gH16,
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                minimumSize: Size(
                  MediaQuery.sizeOf(context).width,
                  AppSizes.h48,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: AppSizes.borderRadius16,
                ),
              ),
              child: Text("Register"),
            ),
            AppSizes.gH24,
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Do you have account?",
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(color: AppColors.kGray600),
                ),
                TextButton(
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Login",
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
