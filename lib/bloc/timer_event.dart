part of 'timer_bloc.dart';

sealed class TimerEvent{
  const TimerEvent();
}


final class TimerStarted extends TimerEvent{
  const TimerStarted(this.duration);

  final int duration;
}


final class TimerPaused extends TimerEvent{
  const TimerPaused();
}

final class TimerResumed extends TimerEvent{
  const TimerResumed();
}

final class TimerReset extends TimerEvent{
  const TimerReset();
}


final class _TimerTicked extends TimerEvent{
  const _TimerTicked(this.duration);
  final int duration;
}