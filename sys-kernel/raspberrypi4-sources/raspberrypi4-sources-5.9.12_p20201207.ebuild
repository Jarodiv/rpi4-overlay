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
COMMIT="cff5fa15e5d11758db426eee3524a5dfded3c62b"

DESCRIPTION="Raspberry Pi4 kernel sources"
HOMEPAGE="https://github.com/raspberrypi/linux"
SRC_URI="https://github.com/raspberrypi/linux/archive/${COMMIT}.tar.gz -> raspberrypi-kernel_${PV}.tar.gz"

KEYWORDS="~arm ~arm64"

# Rename to match the naming pattern for kernel sources (e.g. linux-5.9.12-rpi-p20201207)
S="${WORKDIR}/linux-${OKV}-v8-${PATCH_VERSION}"

src_unpack() {
	default
	mv ${WORKDIR}/linux-${COMMIT} ${S}
}