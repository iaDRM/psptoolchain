#!/bin/sh

install_libusb() {
	wget --continue http://downloads.sourceforge.net/project/libusb/libusb-0.1%20%28LEGACY%29/0.1.12/libusb-0.1.12.tar.gz -O libusb-legacy.tar.gz
	rm -Rf libusb-legacy && mkdir libusb-legacy && tar --strip-components=1 --directory=libusb-legacy -xzf libusb-legacy.tar.gz
	cd libusb-legacy
	./configure && make CFLAGS="-Wno-error" CPPFLAGS="-Wno-error" && make install
	cd ../
	rm -Rf libusb-legacy && rm libusb-legacy.tar.gz
}

if [ -e "/opt/local/bin/port" ]; then
	if [[ $UID != 0 ]]; then
	    echo "Please run this script with sudo"
	    exit 1
	fi

	port install wget
	port install libelf
	port install libmpc
	port install libusb
	port install autoconf
	port install automake
	port install libtool
	port install cmake
	port install libsdl
	port install doxygen
	port install readline

	port install gcc49
	port install gcc_select

	# Build with clang
	port select --set gcc none

	install_libusb

	# Switch to GNU variants
	mkdir gnubin

	port select --set gcc mp-gcc49

	port install gsed
	ln -s /opt/local/bin/gsed gnubin/sed

	port install gmake
	ln -s /opt/local/bin/gmake gnubin/make

	port install libtool
	ln -s /opt/local/bin/glibtoolize gnubin/libtoolize

	echo "Note: MacPort's GCC selected."
	echo "      To switch back to clang, run: sudo port select --set gcc none"
	echo "      To switch back to MacPort's gcc, run: port select --set gcc mp-gcc49"

elif [ -e "/usr/local/bin/brew" ]; then
	CURRENT_USER=$(stat -f '%Su' /dev/console)
	sudo -u $CURRENT_USER brew install wget
	sudo -u $CURRENT_USER brew install libelf
	sudo -u $CURRENT_USER brew install libmpc
	sudo -u $CURRENT_USER brew install libusb

	sudo -u $CURRENT_USER brew install libusb-compat
else
	echo "Go install MacPorts from http://www.macports.org/ or Homebrew from http://brew.sh/ first, then we can talk"
fi

