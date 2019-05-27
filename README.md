# UE4AutomationRakushitai

第3回UE4何でも勉強会 in 東京( https://ue4allstudy.connpass.com/event/129917/ )で講演しました  
「自動テストでもっと楽したい！」のサンプルプロジェクトになります。

スライドは下記です  
https://www.slideshare.net/com044/ue4-147749405

UE4のAutomation Testを使用しています。  
セッションフロントエンドのオートメーションタブのこの辺りです  
![2019-05-27_19h24_36](https://user-images.githubusercontent.com/11537958/58415091-5b8fcf80-80b8-11e9-8fa0-7ec2a6144d8b.png)



各種、csv形式で見ることを前提にログを出しています

## テクスチャのグループ設定が正しく設定されているか
/Test/01_TextureGroup/BP_TestTextureGroup
- ログは「テクスチャパス, 設定されているグループ, 本来設定されるべきグループ」
- チェック内容
    - /Characters/フォルダは「Character」か「CharacterNormalMap」のみ許可
    - /Environments/フォルダは「World」か「WorldNormalMap」のみ許可
    - /Particles/フォルダは「Effects」のみ許可
    - /UI/フォルダは「UI」のみ許可
- 実装メモ
    - 法線マップの判定はアセット名に「_N」が入っているかになっています。（T_Noとかでも法線判定されるのでもう少しキッチリすべきですね）

## テクスチャのサイズが大きすぎないか
/Test/02_TextureSize/BP_TestTextureSize
- ログは「テクスチャパス, サイズX, サイズY」
- チェック内容
    - テクスチャがBP設定のErrorMaxSize以上であれば警告を出しています

## マテリアルのレギュレーションチェック
/Test/03_MaterialRegulation/BP_TestMaterialRegulation
- ログは「マテリアルパス, Automatically Set Usage in Editor」
- チェック内容
    - Automatically Set Usage in Editor有効のみ調べています

## レベルのチェック
/Test/04_LevelCheck/BP_TestLevelCheck

- ログは「Actor名, ActorTickでエラーか, ComponentTickでエラーか, PlanarReflection使っているか, 可動性でエラー出ているか」
- チェック内容
    - Tickが有効になっていないかチェック（パーティクルはOK）
    - 使っては駄目Componentのチェック（PlanarReflectionComponentのみ）
    - 可動性がStatic以外になっていないかチェック（ライトや物理挙動するものはOK）
    - 平行光が2つ以上非Staticで存在しないかチェック
- 実装メモ
    - BPの"Exclusion Actor Classes"にクラスを設定すると、そのクラスは調査しません


## レベルのスクリーンショット撮影
/Test/05_ScreenShot/BP_TestScreenShot

- チェック内容
    - このテストを配置したトランスフォームからシーンを撮影します
        - Saved/ScreenShots/Windows/ の中に保存されます
        - {年}{月}{日}＿{時}＿{レベル名}＿{撮影種類}.pngで保存されます
        - Base: そのまま撮影
        - Stat: Stat SceneRendering, Memoryを表示して撮影
        - LightComplexity: ライト複雑度を撮影。ただし、エディターから実行した時のみです
        - QuadOverdraw: 1ピクセルに複数描画されている情報で撮影。ただし、エディターから実行した時のみです
    - 合わせてCSV Profileを取っています
        - Saved/Profiling/CSV/ の中に保存されます
