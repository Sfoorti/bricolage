# settings
SHELL = /bin/sh

# Programatic dependancies
PERL = /usr/bin/perl
APACHE = /usr/sbin/apache-perl
POSTGRESHOME = /usr/lib/postgresql
POD2HTML = /usr/bin/pod2html
POD2TEXT = /usr/bin/pod2text
POD2MAN = /usr/bin/pod2man
GZIP = /bin/gzip
MKDIR = /bin/mkdir
FIND = /usr/bin/find

# directories
BIN = bin
COMP = comp
CONF = conf
DATA = data
LIB = lib
DOC = doc

# Installation related variables
prefix  = /usr/local
exec_prefix  = ${prefix}
bindir  = ${exec_prefix}/bin
datadir  = ${prefix}/share
sysconfdir  = ${prefix}/etc
libdir  = ${exec_prefix}/lib
libexecdir  = ${exec_prefix}/libexec
includedir  = ${prefix}/include
oldincludedir  = /usr/include
mandir  = ${prefix}/man
infodir  = ${prefix}/info
sbindir  = ${exec_prefix}/sbin
localstatedir  = ${prefix}/var
sharedstatedir  = ${prefix}/com

# Bricolage configuration info
APACHE_USER = 
APACHE_GROUP = 

# A list of any missing modules
MISSING_MODULES = 
MODULE_COMMAND = $(foreach mod,${MISSING_MODULES},${PERL} -MCPAN -e "install ${mod}" ;)



all: README INSTALL TODO License doc

install: dep 

dep: cpan



cpan:
	${INSTALL_MISSING}
	echo Installed ${MISSING_MODULES} >>install.log

INSTALL:
	${POD2TEXT} lib/Bric/Admin.pod >$@

TODO:
	${POD2TEXT} lib/Bric/ToDo.pod >$@

README:
	${POD2TEXT} lib/Bric/Changes.pod >$@

License:
	${POD2TEXT} lib/Bric/License.pod >$@

doc:
	cd ${DOC} && ${MAKE} -e




clean: docclean
	${RM} -f README INSTALL TODO License

docclean:
	cd $(DOC) && ${MAKE} -e clean


.PHONY : clean dep clean cpan doc
