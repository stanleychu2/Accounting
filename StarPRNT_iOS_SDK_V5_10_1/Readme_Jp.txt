************************************************************
      StarPRNT SDK Ver 5.10.1
         Readme_Jp.txt                  スター精密（株）
************************************************************

 1. 概要
 2. Ver 5.10.1 についての変更点
 3. 内容
 4. 適用
 5. 制限事項
 6. 著作権
 7. 変更履歴

==========
 1. 概要
==========

  本パッケージは、StarPRNT SDK Ver 5.10.1 です。
  StarIO/StarIO_Extension/SMCloudServicesは、Starプリンタを使用するアプリケーションの開発を
  容易にするためのライブラリです。

  本ソフトウェアは現在、iOS 8.0 - iOS 12.3に対応しています。

  詳細な説明は、ヘルプファイルを参照ください。


==============================
 2. Ver 5.10.1 についての変更点
==============================

  [StarIO]
    - バグ修正
      * LANインターフェイスでネットワークに存在しないプリンタに対してconnectAsyncメソッドを繰り
        返し実行するとアプリがクラッシュする場合がある問題を修正

  [StarIOExtension]
    - バグ修正
      * LANインターフェイスでネットワークに存在しないプリンタに対してconnectAsyncメソッドを繰り
        返し実行するとアプリがクラッシュする場合がある問題を修正
      * createBcrConnectParserメソッド、createDisplayConnectParserメソッド、
        createMelodySpeakerConnectParserメソッドを実行した時に発生していたメモリリークを修正


==========
 3. 内容
==========

  StarPRNT_iOS_SDK_V5_10_1
  |- Readme_En.txt                          // リリースノート (英語)
  |- Readme_Jp.txt                          // リリースノート (日本語)
  |- SoftwareLicenseAgreement_En.pdf        // ソフトウエア使用許諾書 (英語)
  |- SoftwareLicenseAgreement_Jp.pdf        // ソフトウエア使用許諾書 (日本語)
  |
  +- Documents
  |  |- StarPRNT_iOS_SDK_En.pdf             // StarPRNT SDKドキュメント (英語)
  |  |- StarPRNT_iOS_SDK_Jp.pdf             // StarPRNT SDKドキュメント (日本語)
  |  |- CommandEmulator_on_SMCS_En.pdf      // SMCSコマンドエミュレータのコマンド対応リスト (英語)
  |  +- CommandEmulator_on_SMCS_Jp.pdf      // SMCSコマンドエミュレータのコマンド対応リスト (日本語)
  |
  +- Software
  |  |- Distributables
  |  |  |- StarIO.framework                 // StarIO.framework (Ver 2.5.5)
  |  |  |- StarIO_Extension.framework       // StarIO_Extension.framework (Ver 1.13.1)
  |  |  +- SMCloudServices.framework        // SMCloudServices.framework (Ver 1.5)
  |  |
  |  |- ObjectiveC SDK                      // サンプルプログラム (Ver 5.10.1)
  |  +- Swift SDK                           // サンプルプログラム (Ver 5.10.1)
  |
  +- Others
     +- StarSoundConverter                  // メロディスピーカー向け音声変換ツール (Ver 1.0.0)


==========
 4. 適用
==========

  対応プリンタについてはStarPRNT SDKドキュメントを参照ください。

  対応エミュレーションについては以下になります。
     - StarPRNT
     - Star Line Mode
     - Star Graphic Mode
     - ESC/POS
     - ESC/POS Mobile
     - Star Dot Impact

      コマンドの詳細は各コマンド仕様書を参照ください。
      各マニュアルはスター精密のウェブサイトで入手可能です。


===============
 5. 制限事項
