# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# TODO
# - Verify all runtime dependencies, min versions, and required flags
# - Include desktop stuff
# - QA_PREBUILT list

EAPI=5
inherit unpacker

DESCRIPTION="Music production and performance system"
HOMEPAGE="http://bitwig.com/"
SRC_URI="http://packs.bitwig.com/downloads/${P}.deb"
LICENSE="Bitwig"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror strip"

DEPEND=""
RDEPEND="${DEPEND}
		app-arch/bzip2
		dev-libs/expat
		gnome-extra/zenity
		media-libs/alsa-lib
		media-libs/fontconfig
		media-libs/freetype
		media-libs/libpng:0/16
		media-libs/mesa
		media-sound/jack-audio-connection-kit
		media-video/libav
		sys-devel/gcc
		sys-libs/glibc
		sys-libs/zlib
		x11-libs/cairo
		x11-libs/libX11
		x11-libs/libXau
		x11-libs/libXcursor
		x11-libs/libXdmcp
		x11-libs/libXext
		x11-libs/libXfixes
		x11-libs/libXrender
		x11-libs/libdrm
		x11-libs/libxcb
		x11-libs/libxkbfile
		x11-libs/pixman
		x11-libs/xcb-util-wm
		virtual/opengl
		virtual/udev"

S=${WORKDIR}

src_install() {
	BITWIG_HOME="/opt/bitwig-studio"
	insinto ${BITWIG_HOME}
	doins -r opt/bitwig-studio/*
	fperms +x ${BITWIG_HOME}/bin32/BitwigPluginHost32
	fperms +x ${BITWIG_HOME}/bin/BitwigPluginHost64
	fperms +x ${BITWIG_HOME}/bin/BitwigStudioEngine
	fperms +x ${BITWIG_HOME}/bin/bitwig-vamphost
	fperms +x ${BITWIG_HOME}/bitwig-studio

	dosym ${BITWIG_HOME}/bitwig-studio /usr/bin/bitwig-studio
}

