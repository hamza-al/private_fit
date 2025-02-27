import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:private_fit/domain/core/onboarding_failures.dart';
import 'package:private_fit/domain/home/use_cases/set_username_use_case.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'home_bloc.freezed.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this._setUserNameUseCase) : super(const _Initial()) {
    on<HomeEvent>(_homeEventHandler);
  }

  final SetUserNameUseCase _setUserNameUseCase;

  FutureOr<void> _homeEventHandler(
    HomeEvent event,
    Emitter<HomeState> emit,
  ) async {
    await event.map(
      started: (_) {},
      setUserName: (u) async {
        await _setUserNameUseCase.call(u.username).then(
              (c) => emit(
                HomeState.username(c),
              ),
            );
        emit(const HomeState.initial());
      },
    );
  }
}