===============

  1. Bluetooth Low Energyモデルは、プリンターとの接続に時間がかかることがあります。
     詳しくはStarPRNT SDKドキュメントのgetPort API項を参照ください。

  2. Bluetoothでご利用の場合、メモリスイッチの"ASB機能"は、デフォルト設定(無効)のまま
     ご利用ください。(バンク7/ビットC)

  3. Bluetoothプリンタにて、iOS 10.0 - 10.2.1 および iOS 11.0 - 11.2.2において、getPort、begin/endCheckedBlockで
     エラーが発生し、その後searchPrinter APIで発見できなくなる事があります。
     iOS設定画面を見ると、『接続済み』と表示されますが、「一般」-「情報」に当該デバイス情報が
     表示されなくなります。

     [復帰方法]
     一旦プリンタ電源を切るか、iOS設定画面機能を使い、Bluetoothコネクションを切断し
     再接続します。

  4. 下記モデルにおいて、“writePort”を使用して大量のデータをプリンタに送信した後、データを送りきる前に
     ”releasePort”が実行されますと、アプリからプリンタを認識できず使用不能となる現象が確認されています。

     - SM-S210i (ファームウェア 3.1以降)
     - SM-S230i (ファームウェア 1.3)
     - SM-T300i (ファームウェア 3.1以降)
     - SM-T400i (ファームウェア 3.1以降)

     また、以下のモデルにおいて同様の処理が実行されますと、Bluetooth接続が切断される事があります。

     - mPOP

     (本現象はApple社へ報告済みです)

     StarPRNT SDKの場合、Communicationクラス内のsendCommandsメソッドでデータを送りきるまで
     writePortをループしていますが、指定時間内にデータを送りきれなかった場合は
     releasePortするようになっており、上記の現象が発生する事があります。
 
     本現象を防止するため、アプリで同様の処理を行う場合は、印刷データを送りきるのに十分な長さの時間を
     指定するようにしてください。
 
     なお、プリンタが使用不能な状態になった場合は"設定"の"Bluetooth"画面にてプリンタとの接続を一旦切断し
     再度接続することで再び使用可能となります。
     Bluetooth接続が切断された場合は、Auto Connection機能が有効であれば自動的に再接続されます。
     Auto Connectionが無効の場合はiOSの"設定"画面から手動で再接続を行ってください。

  5. 本SDKではiOS 11 にて稀にBluetoothプリンタと通信できなくなる現象を回避するため、getPort後に
     スリープを行っています。
     弊社の評価では、0.2秒のスリープを行うことで本現象が発生しないことを確認できましたが
     実際にお客様のアプリケーションで使用する際は十分に動作確認を行い、必要に応じて
     スリープ時間を適宜変更してください。

  6. 本パッケージ内のライブラリは、Xcode 10.1 にてビルドされています。
     アプリや他社ライブラリが異なるXcodeを用いてビルドされていた場合、Bitcodeのバージョンの違いにより、
     アプリのArchiveに失敗する事があります。

     このような場合、使用しているXcodeのバージョンを確認し、バージョンを揃えるか
     プロジェクト設定の"Build Settings" - "Build Options" - "Enable Bitcode"から
     Bitcode機能を無効にしてください。

  7. readPort メソッドの一部の振る舞いの変更
     - StarPRNT SDK 5.6.0より、EthernetインターフェイスでreadPortメソッドを実行した際に
       受信すべきデータがなかった場合の挙動を変更しました。
       - 変更前 : 例外をスロー
       - 変更後 : 成功を返す
 
    * SDK V5.5.0以前をご利用の際に、変更前の例外発生をキャッチする実装をされている
    　場合には、本修正に合わせたアプリ側の修正をお願いいたします。

  8. プリンターの電源をONした後にプリンターにmC-Soundを接続した場合、メロディスピーカーのAPIは正常に動作しません。
     プリンターにmC-Soundを接続した後にプリンターの電源をONしてください。

  9. mC-Print2/3のLANインターフェイス、TSP100LAN、TSP100IIILAN/Wを使用する場合、
     ネットワーク環境とホストデバイスによっては、稀にgetPortに失敗することがございます。
     弊社の評価では、portSettingsの引数に";l1000"を設定することで本現象が発生しなくなることを確認できましたが、
     実際にお客様のアプリケーションで使用する際には十分に動作確認を行い、必要に応じて適宜変更してください。


===========
 6. 著作権
===========

  スター精密（株）Copyright 2016-2019


=============
 7. 変更履歴
