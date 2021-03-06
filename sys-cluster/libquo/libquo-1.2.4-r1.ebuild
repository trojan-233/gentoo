# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

FORTRAN_NEEDED=fortran
FORTRAN_STANDARD=90

inherit autotools-utils fortran-2

if [ "${PV}" = "9999" ]; then
	EGIT_REPO_URI="https://github.com/lanl/${PN}.git"
	inherit git-r3
	KEYWORDS=""
	AUTOTOOLS_AUTORECONF=1
else
	SRC_URI="https://lanl.github.io/${PN}/dists/${P}.tar.gz"
	KEYWORDS="~amd64"
fi

DESCRIPTION="run-time tuning of process binding policies made easy"
HOMEPAGE="https://lanl.github.io/libquo/"

LICENSE="BSD"
SLOT="0"
IUSE="fortran static-libs"

DEPEND="
	virtual/mpi[fortran?]
	sys-process/numactl
	sys-apps/hwloc[numa,xml]
	"
RDEPEND="${DEPEND}"

src_configure() {
	autotools-utils_src_configure CC=mpicc FC=$(usex fortran mpif90 false)
}
