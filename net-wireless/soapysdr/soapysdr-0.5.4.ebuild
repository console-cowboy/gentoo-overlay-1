# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 python3_{4,5} )
CMAKE_IN_SOURCE_BUILD="1"

inherit cmake-utils python-r1

DESCRIPTION="vendor and platform neutral SDR support library"
HOMEPAGE="http://github.com/pothosware/SoapySDR"
SRC_URI="https://github.com/pothosware/SoapySDR/tarball/soapy-sdr-${PV} -> ${P}.tar.gz"

LICENSE="Boost-1.0"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"

IUSE="python"
REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

RDEPEND="python? ( ${PYTHON_DEPS} )"
DEPEND="${RDEPEND}
	python? ( dev-lang/swig:0 )
"

src_unpack() {
	unpack ${A}
	mv *-SoapySDR-* "${S}"
}

src_prepare() {
	# this particular CMakeLists.txt tries to enable Python 3 behind our backs:
	sed -i -e '/BUILD_PYTHON3/d' python/CMakeLists.txt
	cmake-utils_src_prepare
	use python && python_copy_sources
}

src_configure() {
	configuration() {
		local mycmakeargs=(
			$(cmake-utils_use_enable python PYTHON)
		)

		if [ -n "${EPYTHON}" ] && python_is_python3; then
			mycmakeargs+=( -DBUILD_PYTHON3=ON )
		else
			mycmakeargs+=( -DBUILD_PYTHON3=OFF )
		fi

		CMAKE_USE_DIR="${BUILD_DIR}" cmake-utils_src_configure
	}
	use python && python_foreach_impl configuration || configuration
}

src_compile() {
	compilation() {
		CMAKE_USE_DIR="${BUILD_DIR}" cmake-utils_src_make
	}
	use python && python_foreach_impl compilation || compilation
}

src_install() {
	installation() {
		CMAKE_USE_DIR="${BUILD_DIR}" cmake-utils_src_install DESTDIR="${D}"
		use python && python_optimize
	}
	use python && python_foreach_impl installation || installation
}
