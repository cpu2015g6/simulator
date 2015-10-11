# simulator

●逆アセンブラ＆シミュレータ</br>
make</br>
./a バイナリ</br>
でアセンブリとシュミレーションのログを出します。

●アセンブラ</br>
./asm.py アセンブリ</br>
でバイナリを出します。

↓アセンブリファイルの例↓</br>
limm 0x12 0xcafe      ;コメントがかけます。</br>
add 1 2 3  ;区切りはtabとか空白複数でも大丈夫です。</br>
fmul 2 3 4</br>
;コメントだけの行もかけます。</br>
j 0xff -1             ;即値は符号付き10進数か16進数(0x??の形)で</br>
neq 0x12 34 0x56      ;レジスタ指定は10進数か16進数(0x??の形)で</br>
</br>
●全体的なデバッグ</br>
make
./debug.sh アセンブリ</br>
で、バイナリにしてまたアセンブリに戻した結果と、</br>
シミュレーションのログを合わせたものを出します。</br>
デバッグに便利だと思います。</br>