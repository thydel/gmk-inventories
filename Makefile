top:; @date

Makefile:;

make = make -C ext/$@ --no-print-directory $1

normal := data-ips ips nodes-groups
special := inventories
repos := $(normal) $(special)
$(normal):; $(call make, install)
$(special):; $(call make, main); $(call make, install)
main: $(repos)
.PHONY: main $(repos)

git-store-dates = (cd ext/$(@D) && git-store-dates $(@F))
%/hooks:; $(git-store-dates)
%/restore:; $(git-store-dates)
hooks: $(repos:%=%/hooks)
restore: $(repos:%=%/restore)
dates: hooks restore
.PHONY: dates hooks restore
