#!/usr/local/bin/perl -w
# $Id:$
# $HeadURL:$
use strict;
use warnings;

use Carp;
use Getopt::Long;
Getopt::Long::Configure qw/bundling no_ignore_case/;
use Data::Dumper;
# Some Data::Dumper settings:
local $Data::Dumper::Useqq  = 1;
local $Data::Dumper::Indent = 3;

use lib '.';
use Process;

local $| = 1;

my $debug = 0;

GetOptions(
   "debug|d"        => \$debug,
);

my $prog = $0;
$prog =~ s/^.*\///;

my $p1 = Process->new( { pid => 1, name => 'init' } );
my $p2 = Process->new( { pid => 2, name => 'bash' } );
my $p3 = Process->new( { pid => 3, name => 'ls' } );
my $p4 = Process->new( { pid => 4, name => 'grep' } );

my $p5 = Process->new( { pid => 5, name => 'netstat' } );
my $p6 = Process->new( { pid => 6, name => 'top' } );

$p1->add_kid( $p6 );
$p1->add_kid( $p5 );

$p1->add_kid( $p2 );
my $tmp = $p1->get_pid( 2 );
$tmp->add_kid( $p3 );
$tmp->add_kid( $p4 );

print Dumper $p1;
#print Dumper $p2;

print "================\n";
$p1->print_all();

__END__

