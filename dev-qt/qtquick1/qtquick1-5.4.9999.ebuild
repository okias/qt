# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit qt5-build

DESCRIPTION="Legacy declarative UI module for the Qt5 framework"

if [[ ${QT5_BUILD_TYPE} == release ]]; then
	KEYWORDS="~amd64 ~arm ~arm64 ~hppa ~ppc64 ~x86"
fi

IUSE="designer +opengl webkit xml"

# see bug 542698 for pinned dev-qt/designer dependency
DEPEND="
	>=dev-qt/qtcore-${PV}:5[debug=]
	>=dev-qt/qtgui-${PV}:5[debug=]
	>=dev-qt/qtnetwork-${PV}:5[debug=]
	>=dev-qt/qtscript-${PV}:5[debug=]
	>=dev-qt/qtsql-${PV}:5[debug=]
	>=dev-qt/qtwidgets-${PV}:5[debug=]
	designer? (
		~dev-qt/designer-${PV}[debug=]
		>=dev-qt/qtdeclarative-${PV}:5[debug=]
	)
	opengl? ( >=dev-qt/qtopengl-${PV}:5[debug=] )
	webkit? ( >=dev-qt/qtwebkit-${PV}:5[debug=] )
	xml? ( >=dev-qt/qtxmlpatterns-${PV}:5[debug=] )
"
RDEPEND="${DEPEND}"

src_prepare() {
	qt_use_disable_mod designer designer \
		src/plugins/plugins.pro

	qt_use_disable_mod opengl opengl \
		src/imports/imports.pro \
		tools/qml/qml.pri

	qt_use_disable_mod webkit webkitwidgets \
		src/imports/imports.pro

	qt_use_disable_mod xml xmlpatterns \
		src/declarative/declarative.pro \
		src/declarative/util/util.pri

	qt5-build_src_prepare
}
