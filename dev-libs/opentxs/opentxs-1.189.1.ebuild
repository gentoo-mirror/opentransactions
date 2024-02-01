# Copyright (c) 2024 The Open-Transactions developers
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

EAPI=8
CMAKE_MAKEFILE_GENERATOR="ninja"
inherit git-r3 cmake
unset PROPERTIES

DESCRIPTION="libopentxs financial cryptography library"
HOMEPAGE="https://github.com/Open-Transactions/opentxs"
EGIT_REPO_URI="https://github.com/Open-Transactions/opentxs"
EGIT_COMMIT="ae61a3c950727414b2d92427e2c772502e1d2c9f"
EGIT_BRANCH="master"
EGIT_MIN_CLONE_TYPE="single+tags"
EGIT_SUBMODULES=( '*' )

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~loong ~m68k ~mips ~ppc ~ppc64 ~riscv ~s390 ~sparc ~x86"
IUSE="+blockchain chaiscript debug +ed25519 jumbo-build +lmdb lucre +pch-build +pkt +pstl +pstl-needs-tbb qml qt5 qt6 +rpc +rsa +secp256k1 sqlite test tbb +threads valgrind"
REQUIRED_USE="
	jumbo-build? ( pch-build )
	blockchain? (
		lmdb
		secp256k1
	)
	threads? (
		^^ ( pstl tbb )
	)
	pstl? ( threads )
	tbb? ( threads )
	^^ ( qt5 qt6 )
	qml? (
		^^ ( qt5 qt6 )
	)
"

RESTRICT="!test? ( test )"
DEPEND="
	dev-cpp/cs_libguarded
	dev-cpp/frozen
	dev-cpp/simpleini
	dev-libs/boost
	dev-libs/libsodium
	dev-libs/openssl
	dev-libs/protobuf
	>=dev-build/cmake-3.26.0
	net-libs/zeromq[sodium]
	sys-libs/zlib
	lmdb? ( dev-db/lmdb )
	pstl-needs-tbb? ( dev-cpp/tbb )
	qt5? (
		dev-qt/qtcore:5
		dev-qt/qtgui:5
	)
	qt6? ( dev-qt/qtbase:6[gui] )
	qml? (
		|| (
			qt5? ( dev-qt/qtdeclarative:5 )
			qt6? ( dev-qt/qtdeclarative:6 )
		)
	)
	secp256k1? ( dev-libs/libsecp256k1[ecdh,recovery] )
	sqlite? ( dev-db/sqlite )
	tbb? ( dev-cpp/tbb )
"
RDEPEND="${DEPEND}"
BDEPEND="
	app-alternatives/ninja
	dev-libs/protobuf
	dev-vcs/git
"

src_unpack() {
	git-r3_src_unpack
}

src_prepare() {
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		"-DBUILD_SHARED_LIBS=ON"
		"-DOT_STORAGE_FS=ON"
		"-DOT_BOOST_JSON_HEADER_ONLY=OFF"
		"-DOT_BOOST_STACKTRACE_ADDR2LINE=OFF"
		"-DOT_ENABLE_NONFREE=OFF"
		"-DOT_ENABLE_MATTERFI=OFF"
		"-DOPENTXS_DEBUG_BUILD=$(usex debug)"
		"-DOPENTXS_BUILD_TESTS=$(usex test)"
		"-DOPENTXS_PEDANTIC_BUILD=$(usex debug)"
		"-DCMAKE_UNITY_BUILD=$(usex jumbo-build)"
		"-DOT_PCH=$(usex pch-build)"
		"-DOT_VALGRIND=$(usex valgrind)"
		"-DOT_STORAGE_SQLITE=$(usex sqlite)"
		"-DOT_STORAGE_LMDB=$(usex lmdb)"
		"-DOT_CRYPTO_SUPPORTED_KEY_ED25519=$(usex ed25519)"
		"-DOT_CRYPTO_SUPPORTED_KEY_RSA=$(usex rsa)"
		"-DOT_CRYPTO_SUPPORTED_KEY_SECP256K1=$(usex secp256k1)"
		"-DOT_CRYPTO_USING_PACKETCRYPT=$(usex pkt)"
		"-DOT_WITH_BLOCKCHAIN=$(usex blockchain)"
		"-DOT_CASH_USING_LUCRE=$(usex lucre)"
		"-DOT_SCRIPT_USING_CHAI=$(usex chaiscript)"
		"-DOT_WITH_QT=$(usex qt5 || usex qt6)"
		"-DOT_WITH_QML=$(usex qml)"
		"-DOT_USE_PSTL=$(usex pstl)"
		"-DOT_PSTL_NEEDS_TBB=$(usex pstl-needs-tbb)"
		"-DOT_WITH_TBB=$(usex tbb)"
		"-DOT_ENABLE_RPC=$(usex rpc)"
		"-DQT_VERSION_MAJOR=$(usex qt6 6 5)"
	)
	cmake_src_configure
}

src_compile() {
	cmake_src_compile
}

src_test() {
	cmake_src_test
}

src_install() {
	cmake_src_install
}
