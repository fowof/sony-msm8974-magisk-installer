
NAME := magisk-installer

SRCS := META-INF/com/google/android/update-binary
SRCS += META-INF/com/google/android/updater-script

.DEFAULT_GOAL := signed

.PHONY: zip signed push

$(NAME)-signed.zip: $(NAME).zip tools/signzip.bash
	@rm -rf rm $@
	@bash signzip.bash $< $@ >/dev/null 2>&1

$(NAME).zip: $(SRCS)
	@rm -rf rm $@
	@zip $@ $^ >/dev/null 2>&1

zip: $(NAME).zip

signed: $(NAME)-signed.zip

push: $(NAME)-signed.zip
	@adb push $< /sdcard/Download/$<

tools/signzip.bash: tools

tools:
	@git clone https://gist.github.com/252d4735c2dedd49dea44f670dd50a02.git $@
