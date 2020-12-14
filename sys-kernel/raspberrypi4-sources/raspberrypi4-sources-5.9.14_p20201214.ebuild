# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="6"
ETYPE=sources
K_DEFCONFIG="bcm2711_defconfig"
K_SECURITY_UNSUPPORTED=1

inherit kernel-2 eapi7-ver
detect_version
detect_arch

PATCH_VERSION=$(ver_cut 4-)
COMMIT="104137d44c6365fafc36ec1ea59db06f58ef5dfc"

DESCRIPTION="Raspberry Pi4 kernel sources"
HOMEPAGE="https://github.com/raspberrypi/linux"
SRC_URI="https://github.com/raspberrypi/linux/archive/${COMMIT}.tar.gz -> raspberrypi-kernel_${PV}.tar.gz"

KEYWORDS="~arm ~arm64"

# Rename to match the naming pattern for kernel sources (e.g. linux-5.9.14-rpi-p20201214)
S="${WORKDIR}/linux-${OKV}-rpi-${PATCH_VERSION}"

src_unpack() {
	default
	mv ${WORKDIR}/linux-${COMMIT} ${S}
}