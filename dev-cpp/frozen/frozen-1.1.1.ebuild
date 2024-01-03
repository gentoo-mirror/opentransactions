# Copyright (c) 2024 The Open-Transactions developers
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

EAPI=8
CMAKE_MAKEFILE_GENERATOR="ninja"
inherit cmake

DESCRIPTION="A header-only, constexpr alternative to gperf for C++14 users"
HOMEPAGE="https://github.com/serge-sans-paille/frozen"
# SRC_URI="https://github.com/serge-sans-paille/frozen/archive/refs/tags/${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
COMMIT_HASH="7e79c375b062311a1209c24c69460673202e1ef9"
SRC_URI="https://github.com/serge-sans-paille/frozen/archive/${COMMIT_HASH}.tar.gz -> ${PN}-${COMMIT_HASH}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="alpha amd64 arm arm64 hppa ia64 loong m68k mips ppc ppc64 riscv s390 sparc x86"

DEPEND=">=dev-util/cmake-3.16.0"
RDEPEND="${DEPEND}"
BDEPEND=">=app-alternatives/ninja-1"

src_unpack() {
	unpack "${A}"
#	S="${WORKDIR}/${PN}-${PV}"
	S="${WORKDIR}/${PN}-${COMMIT_HASH}"
}

src_prepare() {
	cmake_src_prepare
}

src_configure() {
	cmake_src_configure
}

src_install() {
	cmake_src_install
}
