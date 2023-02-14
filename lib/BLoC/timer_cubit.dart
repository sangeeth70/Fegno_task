// import 'dart:async';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:fegstore/BLoC/task_event.dart';
// import 'package:fegstore/BLoC/task_state.dart';
//
// class CountDownBloc extends Bloc<StartEvent,StartState>{
//   int counter = 5;
//   StreamSubscription ? timerSubscription;
//   CountDownBloc() : super(StartState() ){
//     on<StartEvent>((event,emit)=>emit(StartState()));
//     timerSubscription = Timer.periodic(Duration(seconds: 1), (timer) {
//       if(counter  != 0){
//         add(StartEvent());
//       } else {
//         timer.cancel();
//       }
//     }) as StreamSubscription?;
//   }
//   @override
//   Future<void> close(){
//     timerSubscription?.cancel();
//     return super.close();
//   }
// }

import 'dart:async';
import 'package:fegstore/BLoC/task_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimerCubit extends Cubit<TimerState>{
  TimerCubit():super(const TimerInitial());
  Timer ? _timer;
  startTimer([int ? time]){
    if(time != null){
      emit(TimerProgress(time));
    } else {
      emit(const TimerProgress(0));
    }
    _timer = Timer.periodic(Duration(seconds: 5),(timer){
    if(state is TimerProgress){
    TimerProgress wip = state as TimerProgress;
    if(wip.elapsed!=0) {
    emit(TimerProgress(wip.elapsed! - 1));
    } else if(wip.elapsed==0) {
    _timer!.cancel();
    emit(const TimerInitial());
    }
    }
    });
  }
  // TimerStart(Timer time){
  //   if(state is TimerProgress){
  //     TimerProgress wip = state as TimerProgress;
  //     if(wip.elapsed!=0) {
  //       emit(TimerProgress(wip.elapsed! - 1));
  //     } else if(wip.elapsed==0) {
  //       _timer!.cancel();
  //       emit(const TimerInitial());
  //     }
  //   }
  // }
}