import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:comfort_confy/components/platform/platform.dart';
import 'package:comfort_confy/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:web_socket_channel/io.dart';
import '../../../services/rest_api/leave_conference.dart';
import '../widgets/participant_card.dart';
import 'package:image/image.dart' as img;

class ConferencePage extends StatefulWidget{
  final String roomId;
  final String conferenceName;
  final bool isHost;

  const ConferencePage({super.key, required this.roomId, required this.conferenceName, required this.isHost,});

  @override
  State<ConferencePage> createState() => _ConferencePageState();
}

class _ConferencePageState extends State<ConferencePage> with WidgetsBindingObserver {
  List<Map<String, dynamic>> participants = [];

  late IOWebSocketChannel _channel;

  late FlutterSoundRecorder _recorder;
  late CameraController _cameraController;

  bool _isMicOn = true;
  bool _isCameraOn = true;

  StreamController<Uint8List> recordingDataController = StreamController<Uint8List>();
  
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializePermissions();
  }

  Future<void> _initializePermissions() async {
    final status = await [Permission.camera, Permission.microphone].request();
    if (status[Permission.camera]!.isGranted && 
        status[Permission.microphone]!.isGranted) {
      _initializeWebsocket();
      _initializeCamera();
      _initializeMicrophone();
    } else {
      // Обработка отказа в разрешениях
    }
  }

  void _initializeWebsocket() {
    try {
      print('Попытка подключения к WebSocket...');
      _channel = IOWebSocketChannel.connect(
        Uri.parse('ws://$baseUrl:8000/ws/${widget.roomId}'),
      );
      print('Подключение к WebSocket успешно.');

      _channel.stream.handleError((error) {
        print('WebSocket error: $error');
      }).listen((message) {
        print('Получено сообщение: $message');
        setState(() => participants = _parseParticipants(message));
      });
    } catch (e) {
      print('WebSocket init error: $e');
    }
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      _cameraController = CameraController(cameras.first, ResolutionPreset.medium);
      await _cameraController.initialize();
      
      if (_isCameraOn) {
        await _cameraController.startImageStream((image) {
          // Конвертация CameraImage в JPEG
          final planes = image.planes.map((plane) => plane.bytes).toList();
          final jpeg = img.encodeJpg(
            img.Image.fromBytes(
              image.width,
              image.height,
              image.planes[0].bytes,
              format: img.Format.argb,
            ),
          );
          _channel.sink.add(jpeg);
        });
      }
    } catch (e) {
      print('Camera error: $e');
    }
  }

  void _initializeMicrophone() async {
    _recorder = FlutterSoundRecorder();
    await _recorder.openRecorder();

    if (_isMicOn) {
      await _recorder.startRecorder(
        toStream: recordingDataController.sink,
        codec: Codec.pcm16, // Используйте подходящий кодек
        sampleRate: 16000,
        numChannels: 1,
        bitRate: 16000,
      );
    }
  }

  List<Map<String, dynamic>> _parseParticipants(dynamic message) {
    try {
      final data = json.decode(message);
      return List<Map<String, dynamic>>.from(data['participants']);
    } catch (e) {
      print('Parse error: $e');
      return [];
    }
  }

  void _toggleMic() async {
    setState(() => _isMicOn = !_isMicOn);
    
    if (_isMicOn) {
      await _recorder.startRecorder(
        toStream: recordingDataController.sink, // Используем StreamController напрямую
        codec: Codec.defaultCodec,
        sampleRate: 16000,
      );
      
      // Подписываемся на поток аудиоданных и отправляем через WebSocket
      recordingDataController.stream.listen((data) {
        _channel.sink.add(data);
      });
    } else {
      await _recorder.stopRecorder();
      recordingDataController.stream.drain(); // Очищаем поток
    }
  }

  void _toggleCamera() async {
    setState(() => _isCameraOn = !_isCameraOn);
    
    if (_isCameraOn) {
      await _cameraController.resumePreview();
      await _cameraController.startImageStream((image) {
      // Повторно добавляем обработчик кадров
      final jpeg = img.encodeJpg(
        img.Image.fromBytes(
          image.width,
          image.height,
          image.planes[0].bytes,
          format: img.Format.argb,
        ),
      );
      _channel.sink.add(jpeg);
    });
    } else {
      await _cameraController.stopImageStream();
      await _cameraController.pausePreview();
    }
  }

  @override
  void dispose() {
    _channel.sink.close();
    _recorder.closeRecorder();
    _cameraController.dispose();
    recordingDataController.close();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.conferenceName,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: _toggleMic,
              icon: Icon(_isMicOn ? Icons.mic : Icons.mic_off),
            ),
            IconButton(
              icon: Icon(_isCameraOn ? Icons.videocam : Icons.videocam_off),
              onPressed: _toggleCamera,
            ),
            IconButton(
              icon: const Icon(Icons.exit_to_app),
              onPressed: () {
                // _leaveConference(widget.roomId);
              },
            ),
          ],
        ),
        body: ListView.builder(
          itemCount: participants.length,
          itemBuilder: (context, index) {
            final participant = participants[index];
            return ParticipantCard(
              email: participant['email'],
              isMicOn: participant['isMicOn'],
              isCameraOn: participant['isCameraOn'],
              videoStream: participant['videoStream'],
            );
          },
        ),
      ),
    );
  }
}