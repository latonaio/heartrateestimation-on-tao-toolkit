# heartrateestimation-on-tao-toolkit
heartrateestimation-on-tao-toolkit は、NVIDIA TAO TOOLKIT を用いて HeartRateEstimation の AIモデル最適化を行うマイクロサービスです。  

## 動作環境
- NVIDIA 
    - TAO TOOLKIT
- HeartRateEstimation
- Docker
- TensorRT Runtime

## HeartRateEstimationについて
HeartRateEstimation は、画像内の顔を検出し、心拍数を返すAIモデルです。  
HeartRateEstimation は、特徴抽出にConvolutional Attention Networksを使用しています。  

## 動作手順

### engineファイルの生成
HeartRateEstimation のAIモデルをデバイスに最適化するため、HeartRateEstimation の .etlt ファイルを engine file に変換します。
engine fileへの変換は、Makefile に記載された以下のコマンドにより実行できます。

```
tao-convert:
	docker exec -it heartrate-tao-toolkit tao-converter -k nvidia_tlt -p motion_input:0,1x3x72x72,16x3x72x72,16x3x72x72 -p appearance_input:0,1x1x3x72x72,1x16x3x72x72,1x16x3x72x72 \
		-t fp16 -d 3,72,72 -e /app/src/heartrate.engine /app/src/model.etlt
```

## 相互依存関係にあるマイクロサービス  
本マイクロサービスで最適化された HeartRateEstimation の AIモデルを Deep Stream 上で動作させる手順は、[heartrateestimation-on-deepstream](https://github.com/latonaio/heartrateestimation-on-deepstream)を参照してください。  

## engineファイルについて
engineファイルである heartrate.engine は、[heartrateestimation-on-deepstream](https://github.com/latonaio/heartrateestimation-on-deepstream)と共通のファイルであり、本レポジトリで作成した engineファイルを、当該リポジトリで使用しています。  

## 演算について
本レポジトリでは、ニューラルネットワークのモデルにおいて、エッジコンピューティング環境での演算スループット効率を高めるため、FP16(半精度浮動小数点)を使用しています。  
浮動小数点値の変更は、Makefileの以下の部分を変更し、engineファイルを生成してください。

```
tao-convert:
	docker exec -it heartrate-tao-toolkit tao-converter -k nvidia_tlt -p motion_input:0,1x3x72x72,16x3x72x72,16x3x72x72 -p appearance_input:0,1x1x3x72x72,1x16x3x72x72,1x16x3x72x72 \
		-t fp16 -d 3,72,72 -e /app/src/heartrate.engine /app/src/model.etlt
```