/*
    Copyright 2021-2022. Huawei Technologies Co., Ltd. All rights reserved.

    Licensed under the Apache License, Version 2.0 (the "License")
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        https://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/

import 'package:flutter/services.dart';
import 'package:huawei_ml_text/huawei_ml_text.dart';

class MLTextAnalyzer implements TextAnalyzer<dynamic, MLTextAnalyzerSetting> {
  late MethodChannel _channel;

  MLTextAnalyzer() {
    _channel = const MethodChannel("$baseChannel.text_analyzer");
  }

  Future<int> getAnalyzeType() async {
    return await _channel.invokeMethod("text#getAnalyzeType");
  }

  Future<bool> stop() async {
    return await _channel.invokeMethod("text#stop");
  }

  @override
  Future<List<TextBlock>> analyseFrame(MLTextAnalyzerSetting setting) async {
    final List result =
        await _channel.invokeMethod("text#analyseFrame", setting.toMap());
    return result.map((e) => TextBlock.fromMap(e)).toList();
  }

  @override
  Future<MLText> asyncAnalyseFrame(MLTextAnalyzerSetting setting) async {
    return MLText.fromMap(
        await _channel.invokeMethod('text#asyncAnalyseFrame', setting.toMap()));
  }

  @override
  Future<bool> destroy() async {
    return await _channel.invokeMethod("text#destroy");
  }

  @override
  Future<bool> isAvailable() async {
    return await _channel.invokeMethod("text#isAvailable");
  }
}
