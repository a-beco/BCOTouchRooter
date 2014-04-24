BCOTouchRooter
==============

##概要
全てのタッチイベントを任意のレシーバオブジェクトに通知するためのiOS用モジュールです。

通常だとタッチイベントは、-hitTest:で検出されたただ1つのUIResponder派生クラスしか受け取ることができません。しかし、複数かぶさっているビューの下層にもタッチイベントを伝搬したいことがあると思います。そういった場合に、BCOTouchRooterはタッチイベントが起こったことを任意のレシーバオブジェクトに通知することができます。

BOCTouchReceiverプロトコルを実装しているあらゆるオブジェクトがレシーバオブジェクトとなります。

##基本的な使い方
レシーバオブジェクトとなるクラスにBCOTouchRooterをimportし、BCOTouchReceiverプロトコルを実装してください。その上で、-addReceiver:でレシーバを登録してください。レシーバの登録を解除するには-removeReceiver:を用います。

##フィルタ
レシーバオブジェクトへの通知を一時的に停止したり、特定の条件のときのみ通知を拒否する場合はBCOTouchFilterを用います。このインスタンスはBCOTouchRooterから取得でき、レシーバオブジェクトと１対１で紐づいています。これにより、レシーバオブジェクトごとに細かい設定が可能です。

また、通常のタッチイベントのON/OFFを切り替えることもできます。あらゆるタッチイベントを無効にするといったの処理を下のような１行のコードで実現できます。

````objective-c
[[BCOTouchRooter sharedRooter] defaultFilter].blocked = YES;
````