__DATA__
UID        PID  PPID  C STIME TTY          TIME CMD
root         1     0  0 Jun30 ?        00:00:11 /sbin/init
root         2     0  0 Jun30 ?        00:00:00 [kthreadd]
root         3     2  0 Jun30 ?        00:00:05 [migration/0]
root         4     2  0 Jun30 ?        00:01:56 [ksoftirqd/0]
root         5     2  0 Jun30 ?        00:00:00 [migration/0]
root         6     2  0 Jun30 ?        00:00:03 [watchdog/0]
root         7     2  0 Jun30 ?        00:00:12 [migration/1]
root         8     2  0 Jun30 ?        00:00:00 [migration/1]
root         9     2  0 Jun30 ?        00:04:11 [ksoftirqd/1]
root        10     2  0 Jun30 ?        00:00:03 [watchdog/1]
root        11     2  0 Jun30 ?        00:00:05 [migration/2]
root        12     2  0 Jun30 ?        00:00:00 [migration/2]
root        13     2  0 Jun30 ?        00:02:16 [ksoftirqd/2]
root        14     2  0 Jun30 ?        00:00:03 [watchdog/2]
root        15     2  0 Jun30 ?        00:00:04 [migration/3]
root        16     2  0 Jun30 ?        00:00:00 [migration/3]
root        17     2  0 Jun30 ?        00:02:38 [ksoftirqd/3]
root        18     2  0 Jun30 ?        00:00:03 [watchdog/3]
root        19     2  0 Jun30 ?        00:00:03 [migration/4]
root        20     2  0 Jun30 ?        00:00:00 [migration/4]
root        21     2  0 Jun30 ?        00:01:51 [ksoftirqd/4]
root        22     2  0 Jun30 ?        00:00:03 [watchdog/4]
root        23     2  0 Jun30 ?        00:00:11 [migration/5]
root        24     2  0 Jun30 ?        00:00:00 [migration/5]
root        25     2  0 Jun30 ?        00:04:56 [ksoftirqd/5]
root        26     2  0 Jun30 ?        00:00:03 [watchdog/5]
root        27     2  0 Jun30 ?        00:00:06 [migration/6]
root        28     2  0 Jun30 ?        00:00:00 [migration/6]
root        29     2  0 Jun30 ?        00:02:18 [ksoftirqd/6]
root        30     2  0 Jun30 ?        00:00:03 [watchdog/6]
root        31     2  0 Jun30 ?        00:00:05 [migration/7]
root        32     2  0 Jun30 ?        00:00:00 [migration/7]
root        33     2  0 Jun30 ?        00:02:31 [ksoftirqd/7]
root        34     2  0 Jun30 ?        00:00:03 [watchdog/7]
root        35     2  0 Jun30 ?        00:03:53 [events/0]
root        36     2  0 Jun30 ?        00:02:24 [events/1]
root        37     2  0 Jun30 ?        00:01:49 [events/2]
root        38     2  0 Jun30 ?        00:01:40 [events/3]
root        39     2  0 Jun30 ?        00:02:04 [events/4]
root        40     2  0 Jun30 ?        00:01:54 [events/5]
root        41     2  0 Jun30 ?        00:01:46 [events/6]
root        42     2  0 Jun30 ?        00:02:23 [events/7]
root        43     2  0 Jun30 ?        00:00:00 [cgroup]
root        44     2  0 Jun30 ?        00:00:00 [khelper]
root        45     2  0 Jun30 ?        00:00:00 [netns]
root        46     2  0 Jun30 ?        00:00:00 [async/mgr]
root        47     2  0 Jun30 ?        00:00:00 [pm]
root        48     2  0 Jun30 ?        00:00:15 [sync_supers]
root        49     2  0 Jun30 ?        00:00:13 [bdi-default]
root        50     2  0 Jun30 ?        00:00:00 [kintegrityd/0]
root        51     2  0 Jun30 ?        00:00:00 [kintegrityd/1]
root        52     2  0 Jun30 ?        00:00:00 [kintegrityd/2]
root        53     2  0 Jun30 ?        00:00:00 [kintegrityd/3]
root        54     2  0 Jun30 ?        00:00:00 [kintegrityd/4]
root        55     2  0 Jun30 ?        00:00:00 [kintegrityd/5]
root        56     2  0 Jun30 ?        00:00:00 [kintegrityd/6]
root        57     2  0 Jun30 ?        00:00:00 [kintegrityd/7]
root        58     2  0 Jun30 ?        00:00:02 [kblockd/0]
root        59     2  0 Jun30 ?        00:00:00 [kblockd/1]
root        60     2  0 Jun30 ?        00:00:00 [kblockd/2]
root        61     2  0 Jun30 ?        00:00:04 [kblockd/3]
root        62     2  0 Jun30 ?        00:00:17 [kblockd/4]
root        63     2  0 Jun30 ?        00:00:00 [kblockd/5]
root        64     2  0 Jun30 ?        00:00:04 [kblockd/6]
root        65     2  0 Jun30 ?        00:00:20 [kblockd/7]
root        66     2  0 Jun30 ?        00:00:00 [kacpid]
root        67     2  0 Jun30 ?        00:00:00 [kacpi_notify]
root        68     2  0 Jun30 ?        00:00:00 [kacpi_hotplug]
root        69     2  0 Jun30 ?        00:00:00 [ata_aux]
root        70     2  0 Jun30 ?        00:00:00 [ata_sff/0]
root        71     2  0 Jun30 ?        00:00:00 [ata_sff/1]
root        72     2  0 Jun30 ?        00:00:00 [ata_sff/2]
root        73     2  0 Jun30 ?        00:00:00 [ata_sff/3]
root        74     2  0 Jun30 ?        00:00:00 [ata_sff/4]
root        75     2  0 Jun30 ?        00:00:00 [ata_sff/5]
root        76     2  0 Jun30 ?        00:00:00 [ata_sff/6]
root        77     2  0 Jun30 ?        00:00:00 [ata_sff/7]
root        78     2  0 Jun30 ?        00:00:00 [ksuspend_usbd]
root        79     2  0 Jun30 ?        00:00:00 [khubd]
root        80     2  0 Jun30 ?        00:00:00 [kseriod]
root        81     2  0 Jun30 ?        00:00:00 [md/0]
root        82     2  0 Jun30 ?        00:00:00 [md/1]
root        83     2  0 Jun30 ?        00:00:00 [md/2]
root        84     2  0 Jun30 ?        00:00:00 [md/3]
root        85     2  0 Jun30 ?        00:00:00 [md/4]
root        86     2  0 Jun30 ?        00:00:00 [md/5]
root        87     2  0 Jun30 ?        00:00:00 [md/6]
root        88     2  0 Jun30 ?        00:00:00 [md/7]
root        89     2  0 Jun30 ?        00:00:00 [md_misc/0]
root        90     2  0 Jun30 ?        00:00:00 [md_misc/1]
root        91     2  0 Jun30 ?        00:00:00 [md_misc/2]
root        92     2  0 Jun30 ?        00:00:00 [md_misc/3]
root        93     2  0 Jun30 ?        00:00:00 [md_misc/4]
root        94     2  0 Jun30 ?        00:00:00 [md_misc/5]
root        95     2  0 Jun30 ?        00:00:00 [md_misc/6]
root        96     2  0 Jun30 ?        00:00:00 [md_misc/7]
root        97     2  0 Jun30 ?        00:00:00 [linkwatch]
root        98     2  0 Jun30 ?        00:00:02 [khungtaskd]
root        99     2  0 Jun30 ?        00:29:57 [kswapd0]
root       100     2  0 Jun30 ?        00:00:00 [ksmd]
root       101     2  0 Jun30 ?        00:00:26 [khugepaged]
root       102     2  0 Jun30 ?        00:00:00 [aio/0]
root       103     2  0 Jun30 ?        00:00:00 [aio/1]
root       104     2  0 Jun30 ?        00:00:00 [aio/2]
root       105     2  0 Jun30 ?        00:00:00 [aio/3]
root       106     2  0 Jun30 ?        00:00:00 [aio/4]
root       107     2  0 Jun30 ?        00:00:00 [aio/5]
root       108     2  0 Jun30 ?        00:00:00 [aio/6]
root       109     2  0 Jun30 ?        00:00:00 [aio/7]
root       110     2  0 Jun30 ?        00:00:00 [crypto/0]
root       111     2  0 Jun30 ?        00:00:00 [crypto/1]
root       112     2  0 Jun30 ?        00:00:00 [crypto/2]
root       113     2  0 Jun30 ?        00:00:00 [crypto/3]
root       114     2  0 Jun30 ?        00:00:00 [crypto/4]
root       115     2  0 Jun30 ?        00:00:00 [crypto/5]
root       116     2  0 Jun30 ?        00:00:00 [crypto/6]
root       117     2  0 Jun30 ?        00:00:00 [crypto/7]
root       122     2  0 Jun30 ?        00:00:00 [kthrotld/0]
root       123     2  0 Jun30 ?        00:00:00 [kthrotld/1]
root       124     2  0 Jun30 ?        00:00:00 [kthrotld/2]
root       125     2  0 Jun30 ?        00:00:00 [kthrotld/3]
root       126     2  0 Jun30 ?        00:00:00 [kthrotld/4]
root       127     2  0 Jun30 ?        00:00:00 [kthrotld/5]
root       128     2  0 Jun30 ?        00:00:00 [kthrotld/6]
root       129     2  0 Jun30 ?        00:00:00 [kthrotld/7]
root       131     2  0 Jun30 ?        00:00:00 [kpsmoused]
root       132     2  0 Jun30 ?        00:00:00 [usbhid_resumer]
root       163     2  0 Jun30 ?        00:00:00 [kstriped]
root       194     2  0 Jun30 ?        00:00:07 [i915]
root       195     2  0 Jun30 ?        00:00:00 [kslowd000]
root       196     2  0 Jun30 ?        00:00:00 [kslowd001]
root       325     1  0 Jul08 ?        00:00:00 /usr/sbin/sshd
root       388     2  0 Jun30 ?        00:00:00 [scsi_eh_0]
root       389     2  0 Jun30 ?        00:00:00 [scsi_eh_1]
root       390     2  0 Jun30 ?        00:00:00 [scsi_eh_2]
root       391     2  0 Jun30 ?        00:00:00 [scsi_eh_3]
root       392     2  0 Jun30 ?        00:00:00 [scsi_eh_4]
root       462     2  0 Jun30 ?        00:00:00 [kdmflush]
root       464     2  0 Jun30 ?        00:00:15 [kdmflush]
root       485     2  0 Jun30 ?        00:07:22 [kjournald]
root       578     1  0 Jun30 ?        00:00:00 /sbin/udevd -d
root       632     2  0 Jun30 ?        00:00:00 [hd-audio0]
root       635     2  0 Jun30 ?        00:00:00 [hd-audio1]
root      1088   578  0 Jun30 ?        00:00:00 /sbin/udevd -d
root      1092     2  0 Jun30 ?        00:00:00 [kvm-irqfd-clean]
root      1173     2  0 Jun30 ?        00:03:44 [flush-253:1]
root      1183     2  0 Jun30 ?        00:00:02 [kauditd]
root      1519     1  0 Jun30 ?        00:00:09 auditd
root      1544     1  0 Jun30 ?        00:01:50 /sbin/rsyslogd -i /var/run/syslogd.pid -c 5
root      1567     2  0 Jun30 ?        00:08:44 [kondemand/0]
root      1568     2  0 Jun30 ?        00:56:53 [kondemand/1]
root      1569     2  0 Jun30 ?        00:03:53 [kondemand/2]
root      1570     2  0 Jun30 ?        00:03:17 [kondemand/3]
root      1571     2  0 Jun30 ?        00:05:32 [kondemand/4]
root      1572     2  0 Jun30 ?        00:10:08 [kondemand/5]
root      1573     2  0 Jun30 ?        00:02:58 [kondemand/6]
root      1574     2  0 Jun30 ?        00:03:01 [kondemand/7]
root      1595     1  0 Jun30 ?        00:04:52 irqbalance --pid=/var/run/irqbalance.pid
rpc       1614     1  0 Jun30 ?        00:00:03 rpcbind
dbus      1711     1  0 Jun30 ?        00:00:26 dbus-daemon --system
root      1721     1  0 Jun30 ?        00:00:07 NetworkManager --pid-file=/var/run/NetworkManager/NetworkManager.pid
root      1725     1  0 Jun30 ?        00:00:00 /usr/sbin/modem-manager
avahi     1733     1  0 Jun30 ?        00:12:11 avahi-daemon: registering [SJCL00564714A.local]
avahi     1734  1733  0 Jun30 ?        00:00:00 avahi-daemon: chroot helper
rpcuser   1753     1  0 Jun30 ?        00:00:00 rpc.statd
root      1757  1721  0 Jun30 ?        00:00:01 /sbin/dhclient -d -4 -sf /usr/libexec/nm-dhcp-client.action -pf /var/run/dhclient-eth0.pid -lf /va
root      1760     1  0 Jun30 ?        00:00:00 /usr/sbin/wpa_supplicant -c /etc/wpa_supplicant/wpa_supplicant.conf -B -u -f /var/log/wpa_supplica
root      1786     1  0 Jun30 ?        00:00:00 cupsd -C /etc/cups/cupsd.conf
root      1811     1  0 Jun30 ?        00:00:00 /usr/sbin/acpid
68        1820     1  0 Jun30 ?        00:00:26 hald
root      1821  1820  0 Jun30 ?        00:00:00 hald-runner
root      1869  1821  0 Jun30 ?        00:00:00 /usr/libexec/hald-addon-generic-backlight
68        1871  1821  0 Jun30 ?        00:00:00 hald-addon-acpi: listening on acpid socket /var/run/acpid.socket
root      1872  1821  0 Jun30 ?        00:00:00 hald-addon-input: Listening on /dev/input/event6 /dev/input/event5 /dev/input/event0/dev/input/ev
root      1953     1  0 Jun30 ?        00:06:47 /opt/quest/sbin/.vasd -p /var/opt/quest/vas/vasd/.vasd.pid
root      2014     1  0 Jun30 ?        00:00:00 /usr/sbin/mcelog --daemon
root      2023     1  0 Jun30 ?        00:00:21 /opt/quest/sbin/vasidmapd -D -P /var/run/vasidmapd.pid
root      2042     1  0 Jun30 ?        00:00:00 xinetd -stayalive -pidfile /var/run/xinetd.pid
ntp       2050     1  0 Jun30 ?        00:00:04 ntpd -u ntp:ntp -p /var/run/ntpd.pid -g
root      2130     1  0 Jun30 ?        00:02:08 /usr/libexec/postfix/master
postfix   2145  2130  0 Jun30 ?        00:02:31 qmgr -l -t fifo -u
root      2155     1  0 Jun30 ?        00:00:00 /usr/sbin/abrtd
root      2165     1  0 Jun30 ?        00:00:04 abrt-dump-oops -d /var/spool/abrt -rwx /var/log/messages
root      2179     1  0 Jun30 ?        00:01:46 /bin/bash /usr/sbin/ksmtuned
root      2188     1  0 Jun30 ?        00:00:32 crond
root      2290     1  0 Jun30 ?        00:00:00 /usr/sbin/atd
root      2410     1  0 Jun30 ?        00:00:00 libvirtd --daemon
root      2446     1  0 Jun30 ?        00:00:00 /usr/bin/rhsmcertd
root      2468   578  0 Jun30 ?        00:00:00 /sbin/udevd -d
root      2504  2050  0 Jun30 ?        00:00:10 ntpd -u ntp:ntp -p /var/run/ntpd.pid -g
nobody    2517     1  0 Jun30 ?        00:00:01 /usr/sbin/dnsmasq --strict-order --pid-file=/var/run/libvirt/network/default.pid --conf-file= --ex
root      2539     1  0 Jun30 ?        00:00:05 /usr/sbin/cimserver
root      2583     1  0 Jun30 ?        00:00:00 /usr/sbin/gdm-binary -nodaemon
root      2588     1  0 Jun30 tty2     00:00:00 /sbin/mingetty /dev/tty2
root      2590     1  0 Jun30 tty3     00:00:00 /sbin/mingetty /dev/tty3
root      2592     1  0 Jun30 tty4     00:00:00 /sbin/mingetty /dev/tty4
root      2594     1  0 Jun30 tty5     00:00:00 /sbin/mingetty /dev/tty5
root      2596     1  0 Jun30 tty6     00:00:00 /sbin/mingetty /dev/tty6
root      2640  2583  0 Jun30 ?        00:00:00 /usr/libexec/gdm-simple-slave --display-id /org/gnome/DisplayManager/Display1 --force-active-vt
root      2643  2640  0 Jun30 tty1     00:03:12 /usr/bin/Xorg :0 -nr -verbose -audit 4 -auth /var/run/gdm/auth-for-gdm-rUkmFt/database -nolisten t
root      2667     1  0 Jun30 ?        00:00:02 /usr/sbin/console-kit-daemon --no-daemon
gdm       2737     1  0 Jun30 ?        00:00:00 /usr/bin/dbus-launch --exit-with-session
root      2742     1  0 Jun30 ?        00:00:00 /usr/libexec/devkit-power-daemon
root      2786     1  0 Jun30 ?        00:00:04 /usr/libexec/polkit-1/polkitd
rtkit     2793     1  0 Jun30 ?        00:00:44 /usr/libexec/rtkit-daemon
root      2800  2640  0 Jun30 ?        00:00:00 pam: gdm-password
daemon    2806  1953  0 Jun30 ?        00:07:01 /opt/quest/sbin/.vasd -p /var/opt/quest/vas/vasd/.vasd.pid
daemon    2807  2806  0 Jun30 ?        00:15:32 /opt/quest/sbin/.vasd -p /var/opt/quest/vas/vasd/.vasd.pid
daemon    2808  2806  0 Jun30 ?        00:03:17 /opt/quest/sbin/.vasd -p /var/opt/quest/vas/vasd/.vasd.pid
daemon    2809  2806  0 Jun30 ?        00:00:05 /opt/quest/sbin/.vasd -p /var/opt/quest/vas/vasd/.vasd.pid
I836129   2817     1  0 Jun30 ?        00:00:01 /usr/bin/gnome-keyring-daemon --daemonize --login
I836129   2827  2800  0 Jun30 ?        00:00:02 gnome-session
I836129   2842     1  0 Jun30 ?        00:00:00 dbus-launch --sh-syntax --exit-with-session
I836129   2843     1  0 Jun30 ?        00:00:02 /bin/dbus-daemon --fork --print-pid 5 --print-address 7 --session
I836129   2901     1  0 Jun30 ?        00:00:31 /usr/libexec/gconfd-2
I836129   2935     1  0 Jun30 ?        00:03:41 /usr/libexec/gnome-settings-daemon
I836129   2937     1  0 Jun30 ?        00:00:00 seahorse-daemon
I836129   2939     1  0 Jun30 ?        00:00:00 /usr/libexec/gvfsd
I836129   2961  2827  0 Jun30 ?        00:00:11 metacity
I836129   2965     1  0 Jun30 ?        00:00:00 /usr/bin/pulseaudio --start --log-target=syslog
I836129   2966  2827  0 Jun30 ?        00:01:54 gnome-panel
I836129   2970  2827  0 Jun30 ?        00:27:23 nautilus
I836129   2972     1  0 Jun30 ?        00:00:00 /usr/libexec/bonobo-activation-server --ac-activate --ior-output-fd=18
I836129   2973  2965  0 Jun30 ?        00:00:00 /usr/libexec/pulse/gconf-helper
I836129   2980     1  0 Jun30 ?        00:00:03 /usr/libexec/wnck-applet --oaf-activate-iid=OAFIID:GNOME_Wncklet_Factory --oaf-ior-fd=18
I836129   2981  2827  0 Jun30 ?        00:00:02 nm-applet --sm-disable
I836129   2983     1  0 Jun30 ?        00:00:00 /usr/libexec/trashapplet --oaf-activate-iid=OAFIID:GNOME_Panel_TrashApplet_Factory --oaf-ior-fd=24
I836129   2986     1  0 Jun30 ?        00:00:04 /usr/libexec/gvfs-gdu-volume-monitor
I836129   2987  2827  0 Jun30 ?        00:00:00 python /usr/share/system-config-printer/applet.py
I836129   2988  2827  0 Jun30 ?        00:00:00 bluetooth-applet
I836129   2994     1  0 Jun30 ?        00:00:00 /usr/libexec/im-settings-daemon
root      2997     1  0 Jun30 ?        00:01:32 /usr/libexec/udisks-daemon
I836129   2999  2827  0 Jun30 ?        00:00:00 /usr/libexec/polkit-gnome-authentication-agent-1
I836129   3003  2827  0 Jun30 ?        00:00:00 gnome-volume-control-applet
I836129   3005  2827  0 Jun30 ?        00:00:01 /usr/libexec/gdu-notification-daemon
I836129   3012  2827  0 Jun30 ?        00:00:00 rhsm-icon
I836129   3013  2827  0 Jun30 ?        00:00:00 abrt-applet
I836129   3015  2827  0 Jun30 ?        00:00:45 gnome-power-manager
I836129   3018     1  0 Jun30 ?        00:00:49 /usr/libexec/gvfsd-trash --spawner :1.14 /org/gtk/gvfs/exec_spaw/0
root      3019  2997  0 Jun30 ?        00:00:00 udisks-daemon: not polling any devices
I836129   3045     1  0 Jun30 ?        00:01:43 /usr/libexec/gvfs-afc-volume-monitor
I836129   3076     1  0 Jun30 ?        00:00:00 /usr/libexec/gvfs-gphoto2-volume-monitor
I836129   3189     1  0 Jun30 ?        00:00:00 /usr/libexec/gconf-im-settings-daemon
I836129   3190     1  0 Jun30 ?        00:02:03 gnome-screensaver
I836129   3193     1  0 Jun30 ?        00:01:16 /usr/libexec/clock-applet --oaf-activate-iid=OAFIID:GNOME_ClockApplet_Factory --oaf-ior-fd=19
I836129   3196     1  0 Jun30 ?        00:00:00 /usr/bin/gnote --panel-applet --oaf-activate-iid=OAFIID:GnoteApplet_Factory --oaf-ior-fd=28
I836129   3198     1  0 Jun30 ?        00:00:00 /usr/libexec/notification-area-applet --oaf-activate-iid=OAFIID:GNOME_NotificationAreaApplet_Facto
I836129   3199     1  0 Jun30 ?        00:00:01 /usr/libexec/gdm-user-switch-applet --oaf-activate-iid=OAFIID:GNOME_FastUserSwitchApplet_Factory -
I836129   3212     1  0 Jun30 ?        00:00:00 /usr/libexec/gvfsd-burn --spawner :1.14 /org/gtk/gvfs/exec_spaw/1
I836129   3214     1  0 Jun30 ?        00:00:05 /usr/bin/gnome-terminal -x /bin/sh -c cd '/sapmnt/HOME/i836129/Desktop' && exec $SHELL
I836129   3215  3214  0 Jun30 ?        00:00:00 gnome-pty-helper
I836129   3216  3214  0 Jun30 pts/0    00:00:00 /bin/bash
root      3308  3216  0 Jun30 pts/0    00:00:00 sudo su -
root      3309  3308  0 Jun30 pts/0    00:00:00 su -
root      3312  3309  0 Jun30 pts/0    00:00:00 -bash
root      3320 19851  0 Aug04 ?        00:00:40 /opt/McAfee/cma/bin/cma
I836129   3369     1  0 Jun30 ?        00:00:01 /usr/libexec/notification-daemon
mkandel   3858 27544  0 Aug04 pts/3    00:00:00 /home/mkandel/.vim_hydra/bin/vim bin/prepare-instant-restore
root      6393     1  0 Jun30 ?        00:00:18 /usr/sbin/ypbind
root      7354     1  1 Jul12 ?        08:52:05 dbsrv16 -s none -ti 0 -x tcpip(PORT=11751;DOBROAD=NO;BLISTENER=NO) -o /opt/sybase/REP-15_5/samp_re
root      7638     1  0 Jul12 ?        00:00:00 sh -c /opt/sybase/REP-15_5/samp_repserver/RUN_SAMPLE_RS > /opt/sybase/REP-15_5/init/logs/tmp 2>&1
root      7639  7638  0 Jul12 ?        00:00:00 sh -c /opt/sybase/REP-15_5/samp_repserver/RUN_SAMPLE_RS > /opt/sybase/REP-15_5/init/logs/tmp 2>&1
root      7640  7639  0 Jul12 ?        00:05:52 /opt/sybase/REP-15_5/bin/repserver -SSAMPLE_RS -C/opt/sybase/REP-15_5/samp_repserver/SAMPLE_RS.cfg
root     10003     1  0 Jun30 ?        00:42:41 automount --pid-file /var/run/autofs.pid
root     10031     2  0 Jun30 ?        00:00:00 [rpciod/0]
root     10032     2  0 Jun30 ?        00:00:41 [rpciod/1]
root     10033     2  0 Jun30 ?        00:00:00 [rpciod/2]
root     10034     2  0 Jun30 ?        00:00:00 [rpciod/3]
root     10035     2  0 Jun30 ?        00:00:00 [rpciod/4]
root     10036     2  0 Jun30 ?        00:00:00 [rpciod/5]
root     10037     2  0 Jun30 ?        00:00:00 [rpciod/6]
root     10038     2  0 Jun30 ?        00:00:00 [rpciod/7]
root     10040     2  0 Jun30 ?        00:00:27 [nfsiod]
mkandel  10839     1  0 Jun30 ?        00:00:00 ssh-agent
root     11174     2  0 Jul09 ?        00:00:00 [lockd]
I836129  17525  3214  0 Jul11 pts/6    00:00:00 bash
root     18719     2  0 00:39 ?        00:00:00 [flush-0:39]
root     18730 20139  1 00:39 ?        00:00:06 /opt/NAI/LinuxShield/libexec/scanner -e /opt/NAI/LinuxShield/engine/lib/liblnxfv.so -D /opt/NAI/Li
root     18958  2179  0 00:46 ?        00:00:00 sleep 60
postfix  18959  2130  0 00:46 ?        00:00:00 pickup -l -t fifo -u
root     18964     1  1 00:46 ?        00:00:00 /opt/quest/libexec/vas/get_domain_reachable global.corp.sap
mkandel  18970 23720  0 00:46 pts/1    00:00:00 ps -ef
root     19815     1  0 Jul01 ?        00:00:00 /opt/McAfee/cma/bin/cma
root     19851 19815  0 Jul01 ?        00:00:39 /opt/McAfee/cma/bin/cma
root     19852 19851  0 Jul01 ?        00:11:46 /opt/McAfee/cma/bin/cma
root     19853 19851  0 Jul01 ?        00:01:46 /opt/McAfee/cma/bin/cma
root     19856 19851  0 Jul01 ?        00:00:30 /opt/McAfee/cma/bin/cma
root     19857 19851  0 Jul01 ?        00:00:00 /opt/McAfee/cma/bin/cma
root     19858 19851  0 Jul01 ?        00:00:22 /opt/McAfee/cma/bin/cma
root     19859 19851  0 Jul01 ?        00:00:29 /opt/McAfee/cma/bin/cma
root     19860 19851  0 Jul01 ?        00:00:07 /opt/McAfee/cma/bin/cma
root     19861 19851  0 Jul01 ?        00:00:00 /opt/McAfee/cma/bin/cma
root     19862 19851  0 Jul01 ?        00:00:00 /opt/McAfee/cma/bin/cma
root     19863 19851  0 Jul01 ?        00:00:00 /opt/McAfee/cma/bin/cma
root     19864 19851  0 Jul01 ?        00:01:20 /opt/McAfee/cma/bin/cma
root     19867 19851  0 Jul01 ?        00:00:52 /opt/McAfee/cma/bin/cma
root     19871 19851  0 Jul01 ?        00:00:00 /opt/McAfee/cma/bin/cma
root     19980 19851  0 Jul01 ?        00:17:02 /opt/McAfee/cma/bin/cma
root     19981 19851  0 Jul01 ?        00:17:03 /opt/McAfee/cma/bin/cma
root     20004 19851  0 Jul01 ?        00:00:21 /opt/McAfee/cma/bin/cma
root     20006 19851  0 Jul01 ?        00:00:27 /opt/McAfee/cma/bin/cma
root     20139     1  0 Jul24 ?        00:19:22 /opt/NAI/LinuxShield/libexec/nailsd -c /var/opt/NAI/LinuxShield/etc/nailsd.cfg
root     20140 20139  0 Jul24 ?        00:00:03 /opt/NAI/LinuxShield/libexec/nailslogd -p 8 -l 5 -s 6 -c /var/opt/NAI/LinuxShield/etc/nailsd.cfg
root     20141 20140  0 Jul24 ?        00:03:57 /opt/NAI/LinuxShield/libexec/nailslogd -p 8 -l 5 -s 6 -c /var/opt/NAI/LinuxShield/etc/nailsd.cfg
root     20144 20141  0 Jul24 ?        00:07:03 /opt/NAI/LinuxShield/libexec/logepo -c /var/opt/NAI/LinuxShield/etc/nailsd.cfg -p 13 -d EPO=n
root     20150     1  0 Jul24 ?        00:00:57 /opt/NAI/LinuxShield/libexec/mon -p /var/opt/NAI/LinuxShield/etc/monitor.cfg
root     20162     1  0 Jul24 ?        00:00:44 /opt/NAI/LinuxShield/apache/bin/nailswebd -d /opt/NAI/LinuxShield/apache -DSSL
nails    20172 20162  0 Jul24 ?        00:04:26 /opt/NAI/LinuxShield/apache/bin/nailswebd -d /opt/NAI/LinuxShield/apache -DSSL
nails    20173 20162  0 Jul24 ?        00:04:25 /opt/NAI/LinuxShield/apache/bin/nailswebd -d /opt/NAI/LinuxShield/apache -DSSL
nails    20174 20162  0 Jul24 ?        00:04:26 /opt/NAI/LinuxShield/apache/bin/nailswebd -d /opt/NAI/LinuxShield/apache -DSSL
root     23712   325  0 Aug04 ?        00:00:00 sshd: mkandel [priv]
mkandel  23718 23712  0 Aug04 ?        00:00:01 sshd: mkandel@pts/1
mkandel  23720 23718  0 Aug04 pts/1    00:00:00 -bash
root     23992 20141  0 Jul25 ?        00:00:00 /bin/sh /opt/NAI/LinuxShield/libexec/nails-ods -c /var/opt/NAI/LinuxShield/etc/nailsd.cfg -t2 -nLi
root     24214 23992  0 Jul25 ?        00:00:00 /bin/sh /opt/NAI/LinuxShield/libexec/nails-ods -c /var/opt/NAI/LinuxShield/etc/nailsd.cfg -t2 -nLi
root     24223 24214  0 Jul25 ?        00:00:00 /bin/sh /opt/NAI/LinuxShield/libexec/nails-ods -c /var/opt/NAI/LinuxShield/etc/nailsd.cfg -t2 -nLi
root     24224 24223  5 Jul25 ?        13:53:40 find / ( -path /area51 -o -path /BackupDB1 -o -path /Benchmark -o -path /data/lovbackup -o -path /
root     27451   325  0 Aug04 ?        00:00:00 sshd: mkandel [priv]
mkandel  27453 27451  0 Aug04 ?        00:00:00 sshd: mkandel@pts/2
mkandel  27454 27453  0 Aug04 pts/2    00:00:00 -bash
root     27541   325  0 Aug04 ?        00:00:00 sshd: mkandel [priv]
mkandel  27543 27541  0 Aug04 ?        00:00:00 sshd: mkandel@pts/3
mkandel  27544 27543  0 Aug04 pts/3    00:00:00 -bash
root     28710     1  0 Jul10 ?        00:00:00 ssh-agent
root     29572     1  0 Jul11 ?        00:00:00 /bin/sh /opt/NAI/LinuxShield/libexec/nails-ods -c /var/opt/NAI/LinuxShield/etc/nailsd.cfg -t2 -nLi
root     29794 29572  0 Jul11 ?        00:00:00 /bin/sh /opt/NAI/LinuxShield/libexec/nails-ods -c /var/opt/NAI/LinuxShield/etc/nailsd.cfg -t2 -nLi
root     29803 29794  0 Jul11 ?        00:00:00 /bin/sh /opt/NAI/LinuxShield/libexec/nails-ods -c /var/opt/NAI/LinuxShield/etc/nailsd.cfg -t2 -nLi
root     29804 29803  3 Jul11 ?        21:33:03 find / ( -path /area51 -o -path /BackupDB1 -o -path /Benchmark -o -path /data/lovbackup -o -path /
I836129  30553     1  0 Jul09 ?        00:00:05 /usr/bin/gpk-update-icon
