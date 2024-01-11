# Copyright (c) 2024 The Open-Transactions developers
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

EAPI=8

DESCRIPTION="A Resource Compiler in a Single CMake Script"
HOMEPAGE="https://github.com/vector-of-bool/cmrc"
COMMIT_HASH="952ffddba731fc110bd50409e8d2b8a06abbd237"
SRC_URI="https://github.com/vector-of-bool/cmrc/archive/${COMMIT_HASH}.tar.gz -> ${PN}-${COMMIT_HASH}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="alpha amd64 arm arm64 hppa ia64 loong m68k mips ppc ppc64 riscv s390 sparc x86"

RDEPEND=">=dev-util/cmake-3.6"

src_unpack() {
	unpack "${A}"
	S="${WORKDIR}/cmrc-${COMMIT_HASH}"
}

src_install() {
	insinto /usr/share/CMakeRC
	newins "${S}/CMakeRC.cmake" CMakeRCConfig.cmake
}
