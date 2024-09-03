part of '../bloc/current_event_bloc.dart';

sealed class CurrentEventEvent extends Equatable {
  const CurrentEventEvent();

  @override
  List<Object> get props => [];
}

class CurrentEventRequested extends CurrentEventEvent {
  const CurrentEventRequested();
}
