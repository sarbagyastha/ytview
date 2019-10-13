// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#import "WebViewFlutterPlugin.h"
#import "YTCookieManager.h"
#import "FlutterWebView.h"

@implementation YTWebViewFlutterPlugin

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  YTWebViewFactory* webviewFactory =
      [[YTWebViewFactory alloc] initWithMessenger:registrar.messenger];
  [registrar registerViewFactory:webviewFactory withId:@"plugins.flutter.io/webview"];
  [YTCookieManager registerWithRegistrar:registrar];
}

@end
