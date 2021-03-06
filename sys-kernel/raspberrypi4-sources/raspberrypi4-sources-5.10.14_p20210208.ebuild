# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

ETYPE=sources
K_DEFCONFIG="bcm2711_defconfig"
K_SECURITY_UNSUPPORTED=1

inherit kernel-2 eapi7-ver
detect_version
detect_arch

COMMIT="89da0eeefe8e30b3a4e7219bdd5e9284bb3edbe1"

DESCRIPTION="Raspberry Pi4 kernel sources"
HOMEPAGE="https://github.com/raspberrypi/linux"
SRC_URI="https://github.com/raspberrypi/linux/archive/${COMMIT}.tar.gz -> linux-${PV}-raspberrypi.tar.gz"
S="${WORKDIR}/linux-${PV}-raspberrypi"

KEYWORDS="~arm ~arm64"

src_unpack() {
				default

        # We want to rename the unpacked directory to a nice normalised string
        # bug #762766
				mv "${WORKDIR}/linux-${COMMIT}" "${S}"  || die
}