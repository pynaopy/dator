module MsgConst
  MSG = {
    1 => "{0}を入力してください。",
    2 => "{0}は{1}文字まで入力できます。",
    3 => "すでに使用されています。",
    4 => "ユーザー名かパスワードが間違っています。"}
    .map{|k, v| [k, v.freeze]}.to_h.freeze # 要素追加不可。メッセージ変更不可。

  # 番号に対応するメッセージを返す。<br>
  # 対応する番号がないときは空文字を返す。<br>
  # 引数が渡って来なかった場合は0番のメッセージを返す。
  #（0番は宣言してないので実質空文字を返す。）
  # @example
  #    MsgConst.read(1) => "{0}を入力してください。"
  #    MsgConst.read(1, '名前') => "名前を入力してください。"
  #    MsgConst.read(2, '番号', 4) => "番号は4文字まで入力できます。"
  # @param [Int] メッセージ番号
  # @param [Object] 置換文字
  # @return [String] メッセージ
  def self.read(num = 0, *args)
    msg = MSG[num]
    return "" if msg.blank?

    # argsがあるならmsgの{0}とか{1}とかをargsの内容で置換
    args.each_with_index do |arg, i|
      ptn = Regexp.escape("{#{i}}") # {0}, {1}, {2}, ...
      msg = msg.sub(/#{ptn}/, arg.to_s)
    end

    return msg
  end
end
MsgConst.freeze # このモジュールへの変更を不可にする。MSGへの再代入防止。
