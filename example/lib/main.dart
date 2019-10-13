// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ytview/ytview.dart';

void main() => runApp(
      MaterialApp(
        home: WebViewExample(),
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
      ),
    );

class WebViewExample extends StatefulWidget {
  @override
  _WebViewExampleState createState() => _WebViewExampleState();
}

class _WebViewExampleState extends State<WebViewExample> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  String get player {
    String _player = '''
    <!DOCTYPE html>
    <html>
    <head>
        <style>
            html,
            body {
                height: 100%;
                width: 100%;
                margin: 0;
                padding: 0;
                background-color: #000000;
                overflow: hidden;
                position: fixed;
            }
        </style>
        <meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no'>
    </head>
    <body>
        <div id="player"></div>
        <script>
            var tag = document.createElement('script');
            tag.src = "https://www.youtube.com/iframe_api";
            var firstScriptTag = document.getElementsByTagName('script')[0];
            firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);
            var player;
            function onYouTubeIframeAPIReady() {
                player = new YT.Player('player', {
                    height: '100%',
                    width: '100%',
                    videoId: '50kklGefAcs',
                    playerVars: {
                        'controls': 0,
                        'autoplay': 0,
                        'playsinline': 1,
                        'enablejsapi': 1,
                        'fs': 0,
                        'rel': 0,
                        'showinfo': 0,
                        'iv_load_policy': 3,
                        'modestbranding': 1,
                        'cc_load_policy': 1,
                    },
                });
            }
        </script>
    </body>
    </html>
    ''';
    return 'data:text/html;base64,${base64Encode(const Utf8Encoder().convert(_player))}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('YtView example'),
      ),
      body: WebView(
        initialUrl: player,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
        initialMediaPlaybackPolicy: AutoMediaPlaybackPolicy.always_allow,
        onPageFinished: (String url) {
          print('Video Loaded');
        },
      ),
    );
  }
}
