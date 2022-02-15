# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

ETYPE=sources
K_DEFCONFIG="bcm2711_defconfig"
K_SECURITY_UNSUPPORTED=1

inherit kernel-2 linux-info
detect_version

COMMIT="3a271d37a2a4527fa4be4cd13d443c468ccf0b6b"

DESCRIPTION="Raspberry Pi4 kernel sources"
HOMEPAGE="https://github.com/raspberrypi/linux"
SRC_URI="https://github.com/raspberrypi/linux/archive/${COMMIT}.tar.gz -> linux-${KV_FULL}.tar.gz"

KEYWORDS="~arm ~arm64"

src_unpack() {
				default

        # We want to rename the unpacked directory to a nice normalised string
        # bug #762766
				mv "${WORKDIR}"/linux-${COMMIT} "${WORKDIR}"/linux-${KV_FULL} || die
}