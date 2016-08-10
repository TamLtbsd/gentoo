# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=( python{2_7,3_4,3_5} )

inherit distutils-r1 linux-info versionator

MY_PV=$(replace_version_separator 2 '.fb' ${PV})

DESCRIPTION="Command shell for managing Linux LIO kernel target"
HOMEPAGE="https://github.com/open-iscsi/targetcli-fb"
SRC_URI="https://github.com/open-iscsi/${PN}/archive/v${MY_PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

COMMON_DEPEND="${PYTHON_DEPS}
	!sys-block/targetcli"
DEPEND="${COMMON_DEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="${COMMON_DEPEND}
	dev-python/configshell-fb[${PYTHON_USEDEP}]
	dev-python/dbus-python[${PYTHON_USEDEP}]
	dev-python/rtslib-fb[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]"

S=${WORKDIR}/${PN}-${MY_PV}

pkg_pretend() {
	if use kernel_linux; then
		linux-info_get_any_version
		if ! linux_config_exists; then
			eerror "Unable to check your kernel for SCSI target support"
		else
			CONFIG_CHECK="~TARGET_CORE"
			check_extra_config
		fi
	fi
}

src_install() {
	distutils-r1_src_install
	keepdir /etc/target /etc/target/backup
	doman targetcli.8
}
