import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  StreamSubscription<Position>? positionSubscription;

  LocationBloc() : super(const LocationState()) {
    on<OnStartFollowingUser>((event, emit) => emit(state.copywith(followingUser: true)));

    on<OnStopFollowingUser>((event, emit) => emit(state.copywith(followingUser: false)));

    on<OnNewUserLocationEvent>((event, emit) {
      emit(state.copywith(
        lastKnownLocation: event.newLocation,
        myLocationHistory: [...state.myLocationHistory, event.newLocation],
      ));
    });
  }

  Future getCurrentPosition() async {
    final position = await Geolocator.getCurrentPosition();
    // print('Position: $position');
    add(OnNewUserLocationEvent(LatLng(position.latitude, position.longitude)));
  }

  void startFollowingUser() {
    add(OnStartFollowingUser());
    // print('startFollowingUser');
    positionSubscription = Geolocator.getPositionStream().listen((event) {
      final position = event;
      add(OnNewUserLocationEvent(LatLng(position.latitude, position.longitude)));
    });
  }

  void stopFollowingUser() {
    positionSubscription?.cancel();
    add(OnStopFollowingUser());
    print('stopFollowingUser');
  }

// Se llama cuando se termina el locationBloc
  @override
  Future<void> close() {
    stopFollowingUser();
    return super.close();
  }
}
