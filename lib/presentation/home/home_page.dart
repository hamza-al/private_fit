import 'dart:math' as math;

import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:private_fit/application/home/bloc/home_bloc.dart';
import 'package:private_fit/injections.dart';
import 'package:private_fit/l10n/l10n.dart';
import 'package:private_fit/presentation/components/toast.dart';
import 'package:private_fit/presentation/routes/router.gr.dart';
import 'package:private_fit/shared/images.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      body: BlocConsumer<HomeBloc, HomeState>(
        bloc: getIt<HomeBloc>(),
        listener: (context, state) {
          state.whenOrNull(
            username: (result) {
              showToast(
                context,
                state.maybeWhen(
                  username: (result) {
                    return result.fold(
                      (l) => l.maybeWhen(
                        failToSetUsername: () => 'hh',
                        orElse: () => '',
                      ),
                      (r) => 'Succesful updated Username',
                    );
                  },
                  orElse: () => '',
                ),
              );
            },
          );
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.cyan,
            body: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        AllImages().trainer,
                      ),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                Positioned(
                  top: 700,
                  left: 30,
                  child: Transform.rotate(
                    angle: -math.pi / 2,
                    alignment: Alignment.centerLeft,
                    child: AutoSizeText(
                      l10n.app_title,
                      style: const TextStyle(
                        fontSize: 60,
                        color: Color.fromARGB(255, 7, 54, 92),
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 110,
                  left: 70,
                  child: Transform.rotate(
                    angle: -math.pi / 2,
                    alignment: Alignment.centerLeft,
                    child: const AutoSizeText(
                      'Welcome @22fine90',
                      style: TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(255, 5, 99, 98),
                        fontWeight: FontWeight.w300,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 110,
                  right: 70,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          context.read<HomeBloc>().add(
                                const HomeEvent.setUserName('kZawadi'),
                              );
                        },
                        child: const Icon(
                          Icons.people,
                          size: 20,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          AutoRouter.of(context)
                              .replace(const ScannerPageRoute());
                        },
                        child: const Icon(
                          Icons.search_off_outlined,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
          // );q
        },
      ),
    );
  }
}
