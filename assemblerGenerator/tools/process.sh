make clean
make
# ./bin2asm -hex ./exes/gaussian 1

echo "start executing decode ...."

echo "-1" > persistent61.txt
cp persistent61.txt tempPersistent.txt
./decode tempKernel.txt < tempPersistent.txt > persistent61.txt

