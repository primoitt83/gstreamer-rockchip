#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

sudo apt install -y pkg-config autopoint gettext libtool libglib2.0-dev liborc-0.4-dev gtk-doc-tools cmake

##Gstreamer required packages
sudo apt install -y libqt5opengl5 libqt5qml5 libqt5quick5 libqt5widgets5 libqt5gui5 libqt5core5a \
qml-module-qtquick2 libqt5multimedia5 libqt5multimedia5-plugins libqt5multimediaquick5 \
qtmultimedia5-examples qtmultimedia5-doc-html gcc make git unzip wget xz-utils devscripts equivs \
build-essential docutils-common mercurial cmake-curses-gui yasm gcc-arm-none-eabi texinfo \
nasm automake qtgstreamer-plugins-qt5 libgtk2.0-dev libperl-dev \ 
libjack-dev libass-dev libfdk-aac-dev fdkaac aac-enc libfdk-aac1 autoconf automake git-core \
libfreetype6-dev libsdl2-dev libva-dev libvdpau-dev libvorbis-dev libxcb1-dev libxcb-shm0-dev \ 
libxcb-xfixes0-dev zlib1g-dev libx264-dev libx265-dev libnuma-dev libvpx-dev libmp3lame-dev libopus-dev \
mc locate libghc-bzlib-dev speex libspeex-dev alsa libssl-dev libgettextpo-dev

#mkdir -p $DIR/gstreamer-rockchip

git clone https://github.com/primoitt83/gstreamer-rockchip.git

cd $DIR/gstreamer-rockchip/mpp/
cmake -DRKPLATFORM=ON -DHAVE_DRM=ON 
time make -j4
sudo make install
cd ..

cd $DIR/gstreamer-rockchip/gstreamer/
./autogen.sh --disable-gtk-doc --enable-static --enable-shared --prefix=/usr
time make -j4 ERROR_CFLAGS=""
sudo make install
cd ..

cd $DIR/gstreamer-rockchip/gst-plugins-base/
./autogen.sh --disable-gtk-doc --enable-static --enable-shared --prefix=/usr --disable-fatal-warnings
time make -j4
sudo make install
cd ..

cd $DIR/gstreamer-rockchip/gst-plugins-good/
./autogen.sh --disable-gtk-doc --enable-static --enable-shared --prefix=/usr --disable-fatal-warnings
time make -j4
sudo make install
cd ..

cd $DIR/gstreamer-rockchip/gst-plugins-ugly/
./autogen.sh --disable-gtk-doc --enable-static --enable-shared --prefix=/usr --disable-fatal-warnings
time make -j4
sudo make install
cd ..

cd $DIR/gstreamer-rockchip/gst-plugins-bad/
./autogen.sh --disable-gtk-doc --enable-static --enable-shared --prefix=/usr --disable-fatal-warnings
time make -j4
sudo make install
cd ..

cd $DIR/gstreamer-rockchip/gst-libav/
./autogen.sh --disable-gtk-doc --enable-static --enable-shared --prefix=/usr --disable-fatal-warnings
time make -j4
sudo make install
cd ..

cd $DIR/gstreamer-rockchip/gstreamer-rockchip
./autogen.sh --disable-gtk-doc --enable-static --enable-shared --prefix=/usr --disable-fatal-warnings
time make -j4
sudo make install
ldconfig
cd ..

cd $DIR/gstreamer-rockchip/gstreamer-rockchip-extra
./autogen.sh --disable-gtk-doc --enable-static --enable-shared --prefix=/usr --disable-fatal-warnings
make clean
time make -j4
make install
ldconfig
cd ..

# cd $DIR/gstreamer-rockchip/rockchip_mirrors/
# mkdir build
# meson build
# cd build
# time ninja -j4
# ninja install


#export LD_LIBRARY_PATH=/usr/local/lib/
#gst-launch-1.0 -v dvbsrc frequency=503000000 delsys="atsc" modulation="8vsb" pids=49:52:3 ! decodebin ! videoconvert ! videoscale ! video/x-raw,width=1280,height=720 ! omxh264enc target-bitrate=2000000 control-rate=variable ! mpegtsmux ! hlssink max-files=5 playlist-location=/tmp/live/stream.m3u8 
#gst-launch-1.0 -v dvbsrc frequency=503000000 delsys="atsc" modulation="8vsb" pids=49:52:3 ! decodebin ! videoconvert ! videoscale ! video/x-raw,width=1280,height=720 ! mpph264enc ! mpegtsmux ! hlssink max-files=5 playlist-location=/tmp/live/stream.m3u8
#sudo LD_LIBRARY_PATH=/usr/local/lib bash -c "gst-launch-1.0 -v dvbsrc frequency=503000000 delsys=atsc modulation=8vsb pids=49:52:3 ! decodebin ! videoconvert ! videoscale ! video/x-raw,width=1280,height=720 ! mpph264enc ! mpegtsmux ! hlssink max-files=5 playlist-location=/tmp/live/stream.m3u8"
#