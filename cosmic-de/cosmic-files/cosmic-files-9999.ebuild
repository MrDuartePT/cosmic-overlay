# Copyright 2024 Fabio Scaccabarozzi
# Distributed under the terms of the GNU General Public License v3

# Auto-Generated by cargo-ebuild 0.5.4

EAPI=8

inherit cosmic-de

DESCRIPTION="file manager from COSMIC DE"
HOMEPAGE="https://github.com/pop-os/$PN"

if [ "${PV}" == "9999" ]; then
	EGIT_REPO_URI="${HOMEPAGE}"
else
	SRC_URI="https://github.com/${PN}/${PN}/archive/refs/tags/v${MY_PV}.tar.gz -> ${P}.tar.gz
			$(cargo_crate_uris)"
fi

# License set may be more restrictive as OR is not respected
# use cargo-license for a more accurate license picture
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

# As per https://raw.githubusercontent.com/pop-os/cosmic-files/master/debian/control
DEPEND="${DEPEND}"
BDEPEND="${BDEPEND}"
RDEPEND="
${RDEPEND}
x11-misc/xdg-utils
"

src_install() {
	dobin "target/$profile_name/$PN"
	
	insinto /usr/share/applications
	doins res/com.system76.CosmicFiles.desktop
}