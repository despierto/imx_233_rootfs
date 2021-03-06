#############################################################
#
# Make a initramfs_list file to be used by gen_init_cpio
# gen_init_cpio is part of the 2.6 linux kernels to build an
# initial ramdisk filesystem based on cpio
#
#############################################################

ifeq ($(BR2_TARGET_ROOTFS_INITRAMFS),y)
INITRAMFS_TARGET:=$(IMAGE).initramfs_list
else
INITRAMFS_TARGET:= #nothing
endif

TARGETS+=$(INITRAMFS_TARGET)

$(INITRAMFS_TARGET) initramfs: host-fakeroot makedevs
	rm -f $(TARGET_DIR)/init
	ln -s sbin/init $(TARGET_DIR)/init
	# Use fakeroot to pretend all target binaries are owned by root
	rm -f $(BUILD_DIR)/_fakeroot.$(notdir $(TAR_TARGET))
	touch $(BUILD_DIR)/.fakeroot.00000
	cat $(BUILD_DIR)/.fakeroot* > $(BUILD_DIR)/_fakeroot.$(notdir $(TAR_TARGET))
	echo "chown -R 0:0 $(TARGET_DIR)" >> $(BUILD_DIR)/_fakeroot.$(notdir $(TAR_TARGET))
	# Use fakeroot to pretend to create all needed device nodes
	echo "$(HOST_DIR)/usr/bin/makedevs -d $(TARGET_DEVICE_TABLE) $(TARGET_DIR)" \
		>> $(BUILD_DIR)/_fakeroot.$(notdir $(TAR_TARGET))
	# Use fakeroot so gen_initramfs_list.sh believes the previous fakery
	echo "$(SHELL) target/initramfs/gen_initramfs_list.sh -u 0 -g 0 $(TARGET_DIR) > $(INITRAMFS_TARGET)" \
		>> $(BUILD_DIR)/_fakeroot.$(notdir $(TAR_TARGET))
	chmod a+x $(BUILD_DIR)/_fakeroot.$(notdir $(TAR_TARGET))
	$(HOST_DIR)/usr/bin/fakeroot -- $(BUILD_DIR)/_fakeroot.$(notdir $(TAR_TARGET))
	-rm -f $(BUILD_DIR)/_fakeroot.$(notdir $(TAR_TARGET))

initramfs-source:

initramfs-clean:
ifeq ($(BR2_TARGET_ROOTFS_INITRAMFS),y)
	-rm -f $(INITRAMFS_TARGET)
endif
initramfs-dirclean:


