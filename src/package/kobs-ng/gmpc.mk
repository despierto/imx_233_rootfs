#############################################################
#
# kobs
#
#############################################################
KOBS_VERSION = 09.12.00
KOBS_SOURCE = kobs-ng-$(KOBS_VERSION).tar.gz
KOBS_SITE = http://download/
KOBS_LIBTOOL_PATCH = NO
KOBS_CONF_OPT = --prefix=/usr

$(eval $(call AUTOTARGETS,package,kobs))
