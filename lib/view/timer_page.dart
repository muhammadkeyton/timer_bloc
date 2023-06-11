import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/timer_bloc.dart';
import '../data/ticker.dart';

class TimerPage extends StatelessWidget {
  const TimerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            AppBar(centerTitle: true, title: const Text('Timer Bloc Practise')),
        body: BlocProvider(
          create: (context) => TimerBloc(ticker: Ticker()),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TimerText(),
              SizedBox(
                height: 50,
              ),
              Actions()
            ],
          ),
        ));
  }
}

class Actions extends StatelessWidget {
  const Actions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc,TimerState>(
      buildWhen: (previousState, currentState) => previousState.runtimeType != currentState.runtimeType ,
      builder: (context,state){

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            ...switch(state){

              TimerInitial() =>[

                FloatingActionButton(
                  onPressed: () {
                    context.read<TimerBloc>().add(TimerStarted(state.duration));
                  }, child: const Icon(Icons.play_arrow)),
          
              ],

              TimerRunning() => [


                FloatingActionButton(
                    onPressed: () {
                      context.read<TimerBloc>().add(const TimerPaused());
                    }, child: const Icon(Icons.pause)),
                const SizedBox(
                  width: 30,
                ),
                FloatingActionButton(
                    onPressed: () {
                      context.read<TimerBloc>().add(const TimerReset());
                    }, child: const Icon(Icons.restore)),

              ],

              TimerPause() => [


                 FloatingActionButton(
                    onPressed: () {
                      context.read<TimerBloc>().add(const TimerResumed());
                    }, child: const Icon(Icons.play_arrow)),
                const SizedBox(
                  width: 30,
                ),
                FloatingActionButton(
                    onPressed: () {
                      context.read<TimerBloc>().add(const TimerReset());
                    }, child: const Icon(Icons.restore)),





              ],

              TimerComplete() => [

                   FloatingActionButton(
                    onPressed: () {
                      context.read<TimerBloc>().add(const TimerReset());
                    },

                    child:const Icon(Icons.restore)
                    
                    )
              ]

            }






          ]
          
          
          
          
          );






    








      }
      
      
      
      );
    
    
    
   
  }
}

class TimerText extends StatelessWidget {
  const TimerText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final duration = context.select((TimerBloc bloc)=> bloc.state.duration);


    final minutes = ((duration/60) % 60).floor().toString().padLeft(2,'0');
    final seconds = (duration % 60).floor().toString().padLeft(2,'0');

    return Text('$minutes:$seconds', style: const TextStyle(fontSize: 40));
  }
}
