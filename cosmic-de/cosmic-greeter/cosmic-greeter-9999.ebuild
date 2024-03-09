# Copyright 2024 Fabio Scaccabarozzi
# Distributed under the terms of the GNU General Public License v3

# Auto-Generated by cargo-ebuild 0.5.4

EAPI=8

inherit cosmic-de

DESCRIPTION="libcosmic greeter for greetd from COSMIC DE"
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

# As per https://raw.githubusercontent.com/pop-os/cosmic-greeter/master/debian/control
DEPEND="
${DEPEND}
sys-devel/clang
sys-libs/pam
"
BDEPEND="
${BDEPEND}
"
RDEPEND="
${RDEPEND}
acct-user/cosmic-greeter
cosmic-de/cosmic-comp
gui-libs/greetd"

src_prepare() {
	cosmic-de_src_prepare
	sed -i 's,^daemon-src.*,daemon-src \:= "target" / profile_name / name + "-daemon",' justfile
}

src_configure() {
	cosmic-de_src_configure --all
}

src_install() {
	local binfile="target/$profile_name/$PN"
	dobin "$binfile"
	dobin "$binfile-daemon"
	
	insinto /usr/share/dbus-1/system.d
	doins dbus/com.system76.CosmicGreeter.conf

	insinto /etc/greetd
	doins cosmic-greeter.toml
	
	insinto /usr/lib/systemd/system
	doins debian/cosmic-greeter-daemon.service
	doins debian/cosmic-greeter.service
}