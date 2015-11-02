cp $1 "tempdayo"
echo "Assember:"
python ./asm.py tempdayo
echo "Disassmebler&Simulator:"
./a tempdayo.dat

echo "to binary and back to assembly" > tempdayo.res
cat tempdayo.com >> tempdayo.res
echo "

          |
          v
" >> tempdayo.res
cat tempdayo.myasm >> tempdayo.res
echo "
" >> tempdayo.res
cat tempdayo.log >> tempdayo.res

a='.res'
mv tempdayo.res $1$a

rm tempday*

echo "Results:"
echo "Dumped $1$a"
