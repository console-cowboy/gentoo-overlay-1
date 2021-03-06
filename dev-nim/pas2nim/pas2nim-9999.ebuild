# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit git-r3

DESCRIPTION="a tool to translate Pascal code to Nim"
HOMEPAGE="https://github.com/nim-lang/pas2nim"
EGIT_REPO_URI="https://github.com/nim-lang/pas2nim"
EGIT_CLONE_TYPE="shallow"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
	>=dev-lang/nim-0.9.4
"
RDEPEND=""

src_compile() {
	nim c -d:release ${PN}.nim || die "compile failed"
}

src_install() {
	dodir /usr/bin
	exeinto /usr/bin
	doexe ${PN}
}
