/*
Harrison Stadler
Mobile App Dev
CSC 4360
InClassAct10 - SignUpPage
*/

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Sign-Up Page';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
        ),
        body: const MyCustomForm(),
      ),
    );
  }
}

// A simple ConfirmationPage that shows a welcome message with the user's first name.
class ConfirmationPage extends StatelessWidget {
  final String firstName;

  const ConfirmationPage({super.key, required this.firstName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirmation'),
      ),
      body: Center(
        child: Text(
          'Signup successful!\nWelcome, $firstName!',
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

// Create a FormBuilder widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  MyCustomFormState createState() => MyCustomFormState();
}

// The form state using flutter_form_builder.
class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      // Using a SingleChildScrollView to ensure the form is scrollable.
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Row for first name and last name fields.
            Row(
              children: [
                Expanded(
                  child: FormBuilderTextField(
                    name: 'first_name',
                    decoration: const InputDecoration(
                      labelText: 'First Name',
                      hintText: 'Enter your first name',
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: FormBuilderTextField(
                    name: 'last_name',
                    decoration: const InputDecoration(
                      labelText: 'Last Name',
                      hintText: 'Enter your last name',
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            // Row for email and contact number.
            Row(
              children: [
                Expanded(
                  child: FormBuilderTextField(
                    name: 'email',
                    decoration: const InputDecoration(
                      labelText: 'Email Address',
                      hintText: 'Enter your email',
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.email(),
                    ]),
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: FormBuilderTextField(
                    name: 'contact_no',
                    decoration: const InputDecoration(
                      labelText: 'Contact No.',
                      hintText: 'Enter your phone number',
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            // Date of Birth field using a built-in date picker.
            FormBuilderDateTimePicker(
              name: 'dob',
              inputType: InputType.date,
              format: DateFormat('MM/dd/yyyy'),
              decoration: const InputDecoration(
                labelText: 'Date of Birth',
                hintText: 'MM/DD/YYYY',
              ),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
              ]),
            ),
            const SizedBox(height: 16.0),
            // Password field with custom validation.
            FormBuilderTextField(
              name: 'password',
              decoration: const InputDecoration(
                labelText: 'Password',
                hintText: 'Enter a strong password',
              ),
              obscureText: true,
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
                FormBuilderValidators.minLength(8),
                (val) {
                  if (val == null || !RegExp(r'\d').hasMatch(val)) {
                    return 'Password must contain at least one number';
                  }
                  return null;
                },
                (val) {
                  if (val == null || !RegExp(r'[A-Z]').hasMatch(val)) {
                    return 'Password must contain at least one uppercase letter';
                  }
                  return null;
                },
              ]),
            ),
            const SizedBox(height: 16.0),
            // Address field.
            FormBuilderTextField(
              name: 'address',
              decoration: const InputDecoration(
                labelText: 'Address',
                hintText: 'Enter your address',
              ),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
              ]),
            ),
            const SizedBox(height: 24.0),
            // Submission button that handles validation and navigation.
            ElevatedButton(
              onPressed: () {
                // Save and validate the form.
                if (_formKey.currentState?.saveAndValidate() ?? false) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Form is valid!')),
                  );
                  // Retrieve the first name from the form fields.
                  final firstName = _formKey.currentState!.value['first_name'];
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ConfirmationPage(firstName: firstName),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Please fix errors in the form.')),
                  );
                }
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
