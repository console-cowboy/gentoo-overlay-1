# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_7,3_4,3_5} )

inherit distutils-r1

DESCRIPTION="Python promises"
HOMEPAGE="https://github.com/celery/vine http://pypi.python.org/pypi/vine/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=""
DEPEND="
		dev-python/setuptools[${PYTHON_USEDEP}]
		test? (
			>=dev-python/case-1.3.1[${PYTHON_USEDEP}]
			dev-python/mock[${PYTHON_USEDEP}]
			>=dev-python/pytest-3.0[${PYTHON_USEDEP}]
			dev-python/unittest2[${PYTHON_USEDEP}]
		)
		"

python_test() {
	py.test -x -v || die
}
