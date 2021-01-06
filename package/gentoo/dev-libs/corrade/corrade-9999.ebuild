EAPI=7

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="git://github.com/mosra/corrade.git"
else
	SRC_URI="https://github.com/mosra/corrade/archive/v{PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

inherit cmake-utils

DESCRIPTION="C++11 Multiplatform plugin management and utility library"
HOMEPAGE="https://magnum.graphics/corrade/"

LICENSE="MIT"
SLOT="0"
IUSE="+interconnect +pluginmanager testsuite utility +main rc static test"
REQUIRED_USE="testsuite? ( !main ) utility? ( !rc )"
# || ( interconnect pluginmanager testsuite )? ( !utility )"


RDEPEND="
	dev-util/cmake
"
DEPEND="${RDEPEND}"

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_PREFIX="${EPREFIX}/usr"
		-DCMAKE_BUILD_TYPE=Release
		-DBUILD_TESTS=$(usex test)
		-DWITH_INTERCONNECT=$(usex interconnect)
		-DWITH_PLUGINMANAGER=$(usex pluginmanager)
		-DWITH_TESTSUITE=$(usex testsuite)
		-DWITH_UTILITY=$(usex utility)
		-DWITH_MAIN=$(usex main)
		-DBUILD_STATIC=$(usex static)
	)
	cmake-utils_src_configure
}

# kate: replace-tabs off;
