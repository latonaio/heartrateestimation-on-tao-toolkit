# vehicletypenet-on-tao-toolkit
vehicletypenet-on-tao-toolkit は、NVIDIA TAO TOOLKIT を用いて VehicleTypeNet の AIモデル最適化を行うマイクロサービスです。  

## 動作環境
- NVIDIA 
    - TAO TOOLKIT
- VehicleTypeNet
- Docker
- TensorRT Runtime

## VehicleTypeNetについて
VehicleTypeNet は、画像内の車を検出し、６種類の車種に分類したカテゴリラベルを返すAIモデルです。  
VehicleTypeNet は、特徴抽出にResNet18を使用しており、混雑した場所でも正確に物体検出を行うことができます。  
なお、VehicleTypeNet は、DashCamNetのモデルで検知された車に対して、車種を分類するモデルのため、VehicleTypeNet のリソースと合わせて利用されます。 

## 動作手順

### engineファイルの生成
VehicleTypeNet のAIモデルをデバイスに最適化するため、ResNet18 における VehicleTypeNet の .etlt ファイルを engine file に変換します。
engine fileへの変換は、Makefile に記載された以下のコマンドにより実行できます。

```
tao-convert:
        docker exec -it vehicletypenet-tao-toolkit tao-converter -k tlt_encode -t fp16 -d 3,224,224 -e /app/src/vehicletypenet.engine /app/src/resnet18_vehicletypenet_pruned.etlt
```

## 相互依存関係にあるマイクロサービス  
本マイクロサービスで最適化された VehicleTypeNet の AIモデルを Deep Stream 上で動作させる手順は、[vehicletypenet-on-deepstream](https://github.com/latonaio/vehicletypenet-on-deepstream)を参照してください。  

## engineファイルについて
engineファイルである vehicletypenet.engine は、[vehicletypenet-on-deepstream](https://github.com/latonaio/vehicletypenet-on-deepstream)と共通のファイルであり、本レポジトリで作成した engineファイルを、当該リポジトリで使用しています。  
