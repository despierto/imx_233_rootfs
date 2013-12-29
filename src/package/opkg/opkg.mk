#############################################################
#
# opkg
#
#############################################################
OPKG_VERSION = 0.1.8
OPKG_SOURCE = opkg-$(OPKG_VERSION).tar.gz
OPKG_SITE = http://opkg.googlecode.com/files/
OPKG_LIBTOOL_PATCH = NO
OPKG_CONF_OPT = --prefix=/usr --disable-gpg --disable-curl cross_compiling=yes
OPKG_INSTALL_TARGET_OPT = DESTDIR=$(TARGET_DIR) install
#OPKG_DEPENDENCIES = 

$(eval $(call AUTOTARGETS,package,opkg))