=============

  Ver 5.10.1
   2019/05/23 : [StarIO]
                 - バグ修正
                   * LANインターフェイスでネットワークに存在しないプリンタに対してconnectAsyncメソッドを繰り
                     返し実行するとアプリがクラッシュする場合がある問題を修正

                [StarIOExtension]
                 - バグ修正
                   * LANインターフェイスでネットワークに存在しないプリンタに対してconnectAsyncメソッドを繰り
                     返し実行するとアプリがクラッシュする場合がある問題を修正
                   * createBcrConnectParserメソッド、createDisplayConnectParserメソッド、
                     createMelodySpeakerConnectParserメソッドを実行した時に発生していたメモリリークを修正

  Ver 5.10.0
   2019/03/07 : [StarIO]
                 - 性能改善
                   * StarLine、StarPRNTエミュレーションのBluetoothプリンタ（SM-L200, SM-L300を除く）での
                     印字開始までの時間を短縮

               [StarIOExtension]
                 - 機能追加
                   * appendCjkUnifiedIdeographFontメソッドを追加
                     UTF-8におけるCJK統合漢字フォントの優先順位を指定可能
                      (mC-Print3, mC-Print2, TSP650II JP2/TWモデルのファームウェアバージョン4.0以降のみ対応)
                   * SCBBarcodeWidthにコマンド仕様に準拠したバーコードモード（シンボル幅）が指定されるExtModeを追加
                 - バグ修正
                   * LANインターフェイスで、StarIoExtManagerクラスのconnectAsyncメソッドを使用して、スタープリンタ
                     以外のデバイスに接続しようとするとSMResultCodeInUseErrorを返す場合があるため、
                     SMResultCodeFailedErrorを返すよう修正
                   * StarLineエミュレーション指定時、appendBitmapメソッドで生成したグラフィック下部にゴミ印字が
                     発生することがある問題を修正
                   * ページモード時、appendBitmapWithAbsolutePositionメソッドでpositionに0を指定しても、横軸
                     の印字開始位置が行頭に設定されない問題を修正

               [Objective-C SDK and Swift SDK]
                 - サンプルコードの追加
                   * UTF-8におけるCJK統合漢字 印字サンプルの実装例をappendCjkUnifiedIdeographFontメソッド
                     を使用するよう変更

  Ver 5.9.2
   2018/12/17 : [StarIO]
                 - getPortメソッド
                   * mC-Print2/3のLANインターフェイス、TSP100LAN、TSP100IIILAN/Wを利用して連続して接続する
                     際の機能改善

                [StarIOExtension]
                 - バグ修正
                   * StarIoExtManagerクラスのconnectメソッドでマネージメントを開始した後、対象プリンタが切断
                     されていないにも関わらずStarIoExtManagerDelegateプロトコルのdidAccessoryDisconnect
                     メソッドが呼ばれてしまう場合がある問題を修正

  Ver 5.9.1
   2018/11/28 : [StarIO]
                 - バグ修正
                   * Build SettingsのOther Linker Flagsに-all_loadが設定されている場合、シンボルの重複
                     エラーのためビルドに失敗する問題を修正

  Ver 5.9.0
   2018/11/20 : [StarIO]
                 - バグ修正
                   * LANインターフェイスで"l"オプションが設定されているにも関わらず、タイムアウトまで待たない
                     場合がある問題を修正

                [StarIOExtension]
                 - 機能追加
                   * メロディスピーカーのAPI対応
                 - バグ修正
                   * didFailToConnectPortメソッドで返すエラーコードが誤っていることがある問題を修正

                [SDK]
                 - サンプルコードの追加
                   * メロディスピーカー制御の実装例

  Ver 5.8.0
   2018/10/18 :   [StarIOExtension]
                   - StarIoExtManagerクラスに connectAsync APIを追加
                   - 不具合修正:
                     - [Bluetooth, Lightning]
                       connect実行後にプリンタの電源をオン・オフした際、対応するイベントが発生しない事がある
                       問題を修正。

                  [StarPRNT SDK]
                   - Xcode 10 対応
                   - バーコードリーダー側がスキャンしたデータにCR LFを付加する設定となっていると、スキャン後に
                     アプリがクラッシュする問題を修正
                   - connectAsync APIのサンプルコードを追加

  Ver 5.7.0
   2018/06/29 :   [StarIO]
                  - Objective-Cの例外をスローする可能性があるメソッドをSwiftから呼び出せないよう修正。
                  - Bug Fix:
                    - mC-PrintをLANインターフェースにて使用している時、プリンタエラー状態でbeginCheckedBlockを
                      使用すると例外がスローされる問題を修正。
                    - getFirmwareInformationメソッドの戻り値の末尾にゴミデータが付加される事がある問題を修正。
                    - バーコードリーダーからのデータ取得中にクラッシュする事がある問題を修正。

                 [StarIOExtension]
                  - 以下APIのサポート終了
                    - StarIoExtクラス
                      - createScaleCommandBuilderメソッド
                      - createScaleConnectParserメソッド
                      - createScaleWeightParserメソッド
                    - StarIoExtScaleModel列挙体
                    - ISSCBBuilderクラス
                    - ISCPParserクラス
                      - createReceiveCommandsメソッド
                    - ISSCWeightParserクラス

                  [SMCloudServices]
                  - 初回登録画面のUIで発生するメモリリークを修正。
                  - 機能追加
                    - SMCloudServices.ShowRegistrationWindow メソッド
                      SCSダッシュボードのパスワードを変更した場合に、
                      ローカルのパスワードを更新出来るようにしました。

                  [StarPRNT SDK]
                  - サンプルコードの追加
                    - 迂回印刷の実装例
                  - スケール用サンプルを削除。
                  - アラート表示に使用するクラスをUIAlertViewからUIAlertControllerに変更。

  Ver 5.6.0
   2018/05/21 :   [StarIO]
                  - 機能追加
                    - mC-Print2, mC-Print3に対応
                    - getPortメソッドのportSettingsパラメータに指定できるオプションを追加
                    - starPrinterStatus構造体にconnectedInterfaceプロパティを追加
                  - getPortメソッド
                    - モバイルプリンタのESC/POSエミュレーションを指定する方法を変更
                      変更前 : portNameが"TCP:xxx"かつ portSettingsに"portable"が含まれている
                      変更後 : portNameが"TCP:xxx"かつ portSettingsに"portable"と”escpos”が含まれている
                    - portNameの"BT:", "USB:"の後にプリンタのシリアルナンバーを指定する機能を追加
                  - readPort メソッド
                    - EthernetインターフェイスでreadPortメソッドを実行した際に受信すべきデータがなかった場合の挙動を変更
                      変更前 : 例外をスロー
                      変更後 : 成功を返す
                  - バグ修正
                      - USB接続にて、プリンタがエラーから復帰した直後の通信が失敗する問題を修正
                      - StarPRNTエミュレーションにて、SMBluetoothManagerのapply:メソッドが成功時にもNO(失敗)を返す問題を修正
                      - 一部の他社ライブラリとリンクエラーとなる問題を修正

                  [StarIOExtension]
                  - 機能追加
                    - トップマージンを設定するメソッドを追加
                    - 印字領域を設定するメソッドを追加
                    - appendSound:メソッドに駆動時間、ディレイ時間を設定するパラメータを追加

  Ver 5.5.0
   2018/02/06 : [StarIO]
                  - getFirmwareInformationメソッドでTSP100IIILAN/TSP100IIIWのファームウェアバージョンを
                    取得できるよう変更
                  - TSP100IIIUとTSP100IIIBIを同時にiOS端末に接続すると、TSP100IIIBIに印刷を実行した際に
                    TSP100IIIUから印刷されてしまう事がある問題を修正
                  - Bluetooth, USBのgetParsedStatus, beginCheckedBlock, endCheckedBlock APIについてコネ
                    クションの切断を検出してエラーを返すよう修正

                [StarIO_Extension.framework]
                  - 水平タブを設定・クリアするメソッドを追加

                [Objective-C SDK and Swift SDK]
                  - サンプルコードの追加
                    * UTF-8におけるCJK統合漢字 印字サンプルの実装例
                      (TSP650II JP2/TWモデル ファームウェアバージョン4.0以降のみ対応)

  Ver 5.4.1
   2017/10/20 : [Support OS]
                  - iOS 11をサポート

                [StarIO]
                  - Bluetooth Low EnergyのgetPortメソッドの信頼性を向上
                  - [ESC/POSモード] LANプリンタにて、印刷中にエラーが発生した時にendCheckedBlock APIが
                    例外をスローしてしまう問題を修正。

                [StarIO_Extension.framework]
                  - iOS 11
                    - connectメソッドでプリンタと通信できなくなる事がある問題を修正。

                [SMCloudServices.framework]
                  - iOS 11
                    - クローズボタンが拡大表示されてしまう問題を修正。

                [Objective-C SDK and Swift SDK]
                  - iOS 11
                    - BluetoothのgetPortメソッドにて、Bluetoothプリンタを認識できなくなる事がある問題を修正。
                    - 一部画面で印刷中に機内モードにするとクラッシュする問題を修正。
                  - プリンタ未選択状態では"Pairing and Connect Bluetooth"がDisableとなっていたのをEnableに変更。
                  - SP700選択時に"Print photo from Library", "Print Photo by Camera"が表示されていなかったのを
                    表示するよう変更。

  Ver 5.4.0
   2017/08/16 : [Support OS]
                  - 最低サポートOSバージョンを8.0に変更
                
                [StarIO]
                  - SM-T300DWとの通信の信頼性を向上

                [StarIO_Extension.framework]
                  - カスタマディスプレイ、スケールのAPI対応
                  - SM-Lシリーズ用のグラフィックデータ圧縮コマンドを生成する機能を追加

                [Objective-C SDK and Swift SDK]
                  - Bluetooth設定、ファームウェアバージョン取得、
                    シリアルナンバー取得、Frameworkバージョン取得機能を利用する実装例を追加

                [Swift SDK]
                  - Bundle IDをjp.star-m.Swift-SDKからjp.star-m.stariosdkに変更
                    既にVer 5.3.0をインストールしている場合、Ver 5.4.0は別のアプリとしてインストールされます

  Ver 5.3.0
   2017/04/03 : [StarIO]
                  - 対応モデル追加（TSP100IIIU, SM-L300(Bluetooth Low Energy))
                  - EthernetにてgetPortメソッドに失敗した時のパフォーマンスを改善

                [Objective-C SDK and Swift SDK]
                  - サンプルコードの追加
                    * BlackMark/PageModeの実装例

                [Swift SDK]
                  - Swift3対応

  Ver 5.2.1
   2017/02/08 : [StarIO]
                  - バグ修正
                    * ESC/POSモードのBluetoothモバイルプリンタがSniff Modeに入っていると、通信に失敗する事がある問題を修正

  Ver 5.2.0
   2017/01/19 : [StarIO]
                  - バグ修正
                    * モバイルプリンタ、mPOPに対し、SMBluetoothManagerクラスのapplyメソッドが失敗する事がある問題を修正
                    * BluetoothプリンタがSniff Modeに入っていると、通信に失敗する事がある問題を修正
                  - iOS 9対応
                    * getPort直後に実行したメソッドが失敗する事がある問題を修正
                  - iOS 10対応
                    * SM-S210i/SM-S220i/SM-T300i/SM-T400iがラスター印刷後に通信不能になる事がある問題を修正
                    * SM-L200が接続に時間がかかる問題を修正

                [StarIO_Extension]
                  - バグ修正
                    * StarIoExtManagerクラスのconnectメソット?/disconnectメソッドを合わせてリエントラント（再入）禁止に修正
                      （connectメソッド処理中のdisconnectメソッド呼び出しなどにおいて内部不整合が生じるため）

                [SMCloudServices]
                  - バージョンアップ
                    * SMCSAllReceiptsクラスにuploadDataメソット?を追加
                      uploadDataメソッドで送信したデータはSMCSコマンドエミュレータによりデジタルレシート画像にレンダリングされます。
                      SMCSコマンドエミュレータで使用可能なコマンドはCommandEmulator_on_SMCS_Jp.pdfを参照ください。
                    * MicroReceipt機能を追加
                      MicroReceipts機能は印刷用紙の削減を提供します。

                [Objective-C SDK and Swift SDK]
                  - サンプルコードの追加
                    * StarPRNT/StarLine/ESCPOSにおけるAllReceipts対応の実装例
                    * mPOPで使用可能なUSB周辺機器対応（はかり、カスタマーディスプレイ）の実装例
                  - AllReceiptsコマンドエミュレータのコマンド対応リストを追加

  Ver 5.0.2
   2016/08/25 : [StarIO]
                  - StarPRNTエミュレーションに設定されたモバイルプリンタにおいて
                    connectedプロパティおよびgetOnlineStatusメソッドが機能しない問題を修正

  Ver 5.0.1
   2016/08/11 : [Objective-C SDK and Swift SDK]
                  - サンプルコードの追加
                    * カメラとフォトライブラリの印刷
                    * Bluetooth接続と切断
                    * ポート名とポート設定の手動入力
                    * キャッシュドロワの開閉センサの選択
                    * デバイスステータスの確認
                    * ドイツ語のサンプル印刷
                    * アプリケーション状態遷移の実装例

                [StarIO.framework]
                  - バージョンアップ
                    * API内の軽微な変更

                [StarIO_Extension.framework]
                  - バグ修正
                    * 接続と切断の繰り返し呼び出しへの対策

                [SMCloudServices.framework]
                  - バージョンアップ
                    * API内の軽微な変更.

  Ver 5.0.0
   2016/03/28 : 新規発行
