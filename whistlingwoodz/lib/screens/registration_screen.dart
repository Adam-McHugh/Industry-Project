import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:whistlingwoodz/screens/login_screen.dart';
import 'package:whistlingwoodz/screens/wedding_celebrations_screen.dart';
import 'package:whistlingwoodz/utils/app_utils.dart';
import 'package:whistlingwoodz/widgets/input_field_widget.dart';
import 'package:whistlingwoodz/widgets/reusable_widgets.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();

  String genderSelected = "male";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Fix for pixel exceeding screen.
      resizeToAvoidBottomInset: false,
      //! Main background colour
      backgroundColor: colorPrimary,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(
              // WhistlingWoodz block
              child: Text(
                "WhistlingWoodz",
                style: TextStyle(
                  color: colorWhite,
                  fontSize: 28.0,
                  fontFamily: fontFamily,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Horizontal Box space between WhistlingWoodz and Events
            const SizedBox(
              height: 8.0,
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            const Center(
              // Enter Information block
              child: Text(
                "Please enter your information",
                style: TextStyle(
                  color: colorWhite,
                  fontSize: 14.0,
                  fontFamily: fontFamily,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Space between information and name line
            const SizedBox(
              height: 50,
            ),
            // Name input area
            InputField(
              controller: nameController,
              icon: Icons.person,
              hintText: "Please enter your name.",
            ),
            const SizedBox(
              height: 25,
            ),
            // Email input area
            InputField(
              controller: emailController,
              icon: Icons.email,
              hintText: "Please enter your email.",
            ),
            const SizedBox(
              height: 25,
            ),
            // Password input area
            InputField(
              controller: passwordController,
              icon: Icons.password,
              hintText: "Please enter your password.",
              obsecureText: true,
            ),
            // Space between Password and Calender fields.
            const SizedBox(
              height: 25,
            ),
            // Birthday Field
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 20),
              child: TextFormField(
                style: const TextStyle(
                  color: colorWhite,
                  fontFamily: fontFamily,
                ),
                textAlign: TextAlign.center,
                controller: birthDateController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.calendar_month,
                    color: colorWhite,
                    size: 25.0,
                  ),
                  hintText: "Please enter you birthday",
                  hintStyle: TextStyle(
                    color: colorGrey,
                    fontSize: 14.0,
                    fontFamily: fontFamily,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: colorWhite),
                  ),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: colorWhite),
                  ),
                ),
                onTap: () async {
                  DateTime date = DateTime(1900);
                  FocusScope.of(context).requestFocus(FocusNode());

                  date = (await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100)))!;
                  String dateFormatter = date.toIso8601String();
                  DateTime dt = DateTime.parse(dateFormatter);
                  var formatter = DateFormat('dd-MMMM-yyyy');
                  birthDateController.text = formatter.format(dt);
                },
              ),
            ),
            // Space between Calender and Gender Selector.
            const SizedBox(
              height: 25,
            ),
            // Gender section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Text(
                    "Gender",
                    style: TextStyle(
                      color: colorWhite,
                      letterSpacing: 1,
                      fontSize: 14.0,
                      fontFamily: fontFamily,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      // Male radio button
                      Flexible(
                        fit: FlexFit.loose,
                        child: RadioListTile(
                          contentPadding: EdgeInsets.zero,
                          groupValue: genderSelected,
                          activeColor: colorWhite,
                          title: const Text(
                            "Male",
                            style: TextStyle(
                              fontSize: 14.0,
                              color: colorWhite,
                              fontFamily: fontFamily,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          value: 'male',
                          onChanged: (val) {
                            setState(() {
                              genderSelected = val.toString();
                            });
                            //print(genderSelected);
                          },
                        ),
                      ),
                      // FEMALE radio button
                      Flexible(
                        fit: FlexFit.loose,
                        child: RadioListTile(
                          contentPadding: EdgeInsets.zero,
                          groupValue: genderSelected,
                          activeColor: colorWhite,
                          title: const Text(
                            "Female",
                            style: TextStyle(
                              fontSize: 14.0,
                              color: colorWhite,
                              fontFamily: fontFamily,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          value: 'female',
                          onChanged: (val) {
                            setState(() {
                              genderSelected = val.toString();
                            });
                            //print(genderSelected);
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 25.0,
            ),
            // Primary Sign up button
            firebaseUIButton(context, "Sign Up", () {
              FirebaseAuth.instance
                  .createUserWithEmailAndPassword(
                      email: emailController.text,
                      password: passwordController.text,
                      name: nameController.text,
                      birthDateController.text)
                  .then((value) {
                print("Created New Account");
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Wedding()));
              }).onError((error, stackTrace) {
                print("Error ${error.toString()}");
              });
            }),
            // Space between FirebaseUIButton Sign up button and Already have an account?
            const SizedBox(
              height: 25.0,
            ),
            // Text under Sign up button
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Already have an account text
                const Text(
                  "Already have an account?",
                  style: TextStyle(
                    color: colorWhite,
                    fontFamily: fontFamily,
                  ),
                ),
                // Sign in text
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()));
                  },
                  child: const Text(
                    "Sign In",
                    style: TextStyle(
                      color: colorWhite,
                      fontFamily: fontFamily,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
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

  bool isValidate() {
    if (nameController.text.isEmpty) {
      showScaffold(context, "Please enter your name");
      return false;
    }
    if (emailController.text.isEmpty) {
      showScaffold(context, "Please enter your email");
      return false;
    }
    if (passwordController.text.isEmpty) {
      showScaffold(context, "Please enter your password");
      return false;
    }
    if (birthDateController.text.isEmpty) {
      showScaffold(context, "Please enter your birthday");
      return false;
    }
    return true;
  }
}
