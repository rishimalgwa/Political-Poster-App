import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:political_poster_app/src/common/helpers/size.dart';
import 'package:political_poster_app/src/common/utils/phone_validation.dart';
import 'package:political_poster_app/src/common/widgets/button.dart';
import 'package:political_poster_app/src/common/widgets/loading_widget.dart';
import 'package:political_poster_app/src/features/auth/presentation/cubit/login_cubit/login_cubit.dart';
import 'package:political_poster_app/src/navigation/router.dart';

@RoutePage()
class PhonePage extends StatefulWidget {
  const PhonePage({super.key});

  @override
  State<PhonePage> createState() => _PhonePageState();
}

class _PhonePageState extends State<PhonePage> {
  final TextEditingController phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Placeholder(
                fallbackHeight: SizeHelper(context).hHelper(30),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Mobile number",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      hintText: 'Mobile No.',
                      hintStyle: TextStyle(
                        fontSize: 14,
                      ),
                      filled: true,
                      isDense: true,
                      prefixIcon: Padding(
                          padding: EdgeInsets.fromLTRB(16, 16, 0, 16),
                          child: Text(
                            '+91',
                            style: TextStyle(fontSize: 15),
                          )),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: validatePhoneNumber,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: SizedBox(
                      width: SizeHelper(context).wHelper(50),
                      child: BlocConsumer<LoginCubit, LoginState>(
                        listener: (context, state) {
                          if (state is LoginSuccess) {
                            context.router.popAndPush(const DashboardRoute());
                          }
                          if (state is LoginError) {
                            context.router.push(AddProfileRoute(
                                phoneNumer: phoneController.text));
                          }
                        },
                        builder: (context, state) {
                          if (state is LoginLoading) {
                            return const Center(
                              child: LoadingWidget(),
                            );
                          }
                          return CustomPrimaryButton(
                            text: "Submit",
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context
                                    .read<LoginCubit>()
                                    .login(phoneNumber: phoneController.text);
                              }
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
