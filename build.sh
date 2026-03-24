autoreconf -i

./configure --with-flint=/opt/homebrew --enable-native --disable-float

make -j$(sysctl -n hw.ncpu)