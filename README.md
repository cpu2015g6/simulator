# simulator

●逆アセンブラ
make</br>
./a バイナリ</br>
でアセンブリを出します。

●アセンブラ
./asm.py アセンブリ</br>
でバイナリを出します。

↓アセンブリファイルの例↓</br>
limm 0x12 0xcafe      ;コメントがかけます。</br>
     add 1   2     3  ;区切りはtabでも大丈夫です。</br>
fmul 2 3 4</br>
j 0xff -1             ;数字は符号付き10進数か16進数(0x??の形)で</br>
neq 0x12 34 0x56      </br>
