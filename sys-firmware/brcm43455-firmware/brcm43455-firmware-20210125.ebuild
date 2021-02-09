# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

DESCRIPTION="Configuration file required for integrated WiFi on RPi4"
HOMEPAGE="https://github.com/RPi-Distro/firmware-nonfree"
COMMIT="f713a6054746bc61ece1c8696dce91a7b7e22dd9"
SRC_URI="https://github.com/RPi-Distro/firmware-nonfree/archive/${COMMIT}.tar.gz -> firmware-nonfree-${PV}.tar.gz"

LICENSE="Broadcom"
SLOT="0"
KEYWORDS="~arm ~arm64"
RESTRICT="mirror"

# The project we are using for the sources has a different name than this package
S="${WORKDIR}/firmware-nonfree-${COMMIT}"

DEPEND=""
RDEPEND="${DEPEND}
	      !sys-kernel/linux-firmware[-savedconfig]"

pkg_pretend() {
	local -a BADFILES=( "brcm/brcmfmac43455-sdio.bin" )

	if [[ "${#BADFILES[@]}" -gt 0 ]]; then
		eerror "The following files need to be excluded from the savedconfig of"
		eerror "linux-firmware and linux-firmware should be re-emerged, as they"
		eerror "collide with files from ${PN}."
		eerror "List of files:"
		for file in "${BADFILES[@]}"; do
			eerror "- ${file}"
		done
	fi
}

src_install() {
	insinto "/lib/firmware/brcm"
	newins "${S}/brcm/brcmfmac43455-sdio.txt" "brcmfmac43455-sdio.txt"
	newins "${S}/brcm/brcmfmac43455-sdio.clm_blob" "brcmfmac43455-sdio.clm_blob"
	newins "${S}/brcm/brcmfmac43455-sdio.bin" "brcmfmac43455-sdio.bin"
}