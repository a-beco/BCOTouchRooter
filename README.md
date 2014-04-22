BCOTouchRooter
==============

##概要
全てのタッチイベントを任意のレシーバオブジェクトに通知するためのiOS用モジュールです。

通常だとタッチイベントは、-hitTest:で検出されたただ1つのUIResponder派生クラスしか受け取ることができません。しかし、複数かぶさっているビューの下層にもタッチイベントを伝搬したいことがあると思います。そういった場合に、BCOTouchRooterはタッチイベントが起こったことを任意のレシーバオブジェクトに通知することができます。BOCTouchReceiverプロトコルを実装しているあらゆるオブジェクトがレシーバオブジェクトとなります。

##使い方
レシーバオブジェクトとなるクラスにBCOTouchRooterをimportし、BCOTouchReceiverプロトコルを実装してください。その上で、-addReceiver:でレシーバを登録してください。レシーバの登録を解除するには-removeReceiver:を用います。
