# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit linux-info systemd

DESCRIPTION="Argon One Service and Control Scripts for Raspberry Pi 4B"
HOMEPAGE="https://www.argon40.com/argon-one-raspberry-pi-4-case.html"
SRC_URI="https://github.com/lewishazell/raspberrypi-argonone/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86 ~amd64-linux ~x86-linux"
IUSE="systemd"
RESTRICT="mirror"

# The project we are using for the sources has a different name than this package
S="${WORKDIR}/raspberrypi-argonone-${PV}"

DEPEND=">=dev-lang/python-3.6
        >=dev-python/RPi-GPIO-0.7.0
        media-libs/raspberrypi-userland
        sys-apps/i2c-tools[python]
        systemd?  ( sys-apps/systemd )
        !systemd? ( sys-apps/openrc )"
RDEPEND="${DEPEND}"

pkg_pretend() {
        CONFIG_CHECK="
                ~I2C_CHARDEV
        "

        check_extra_config
}

src_install() {
        insinto "/etc"
        newins "${S}/argononed.conf" "argononed.conf"
        fperms 0644 "/etc/argononed.conf"

        if use systemd ; then
                systemd_dounit "${S}/argononed.service"

                insinto "/lib/systemd/system-shutdown"
                newins "${S}/argononed-poweroff.py" "argononed-poweroff.py"
                fperms 0755 "/lib/systemd/system-shutdown/argononed-poweroff.py"
        fi

        insinto "/usr/bin"
        newins "${S}/argononed.py" "argononed.py"
        newins "${S}/argonone-config" "argonone-config"
        fperms 0755 "/usr/bin/argononed.py" "/usr/bin/argonone-config"
}

pkg_postinst() {
        # TODO: Check if it is not already somewhere in /etc/modules-load.d/*
        if linux_config_exists && linux_chkconfig_module I2C_CHARDEV; then
                ewarn "You have compiled I2C_CHARDEV as a module."
                ewarn "You need to load it for the fan control to work."
                ewarn "The module is called i2c-dev."
        fi

        local CFILE="/boot/config.txt"
        if ! grep -q "^\s*dtparam=i2c_arm=on" "${CFILE}" &>/dev/null; then
                elog "To use the fan control, please enable the i2c interface by setting"
                elog "  dtparam=i2c_arm=on"
                elog "in your /boot/config.txt and reboot."
        fi

        systemd_reenable argononed.service
}