BCOTouchRooter
==============

#概要
全てのタッチイベントを通知するためのモジュール。
通常だとタッチイベントはhitTestで検出された１つのUIResponderしか
受け取ることができません。

しかし、複数かぶさっているビューの下層にもタッチイベントを
伝搬したいことがあると思います。

そういった場合に、通常のタッチイベントはそのままに
タッチイベントが起こったことを任意のオブジェクトに通知することができます。

BOCTouchReceiverプロトコルを実装している
あらゆるオブジェクトがレシーバオブジェクトとなれるため、
さまざまな使い道が考えられます。

ただし、プログラムの流れが複雑化しないよう
気をつける必要があるかもしれません。

#使い方
レシーバオブジェクトとなるクラスに
BCOTouchRooterをimportし、BCOTouchReceiverプロトコル
を実装してください。

その上で、-addReceiver:でレシーバを登録してください。
レシーバの登録を解除するには-removeReceiver:を用います。
