#!/usr/bin/env fish

set THEME_NAME "CyberGRUB-2077"
set THEME_URL "https://github.com/adnksharp/CyberGRUB-2077"
set THEME_DIR "/boot/grub/themes"
set GRUB_CFG "/etc/default/grub"
set LNG (string sub -l 2 $LANG)
set SYS_LANG "./lang/$LNG.fish"
set LOGO "samurai"

source ./scripts/outs.fish

printf "$OUT_TITLE"

# Set lang outs
if test -f "$SYS_LANG"
    source "$SYS_LANG"
else
    source ./lang/en.fish
end

# Check options
argparse 'h/help' 'l/list' 'L/logo=' -- $argv
or return

if set -ql _flag_h
	printf "$LNG_HELP"
	exit 0
end

if set -ql _flag_l
	set LOGOS (find ./img/logos -maxdepth 1 -name "*.png" | string replace --regex '\.png$' '' | string replace --regex '.*/' '')
	
	printf "$LNG_LOGO_TITLE"
	
	set i 0
	for logo in $LOGOS
		set i (math "$i + 1")
		set z (math "($i - 1) % 5")
		if test "$z" -eq 0
			printf "\e[1;31m║\e[1;36m"
        end
        printf "  %s" "$logo"
		set logo_len (string length "$logo")
    	for j in (seq $logo_len 12)
            printf " "
        end
		set y (math "($i % 5)")
		if test "$y" -eq 0
        	printf " \e[1;31m║\e[0m\n"
        else
            printf " "
        end
	end
	printf "\e[1;31m$(MARGIN ╚ ┘)\e[0m\n"
	exit 0
end

if set -ql _flag_L
	# LOGO=_flag_L
	if not test -f "./img/logos/$_flag_L.png"
        printf "$LNG_ERR_LOGO"
        exit 1
    else
        set LOGO "$_flag_L"
		set z (string length \"$LOGO\")
        printf "\033[1A\033[K║ [\e[1;36m%s\e[1;31m] %s║\n\e[1;31m%s\e[0m\n" "$LOGO" (SPACE (math "$OUT_LEN - $z - 2")) (MARGIN '╚' '┘')
    end
end

# Check root
printf "$LNG_ROOT_CHECK"
# sleep 2
if test (id -u) -ne 0
	printf "$LNG_ROOT_FAIL"
	exit 1
end
printf "$LNG_ROOT_OK"

# Create THEME_DIR if ti doesn't exist
printf "$LNG_DIR_CHECK"
# sleep 2
if not test -d "$THEME_DIR"
	mkdir -p "$THEME_DIR"
	printf "$LNG_DIR_FAIL"
else
	printf "$LNG_DIR_OK"
end

# Update repo with git
printf "$LNG_GIT_CHECK"
# sleep 2
if type -q git
	#git reset --hard
	#git pull --rebase
	if test $status -ne 0
		printf "$LNG_GIT_FAIL"
		exit 1
	end
	printf "$LNG_GIT_OK"
else
	printf "$LNG_GIT_FAIL"
	exit 1
end

# Copy theme
printf "$LNG_CP_CHECK"
# sleep 2
cp -r $THEME_NAME $THEME_DIR > /dev/null 2>&1
if test $status -ne 0
	printf "$LNG_CP_FAIL"
	exit 1
end
printf "$LNG_CP_OK"

# Copy logo.png to theme directory
printf "$LNG_LOGO_CHECK"
cp -f "./img/logos/$LOGO.png" "$THEME_DIR/$THEME_NAME/logo.png" > /dev/null 2>&1
if test $status -ne 0
	printf "$LNG_LOGO_FAIL"
	exit 1
end
printf "$LNG_LOGO_OK"

# Modify GRUB
set -l GRUB_THEME_PATH "GRUB_THEME=\"$THEME_DIR/$THEME_NAME/theme.txt\""
printf "$LNG_EDIT_CHECK"
# sleep 4
if grep -qE "^#?GRUB_THEME=" "$GRUB_CFG"
    sed -i -E "s|^#?GRUB_THEME=.*|$GRUB_THEME_PATH|" "$GRUB_CFG"
else
    echo "" >> "$GRUB_CFG"
    echo "$GRUB_THEME_PATH" >> "$GRUB_CFG"
end
printf "$LNG_EDIT_OK"

# Update GRUB
printf "$LNG_UP_CHECK"
if type -q grub-mkconfig
	sudo grub-mkconfig -o /boot/grub/grub.cfg  > /dev/null 2>&1
	if test $status -ne 0
		printf "$LNG_UP_FAIL"
		exit 1
	end
	printf "$LNG_UP_OK"
else
	printf "$LNG_NO_GRUB"
	exit 1
end

printf "$LNG_FINISH"
