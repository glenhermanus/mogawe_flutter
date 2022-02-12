
import 'package:flutter/cupertino.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';

class AudioRecordFunc{
  FlutterSoundRecorder? flutterSoundRecorder;
  FlutterSoundPlayer? flutterSoundPlayer;
  bool recordinisialisasi = false;
  final pathaudio = 'audio_coba.aac';
  bool get isRecord => flutterSoundRecorder!.isRecording;
  bool get isPlay => flutterSoundPlayer!.isPlaying;

  Future init() async{
    flutterSoundRecorder = FlutterSoundRecorder();
    flutterSoundPlayer = FlutterSoundPlayer();
    final status = await Permission.microphone.request();
    if(status != PermissionStatus.granted){
      throw RecordingPermissionException('Izin Mic Tidak Ada');
    }
    // await flutterSoundRecorder!._openAudioSession();
    // await flutterSoundPlayer!._openAudioSession();
    recordinisialisasi = true;
  }
  void dispose(){
    if(!recordinisialisasi) return;
    // flutterSoundRecorder!.closeAudioSession();
    // flutterSoundPlayer!.closeAudioSession();
    flutterSoundPlayer = null;
    flutterSoundRecorder = null;
    recordinisialisasi = false;
  }

  Future play(VoidCallback whenfinished) async{
    await flutterSoundPlayer!.startPlayer(fromURI: pathaudio, whenFinished: whenfinished);
  }

  Future record() async{
    if(!recordinisialisasi) return;
    await flutterSoundRecorder!.startRecorder(toFile: pathaudio);
  }


  Future stop() async{
    if(!recordinisialisasi) return;
    await flutterSoundRecorder!.stopRecorder();
  }

  Future stopplay() async{
    if(!recordinisialisasi) return;
    await flutterSoundPlayer!.stopPlayer();
  }

  Future switchplay({required VoidCallback whenfinished}) async{
    if(flutterSoundPlayer!.isStopped){
      await play(whenfinished);
    }
    else{
      await stopplay();
    }
  }

  Future switchrecord() async{
    if(flutterSoundRecorder!.isStopped){
      await record();
    }
    else{
      await stop();
    }
  }

}