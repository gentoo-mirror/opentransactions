# Copyright (c) 2024 The Open-Transactions developers
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

EAPI=8
CMAKE_MAKEFILE_GENERATOR="ninja"
inherit cmake

DESCRIPTION="CMake modules and dev support files for libopentxs and dependent projects"
HOMEPAGE="https://github.com/Open-Transactions/otcommon"
GIT_COMMIT_HASH="d72af53fb26e934604376b59267a0e3d31d3db51"
GIT_DESCRIBE="3.1.1-0-gd72af53"
SRC_URI="https://github.com/Open-Transactions/otcommon/archive/${GIT_COMMIT_HASH}.tar.gz"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="alpha amd64 arm arm64 hppa ia64 loong m68k mips ppc ppc64 riscv s390 sparc x86"

DEPEND=">=dev-build/cmake-3.26.0"
RDEPEND="${DEPEND}"
BDEPEND=">=app-alternatives/ninja-1"

src_unpack() {
	unpack "${A}"
	mv "${PN}-${GIT_COMMIT_HASH}" "${PN}-${PVR}"
}

src_prepare() {
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=( "-Dotcommon_GIT_VERSION=${GIT_DESCRIBE}" )
	cmake_src_configure
}

src_install() {
	cmake_src_install
}
