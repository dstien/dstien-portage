# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# TODO
# - Verify all runtime dependencies, min versions, and required flags
# - QA_PREBUILT list
# - Avoid bundled JRE?

EAPI=5
inherit eutils fdo-mime gnome2-utils unpacker

MY_PV="${PV/_/-}"

DESCRIPTION="Music production and performance system"
HOMEPAGE="http://bitwig.com/"
SRC_URI="http://packs.bitwig.com/downloads/${PN}-${MY_PV^^}.deb"
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

src_prepare() {
	# Fix desktop file validation errors
	sed -i \
		-e 's/bitwig-studio.png$/bitwig-studio/g' \
		-e 's/Multimedia$/Audio\;AudioVideo\;/g' \
		usr/share/applications/bitwig-studio.desktop

}

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

	insinto /usr/share/mime/packages
	doins usr/share/mime/packages/bitwig-studio.xml

	doicon -c mimetypes -s scalable usr/share/icons/gnome/scalable/mimetypes/application-bitwig-*.svg
	doicon -c apps -s scalable usr/share/icons/gnome/scalable/apps/bitwig-studio.svg
	doicon -c apps -s 48 usr/share/icons/gnome/48x48/apps/bitwig-studio.png

	domenu usr/share/applications/bitwig-studio.desktop
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
	fdo-mime_mime_database_update
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	gnome2_icon_cache_update
	fdo-mime_mime_database_update
	fdo-mime_desktop_database_update
}
