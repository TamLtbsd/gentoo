# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
QT5_MODULE="qttools"
inherit qt5-build

DESCRIPTION="Qt screen magnifier"

if [[ ${QT5_BUILD_TYPE} == release ]]; then
	KEYWORDS="amd64 arm ~hppa ~ppc64 x86"
fi

IUSE=""

DEPEND="
	~dev-qt/qtcore-${PV}
	~dev-qt/qtgui-${PV}
	~dev-qt/qtnetwork-${PV}
	~dev-qt/qtwidgets-${PV}
"
RDEPEND="${DEPEND}"

QT5_TARGET_SUBDIRS=(
	src/pixeltool
)
