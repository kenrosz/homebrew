### 1.8.5 - 19 November 2023

 * fix: corrected percentage formatting so it doesn't jump from 2 to 3 characters wide at 100% ([#80](https://codeberg.org/a-j-wood/pv/issues/80))
 * fix: replaced "`--remote`" mechanism, using a temporary file instead of SysV IPC, so it can work reliably even when there are multiple PV instances
 * fix: corrected compilation failure when without IPC support
 * security: addressed all issues highlighted by the software auditing tools "`splint`" and "`flawfinder`" (see "`make analyse`") ([#77](https://codeberg.org/a-j-wood/pv/issues/77))
 * cleanup: compilation warnings fixed on non-IPC and MacOS systems

### 1.8.0 - 24 September 2023

#### Features

 * feature: new "`--discard`" option to discard input as if writing to */dev/null* ([#42](https://codeberg.org/a-j-wood/pv/issues/42))
 * feature: new "`--error-skip-block`" option to make "`--skip-errors`" skip whole blocks ([#37](https://codeberg.org/a-j-wood/pv/issues/37))
 * feature: use `posix_fadvise()` like `cat`(1) does, to improve efficiency ([#39](https://codeberg.org/a-j-wood/pv/issues/39))
 * feature: new "`--enable-static`" option to "`configure`" for static builds ([#75](https://codeberg.org/a-j-wood/pv/pull/75))

#### Security

 * security: with "`--pidfile`", write to a temporary file and rename it into place, to improve security
 * security: keep self-contained copies of name and format string in PV internal state for memory safety
 * security: ignore _TMP_ / _TMPDIR_ environment variables when using a terminal lock file

#### Fixes

 * fix: only report errors about missing files when starting to transfer from them, not while calculating size, and behave more like `cat`(1) by skipping them and moving on
 * fix: auto-calculate total line count with "`--line-mode`" when all inputs are regular files
 * fix: use `clock_gettime()` in ETA calculation to cope with machine suspend/resume ([#13](https://codeberg.org/a-j-wood/pv/issues/13))
 * fix: if "`--width`" or "`--height`" were provided, do not change them when the window size changes ([#36](https://codeberg.org/a-j-wood/pv/issues/36))
 * fix: when a file descriptor position in "`--watchfd`" moves backwards, show the rate using the correct prefix ([#41](https://codeberg.org/a-j-wood/pv/issues/41))
 * fix: rewrite terminal state save/restore so state is not intermittently garbled on exit when using "`--cursor`" ([#20](https://codeberg.org/a-j-wood/pv/issues/20)), ([#24](https://codeberg.org/a-j-wood/pv/issues/24))

#### Cleanups

 * cleanup: addressed many potential issues highlighted by the software auditing tools "`splint`" and "`flawfinder`" (see new target "`make analyse`")
 * cleanup: switched the build system to GNU Automake
 * cleanup: replaced the test harness with the one native to GNU Automake
 * cleanup: added a test for terminal width detection to "`make check`"
 * cleanup: added a test to "`make check`" to ensure that "`make install`" installs everything expected
 * cleanup: replaced *AC_HEADER_TIOCGWINSZ* with *AC_CHECK_HEADERS(sys/ioctl.h)* for better MacOS compatibility ([#74](https://codeberg.org/a-j-wood/pv/issues/74))
 * cleanup: with "`--sync`", call `fsync()` instead of `fdatasync()` on incapable systems ([#73](https://codeberg.org/a-j-wood/pv/issues/73))
 * cleanup: the manual is now a static file instead of needing to be built with "`configure`"

#### Dropped items

 * dropped: dropped support for "`--enable-static-nls`"
 * dropped: removed the Linux Software Map file, as the LSM project appears to be long dead
 * dropped: will no longer publish to SourceForge as it has a chequered history and is unnecessary
 * dropped: removed project from GitHub and moved to Codeberg - see "[Give Up GitHub](https://giveupgithub.org/)"

#### Other items

 * licensing change from Artistic 2.0 to GPLv3+

### 1.7.24 - 30 July 2023

 * fix: correct terminal size detection, broken in 1.7.17 by the configuration script rewrite ([#72](https://codeberg.org/a-j-wood/pv/issues/72))
 * security: removed *DEBUG* environment variable in debug mode, added "`--debug`" instead
 * cleanup: added "`make analyse`" to run "`splint`" and "`flawfinder`" on all source files
 * cleanup: corrected detection of boolean capability
 * cleanup: word wrapping of "`--help`" output is now multi-byte locale aware
 * cleanup: adjusted "`indent`" rules to line length of 120 and reformatted code

### 1.7.18 - 28 July 2023 

 * fix: language file installation had been broken by the configuration script rewrite

### 1.7.17 - 27 July 2023

 * feature: new "`--sync`" option to flush cache to disk after every write (related to [#6](https://codeberg.org/a-j-wood/pv/issues/6), to improve accuracy when writing to slow disks)
 * feature: new "`--direct-io`" option to bypass cache - implements [#29 "Option to enable *O_DIRECT*"](https://codeberg.org/a-j-wood/pv/issues/29) - requested by Romain Kang, Jacek Wielemborek
 * fix: correct byte prefix size to 2 spaces in rate display, so progress display size remains constant at low transfer rates
 * cleanup: rewrote `configure.in` as per suggestions in newer "`autoconf`" manuals
 * cleanup: replaced `header.in` with one generated by "`autoheader`", moving custom logic to a separate header file "`config-aux.h`"
 * cleanup: added copyright notice to all source files as per GNU standards
 * cleanup: changed "`--version`" output to conform to GNU standards
 * cleanup: replaced backticks with `$()` in all shell scripts that did not come from elsewhere, as backticks are deprecated and harder to read
 * cleanup: improved the output formatting of "`make test`"
 * cleanup: extended the "`make test`" mechanism to allow certain tests to be skipped on platforms that cannot support them
 * cleanup: skip the "pipe" test (for *SIGPIPE*) if GNU "`head`" is not available, so that "`make test`" on stock OpenBSD 7.3 works
 * cleanup: added a lot more tests to "`make test`"
 * cleanup: replace all calls to `sprintf()` and `snprintf()` with a new wrapper function `pv_snprintf()` to improve security and compatibility
 * cleanup: replace all calls to `strcat()` with a wrapper `pv_strlcat()` to improve security and compatibility
 * cleanup: replace all `write()` calls to the terminal with a wrapper `pv_write_retry()` for consistency
 * cleanup: tidy up and fix compilation warning in "`--watchfd`" code
 * cleanup: rewrote all local shell scripts to pass analysis by [ShellCheck](https://www.shellcheck.net)

### 1.7.0 - 17 July 2023

 * dropped: support for Red Hat Enterprise Linux and its derivatives has been dropped; removed the RPM spec file, and will no longer build binaries
 * feature: the "`--size`" option now accepts "`@filename`" to use the size of another file (pull request [#57](https://codeberg.org/a-j-wood/pv/pull/57) supplied by [Dave Beckett](https://github.com/dajobe))
 * feature: the "`--watchfd`" option is now available on OS X (pull request [#60](https://codeberg.org/a-j-wood/pv/pull/60) supplied by [christoph-zededa](https://github.com/christoph-zededa))
 * feature: new "`--bits`" option to show bit count instead of byte count (adapted from pull request [#63](https://codeberg.org/a-j-wood/pv/pull/63) supplied by [Nick Black](https://nick-black.com))
 * feature: new "`--average-rate-window`" option, to set the window over which the average rate is calculated, also used for ETA (modified from pull request [#65](https://codeberg.org/a-j-wood/pv/pull/65) supplied by [lemonsqueeze](https://github.com/lemonsqueeze))
 * feature: the "`--watchfd`" option will now show relative filenames, if they are under the current directory (pull request [#66](https://codeberg.org/a-j-wood/pv/pull/66) supplied by [ikasty](https://github.com/ikasty))
 * fix: correction to `pv_in_foreground()` to behave as its comment block says it should, when not on a terminal - corrects [#19 "No output in Arch Linux initcpio after 1.6.6"](https://codeberg.org/a-j-wood/pv/issues/19), [#31 "No output written from inside zsh <() construct"](https://codeberg.org/a-j-wood/pv/issues/31), [#55 "pv Stopped Working in the Background"](https://codeberg.org/a-j-wood/pv/issues/55) (pull request [#64](https://codeberg.org/a-j-wood/pv/pull/64) supplied by [Michael Weiß](https://github.com/quitschbo))
 * fix: workaround for OS X 11 behaviour in configure script regarding stat64 at compile time (pull request [#57](https://codeberg.org/a-j-wood/pv/pull/57) supplied by [Dave Beckett](https://github.com/dajobe))
 * fix: workaround for macOS equivalence of stat to stat64 - patches from [Filippo Valsorda](https://github.com/FiloSottile) and [Demitri Muna](https://github.com/demitri), correcting [#33 "Fix compilation problems due to `stat64()` on Apple Silicon"](https://codeberg.org/a-j-wood/pv/issues/33)
 * fix: add burst rate limit to transfer, so rate limits are not broken by bursty traffic (pull request [#62](https://codeberg.org/a-j-wood/pv/pull/62) supplied by [Volodymyr Bychkovyak](https://github.com/vbychkoviak))
 * fix: corrected "`--force`" option so it will still output progress when not in the same process group as the owner of the terminal - corrects [#23 "No output with "`-f`" when run in background after 1.6.6"](https://codeberg.org/a-j-wood/pv/issues/23) and helps to correct [#31 "No output written from inside zsh <() construct"](https://codeberg.org/a-j-wood/pv/issues/31)
 * fix: corrected elapsed time display to show as D:HH:MM:SS after 1 day, like the ETA does - corrects [#16 "Show days in same format in ETA as in elapsed time"](https://codeberg.org/a-j-wood/pv/issues/16)
 * fix: corrected bug where percentages went down after 100% when in "`--numeric`" mode with a "`--size`" that was too small - corrects [#26 "Correct "`-n`" behaviour when going past 100% of "`-s`" size"](https://codeberg.org/a-j-wood/pv/issues/26)
 * i18n: recoded Polish translation file to UTF-8
 * i18n: removed inaccurate fuzzy translation matches
 * docs: moved all open issues into GitHub and updated the TODO list
 * docs: renamed README to README.md and altered it to Markdown format
 * docs: moved contributors from the README to docs/ACKNOWLEDGEMENTS.md
 * docs: moved TODO to TODO.md and altered it to Markdown format
 * docs: moved NEWS to NEWS.md, converted it to UTF-8, and altered it to Markdown format

### 1.6.20 - 12 September 2021

 * fix: add missing `stddef.h` include to `number.c` (Sam James)

### 1.6.19 - 5 September 2021

 * fix: starting pv in the background no longer immediately stops unless the transfer is to/from the terminal (Andriy Gapon, Jonathan Elchison)
 * fix: using "`-B`", "`-A`", or "`-T`" now switches on "`-C`" implicitly (Johannes Gerer, André Stapf)
 * fix: AIX build fixes (Peter Korsgaard)
 * i18n: updated German "`--help`" translations (Richard Fonfara)
 * i18n: switched to UTF-8 encoding, added missing translations (de,fr,pt)
 * docs: new "common switches" manual section (Jacek Wielemborek)
 * docs: use placeholder instead of `/dev/sda` in the manual (Pranav Peshwe)
 * docs: mention MacOS pipes and "`-B 1024`" in the manual (Jan Venekamp)
 * docs: correct shell in `autoconf/scripts/index.sh` (Juan Picca)
 * cleanup: various compiler warnings cleaned up

Full changelog is below:

 * (r181) added common switches section to manual (Jacek Wielemborek)
 * (r184) use placeholder instead of /dev/sda in the manual (Pranav Peshwe)
 * (r185) replace ash with sh in autoconf/scripts/index.sh (Juan Picca)
 * (r185) added note to manual about "`-B 1024`" in MacOS pipes (Jan Venekamp)
 * (r185) fix AIX config check when the CWD contains "yes" (Peter Korsgaard)
 * (r189) (#1556) updated German "`--help`" translations (Richard Fonfara)
 * (r189) updated missing German translations and changed to UTF-8 encoding
 * (r191) updated missing French translations and changed to UTF-8 encoding
 * (r193) updated missing Portuguese translations, changed to UTF-8 encoding
 * (r196) (#1563) using "`-B`", "`-A`", or "`-T`" now switches on "`-C`" implicitly (Johannes Gerer, André Stapf)
 * (r199) fixed numerous compiler warnings in newer GCC versions
 * (r200,205) fixed bug where "`pv /dev/zero >/dev/null &`" stopped immediately (Jonathan Elchison, Andriy Gapon)
 * (r203,205) marked unused arguments with GCC unused attribute, started using boolean data type for flags, corrected more compiler warnings

### 1.6.6 - 30 June 2017

 * (r161) use `%llu` instead of `%Lu` for better compatibility (Eric A. Borisch)
 * (r162) (#1532) fix target buffer size ("`-B`") being ignored (AndCycle, Ilya Basin, Antoine Beaupré)
 * (r164) cap read/write sizes, and check elapsed time during read/write cycles, to avoid display hangs with large buffers or slow media; also remove `select()` call from repeated_write function as it slows the transfer down and the wrapping `alarm()` means it is unnecessary
 * (r169) (#1477) use alternate form for transfer counter, such that 13GB is shown as 13.0GB so it's the same width as 13.1GB (André Stapf)
 * (r171) cleanup: units corrections in man page, of the form kb -> KiB
 * (r175) report error in "`-d`" if process fd directory is unreadable, or if process disappears before we start the main loop (Jacek Wielemborek)

### 1.6.0 - 15 March 2015

 * fix lstat64 support when unavailable - separate patches supplied by Ganael Laplanche and Peter Korsgaard
 * (#1506) new option "`-D`" / "`--delay-start`" to only show bar after N seconds (Damon Harper)
 * new option "`--fineta`" / "`-I`" to show ETA as time of day rather than time remaining - patch supplied by Erkki Seppälä (r147)
 * (#1509) change ETA ("`--eta`" / "`-e`") so that days are given if the hours remaining are 24 or more (Jacek Wielemborek)
 * (#1499) repeat read and write attempts on partial buffer fill/empty to work around post-signal transfer rate drop reported by Ralf Ramsauer
 * (#1507) do not try to calculate total size in line mode, due to bug reported by Jacek Wielemborek and Michiel Van Herwegen
 * cleanup: removed defunct RATS comments and unnecessary copyright notices
 * clean up displayed lines when using "`--watchfd PID`", when PID exits
 * output errors on a new line to avoid overwriting transfer bar

### 1.5.7 - 26 August 2014

 * show KiB instead of incorrect kiB (Debian bug #706175)
 * (#1284) do not gzip man page, for non-Linux OSes (Bob Friesenhahn)
 * work around "awk" bug in `tests/016-numeric-timer` in decimal "," locales
 * fix "`make rpm`" and "`make srpm`", extend "`make release`" to sign releases

### 1.5.3 - 4 May 2014

 * remove *SPLICE_F_NONBLOCK* to fix problem with slow `splice()` (Jan Seda)

### 1.5.2 - 10 February 2014

 * allow "`--watchfd`" to look at block devices
 * let "`--watchfd PID:FD`" work with "`--size N`"
 * moved contributors out of the manual as the list was too long (NB everyone is still listed in the README and always will be)

### 1.5.1 - 23 January 2014

 * new option "`--watchfd`" - suggested by Jacek Wielemborek and "fdwatch"
 * use non-block flag with `splice()`
 * new display option "`--buffer-percent`", suggested by Kim Krecht
 * new display option "`--last-written`", suggested by Kim Krecht
 * new transfer option "`--no-splice`"
 * fix for minor bug which dropped display elements after one empty one
 * fix for single fd leak on exit (Cristian Ciupitu)

### 1.4.12 - 5 August 2013

 * new option "`--null`" - patch supplied by Zing Shishak
 * AIX build fix (add "`-lc128`") - with help from Pawel Piatek
 * AIX "`-c`" fixes - with help from Pawel Piatek
 * SCO build fix (`po2table.sh`) - reported by Wouter Pronk
 * test scripts fix for older distributions - patch from Bryan Dongray
 * fix for `splice()` not using stdin - patch from Zev Weiss

### 1.4.6 - 22 January 2013

 * added patch from Pawel Piatek to omit *O_NOFOLLOW* in AIX

### 1.4.5 - 10 January 2013

 * updated manual page to show known problem with "`-R`" on Cygwin

### 1.4.4 - 11 December 2012

 * added debugging, see "`pv -h`" when `configure` is run with "`--enable-debugging`"
 * rewrote cursor positioning code used when IPC is unavailable (Cygwin)
 * fixed cursor positioning cursor read answerback problem (Cygwin/Solaris)
 * fixed bug causing crash when progress displayed with too-small terminal

### 1.4.0 - 6 December 2012

 * new option "`--skip-errors`" commissioned by Jim Salter
 * if stdout is a block device, and we don't know the total size, use the size of that block device as the total (Peter Samuelson)
 * new option "`--stop-at-size`" to stop after "`--size`" bytes
 * report correct filename on read errors
 * fix use-after-free bug in remote PID cleanup code
 * refactored large chunks of code to make it more readable and to replace most static variables with a state structure

### 1.3.9 - 5 November 2012

 * allow "`--format`" parameters to be sent with "`--remote`"
 * configure option "`--disable-ipc`"
 * added tests for "`--numeric`" with "`--timer`" and "`--bytes`"
 * added tests for "`--remote`"

### 1.3.8 - 29 October 2012

 * new "`--pidfile`" option to save process ID to a file
 * integrated patch for "`--numeric`" with "`--timer`" and "`--bytes`" (Sami Liedes)
 * removed signalling from "`--remote`" to prevent accidental process kills
 * new "`--format`" option (originally Vladimir Pal / Vladimir Ermakov)

### 1.3.4 - 27 June 2012

 * new "`--disable-splice`" configure script option
 * fixed line mode size count with multiple files (Moritz Barsnick)
 * fixes for AIX core dumps (Pawel Piatek)

### 1.3.1 - 9 June 2012

 * do not use `splice()` if the write buffer is not empty (Thomas Rachel)
 * added test 15 (pipe transfers), and new test script

### 1.3.0 - 5 June 2012

 * added Tiger build patch from Olle Jonsson
 * fix 1024-boundary display garble (Debian bug #586763)
 * use `splice`(2) where available (Debian bug #601683)
 * added known bugs section of the manual page
 * fixed average rate test, 12 (Andrew Macheret)
 * use IEEE1541 units (Thomas Rachel)
 * bug with rate limit under 10 fixed (Henry Precheur)
 * speed up PV line mode (patch: Guillaume Marcais)
 * remove `LD=ld` from `vars.mk` to fix cross-compilation (paintitgray/PV#1291)

### 1.2.0 - 14 December 2010

 * integrated improved SI prefixes and "`--average-rate`" (Henry Gebhardt)
 * return nonzero if exiting due to *SIGTERM* (Martin Baum)
 * patch from Phil Rutschman to restore terminal properly on exit
 * fix i18n especially for "`--help`" (Sebastian Kayser)
 * refactored `pv_display`
 * we now have a coherent, documented, exit status
 * modified pipe test and new cksum test from Sebastian Kayser
 * default *CFLAGS* to just "`-O`" for non-GCC (Kjetil Torgrim Homme)
 * LFS compile fix for OS X 10.4 (Alexandre de Verteuil)
 * remove *DESTDIR* `/` suffix (Sam Nelson, Daniel Pape)
 * fixed potential NULL deref in transfer (Elias Pipping / LLVM/Clang)

### 1.1.4 - 6 March 2008

 * patch from Elias Pipping correcting compilation failure on Darwin 9
 * patch from Patrick Collison correcting similar problems on OS X
 * trap *SIGINT* / *SIGHUP* / *SIGTERM* so we clean up IPCs on exit (Laszlo Ersek)
 * abort if numeric option, eg "`-L`", has non-numeric value (Boris Lohner)

### 1.1.0 - 30 August 2007

 * new option "`--remote`" ("`-R`") to control an already-running process
 * new option "`--line-mode`" ("`-l`") to count lines instead of bytes
 * fix for "`-L`" to be less resource intensive
 * fix for input/output equivalence check on Mac OS X
 * fix for size calculation in pipelines on Mac OS X
 * fixed "`make uninstall`"
 * removed "`/debian`" directory at request of new Debian maintainer

### 1.0.1 - 4 August 2007

 * licensing change from Artistic to Artistic 2.0
 * removed the "`-l`" / "`--license`" option

### 1.0.0 - 2 August 2007

 * act more like "`cat`" - just skip unreadable files, don't abort
 * removed text version of manual page, and obsolete Info file generation
 * code cleanup and separation of PV internals from CLI front-end

### 0.9.9 - 5 February 2007

 * new option "`--buffer-size`" ("`-B`") suggested by Mark Tomich
 * build fix: HP/UX largefile compile fix from Timo Savinen
 * maintain better buffer filling during transfers
 * workaround: "`pv /dev/zero | dd bs=1M count=1k`" bug (reported by Gert Menke)
 * dropped support for the Texinfo manual

### 0.9.6 - 27 February 2006

 * bugfix: `key_t` incompatibility with Cygwin
 * bugfix: interval ("`-i`") parameter parses numbers after decimal point
 * build fix: use static NLS if `msgfmt` is unavailable
 * on the final update, blank out the now-zero ETA

### 0.9.2 - 1 September 2005

 * Daniel Roethlisberger patch: use lockfiles if terminal locking fails

### 0.9.1 - 16 June 2005

 * minor RPM spec file fix for Fedora Core 4

### 0.9.0 - 15 November 2004

 * minor NLS bugfix

### 0.8.9 - 6 November 2004

 * decimal values now accepted for rate and size, eg "`-L 1.23M`"
 * code cleanup
 * developers: "`make help`" now lists Makefile targets

### 0.8.6 - 29 June 2004

 * use `uu_lock()` for terminal locking on FreeBSD

### 0.8.5 - 2 May 2004

 * cursor positioning ("`-c`") reliability improved on systems with IPC
 * minor fix: made test 005 more reliable
 * new option "`--height`" ("`-H`")

### 0.8.2 - 24 April 2004

 * allow k,m,g,t suffixes on numbers
 * added "`srpm`" and "`release`" Makefile targets

### 0.8.1 - 19 April 2004

 * bugfix in cursor positioning ("`-c`")

### 0.8.0 - 12 February 2004

 * replaced GNU getopt with my library code
 * replaced GNU gettext with my very minimal replacement
 * use *DESTDIR* instead of *RPM_BUILD_ROOT* for optional installation prefix
 * looked for flaws using RATS, cleaned up code

### 0.7.0 - 8 February 2004

 * display buffer management fixes (thanks Cédric Delfosse)
 * replaced "`--enable-debug`" with "`--enable-debugging`" and "`--enable-profiling`"

### 0.6.4 - 14 January 2004

 * fixed minor bug in RPM installation
 * bugfix in "`make index`" (only of interest to developers)

### 0.6.3 - 22 December 2003

 * fixed transient bug that reported "resource unavailable" occasionally

### 0.6.2 - 6 August 2003

 * block devices now have their size read correctly, so "`pv /dev/hda1`" works
 * minor code cleanups (mainly removal of CVS "Id" tags)

### 0.6.0 - 3 August 2003

 * doing *^Z* then "`bg`" then "`fg`" now continues displaying

### 0.5.9 - 23 July 2003

 * fix for test 007 when not in C locale
 * fix for build process to use *CPPFLAGS*
 * fix for build process to use correct i18n libraries
 * fix for build process - more portable sed in dependency generator
 * fix for install process - remember to `mkinstalldirs` before installing
 * fixes for building on Mac OS X

### 0.5.3 - 4 May 2003

 * added Polish translation thanks to Bartosz Feński <fenio@o2.pl> <http://skawina.eu.org/> and Krystian Zubel
 * moved `doc/debian` to `./debian` at insistence of common sense
 * minor Solaris 8 compatibility fixes
 * seems to compile and test OK on Mac OS X

### 0.5.0 - 15 April 2003

 * added French translation thanks to Stéphane Lacasse <stephane@gorfou.ca>
 * added German translation thanks to Marcos Kreinacke <public@kreinacke.com>
 * switched LGPL reference from "Library" to "Lesser"

### 0.4.9 - 18 February 2003

 * support for >2GB files added where available (Debian bug #180986)
 * added `doc/debian` dir (from Cédric Delfosse)
 * added "`make rpm`" and "`make deb`" targets to build RPM and Debian packages
 * added a "`make pv-static`" rule to build a statically linked version

### 0.4.5 - 13 December 2002

 * added Portuguese (Brazilian) translation thanks to Eduardo Aguiar

### 0.4.4 - 7 December 2002

 * pause/resume support - don't count time while stopped
 * stop output when resumed in the background
 * terminal size change support
 * bugfix: "`<=>`" indicator no longer sticks at right hand edge

### 0.4.0 - 27 November 2002

 * allow decimal interval values, eg 0.1, 0.5, etc
 * some simple tests added ("`make check`")
 * smoother throughput limiting ("`--rate-limit`"), now done in 0.1sec chunks
 * bounds-check interval values ("`-i`") - max update interval now 10 minutes
 * more reliable non-blocking output to keep display updated
 * no longer rely on `atoll()`
 * don't output final blank line if "`--numeric`"
 * use `fcntl()` instead of `flock()` for Solaris compatibility

### 0.3.0 - 25 November 2002

 * handle broken output pipe gracefully
 * continue updating display even when output pipe is blocking

### 0.2.6 - 21 October 2002

 * we now ignore *EINTR* on `select()`
 * variable-size buffer (still need to add code to change size)
 * added (tentative) support for internationalisation
 * removed superfluous "`--no-progress`", etc options
 * optimised transfer by using bigger buffers, based on `st_blksize`
 * added "`--wait`" option to wait until transfer begins before showing progress
 * added "`--rate-limit`" option to limit rate to a maximum throughput
 * added "`--quiet`" option (no output at all) to be used with "`--rate-limit`"

### 0.2.5 - 23 July 2002

 * added *[FILE]...* arguments, like "`cat`"
 * function separation in code
 * some bug fixes related to numeric overflow

### 0.2.3 - 19 July 2002

 * Texinfo manual written, man page updated
 * byte counter added

### 0.2.0 - 18 July 2002

 * ETA counter added
 * screen width estimation added
 * progress bar added

### 0.1.0 - 17 July 2002

 * main loop created
 * rate counter added
 * elapsed time counter added
 * percentage calculation added

### 0.0.1 - 16 July 2002

 * package created
 * first draft of man page written
