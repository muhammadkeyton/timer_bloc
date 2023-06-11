import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'dart:async';

import 'package:my_timer_bloc_2/data/ticker.dart';


part 'timer_event.dart';
part 'timer_state.dart';



class TimerBloc extends Bloc<TimerEvent,TimerState>{
  static const int _duration = 10;
  final Ticker _ticker;

  StreamSubscription<int>? _tickerSubcription;

  TimerBloc({required Ticker ticker}): _ticker= ticker, super(const TimerInitial(_duration)){

    on<TimerStarted>(_onStarted);
    on<_TimerTicked>(_onTicked);
    on<TimerPaused>(_onPaused);
    on<TimerResumed>(_onResumed);
    on<TimerReset>(_onReset);
  }



  @override
  Future<void> close() {
    _tickerSubcription?.cancel();
    return super.close();
  }


  void _onStarted(TimerStarted event,Emitter<TimerState>emit){
    _tickerSubcription?.cancel();

    _tickerSubcription = _ticker.ticker(ticks: event.duration).listen(
      (duration) => add(_TimerTicked(duration)) ,

    );
   
  }

  void _onTicked(_TimerTicked event, Emitter<TimerState>emit){

    emit(event.duration > 0? TimerRunning(event.duration) : const TimerComplete());
  }


  void _onPaused(TimerPaused event,Emitter<TimerState>emit){
    if(state is TimerRunning){
      _tickerSubcription?.pause();
      emit(TimerPause(state.duration));
    }
  }

  void _onResumed(TimerResumed event,Emitter<TimerState>emit){
    if(state is TimerPause){
      _tickerSubcription?.resume();
      emit(TimerRunning(state.duration));
    }

  }


  void _onReset(TimerReset event,Emitter<TimerState>emit){
    _tickerSubcription?.cancel();
    emit(const TimerInitial(_duration));
  }



}