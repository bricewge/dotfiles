# TODO add diff task, to use when stow report a conflict
# ./dots.sh bspwm 2>&1 | \
# awk -F': ' "/not owned by stow/ {print \"$HOME/\"\$2\" ./bspwm/\"\$2}" | \
# xargs -n2 diff -u --color
# TODO display output only if error, like mongooseOS tool mos
# TODO {pre,post}-stow should be runned based on Makefile rules

.DEFAULT_GOAL := help

DESTDIR  ?= $$HOME
ENVIRONMENT := . ./shell/.shell/environment &&
PKGS ?= $(sort $(patsubst %/, %, $(dir $(wildcard [^_@]*/.))))

REAL_DIRS := $(addprefix $(DESTDIR)/,\
	.config\
	.config/bat\
	.config/dunst .config/tmux .config/rofi\
	.local/src\
	.tmux\
	.git-templates\
	.gnupg .ssh\
	.terminfo)

comma:= ,
empty:=
space:= $(empty) $(empty)

heading:= printf "==> \033[1m%s\033[0m\n"
subheading:= printf "\033[1m%s\033[0m\n"

.PHONY: $(PKGS)
PACKAGE: ## Install PACKAGE
$(PKGS): dirs
	@$(heading) "Install $@"
	$(ENVIRONMENT) ./$@/pre-stow || test $$? -eq 127 && true
	stow -t $(DESTDIR) $@
	$(ENVIRONMENT) ./$@/post-stow || test $$? -eq 127 && true

alacritty bspwm tmux zsh: theme
# firefox rofi: theme

$(REAL_DIRS):
	@mkdir -p $@

.PHONY: all
all: ## Install all packages
all: dirs $(PKGS)

# XXX: Hiding meaningless warning message from stow.
# https://github.com/aspiers/stow/issues/65
.PHONY: uninstall
uninstall: ## Uninstall PACKAGES (all or use PACKAGES=foo,bar)
	@$(heading) "Uninstall files"
	stow --target $(DESTDIR) --delete $(subst $(comma),$(space),$(PACKAGES)) \
	2>&1 | sed '/Stow.pm line 966/d;'

.PHONY: update
update: ## Update and install
update: install
	find  ~/.local/src/ -path */.git -exec $(subheading) {} \; -execdir git -C ./ pull \;

.PHONY: pull
pull: ## Pull latest changes
	@$(heading) "Fetch changes"
	git pull

.PHONY: home
home: ## Create home directory hierarchy
	@$(heading) "Create home hierarchy"
	@mkdir -p $(addprefix "$$HOME"/,\
	project org 42\
	src vm\
	misc/iso misc/vpn misc/paperasse\
	misc/model misc/desktop misc/document\
	sharing\
	game music stream video\
	picture/screenshot picture/wallpaper\
	download tmp mnt)

.PHONY: bricewge
bricewge: ## Apply user specific customizations
bricewge: home
	@$(heading) "Apply bricewge's customization"
	git remote set-url origin "git@github.com:bricewge/dotfiles.git"

.PHONY: dirs
dirs: ## Make directories to prevent symlinking them
dirs: $(REAL_DIRS)
	@$(heading) "Make directories"

.PHONY: help
help: ## Describe tasks
	$(info Tasks:)
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / \
	{printf "\033[1m%-15s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)
