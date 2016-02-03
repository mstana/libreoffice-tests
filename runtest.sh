#!/bin/bash
sudo service gdm stop
env GIT_SSL_NO_VERIFY=true git submodule update --init --recursive



function install_deps ()
{
    dnf -y install python-behave dogtail
    dnf -y groupinstall "Basic Desktop" "GNOME" --allowerasing
}

function enable_sudo ()
{
    echo  "ALL  ALL = (ALL) NOPASSWD: ALL" >> /etc/sudoers
}

function env_preprequsites ()
{
    dnf -y install libreoffice* abrt-python jre

    # this is for weird auth dialog shown in overview mode
    dnf -y remove gnome-color-manager gnome-software

    # # use dummy driver for headless start
    # /bin/cp /mnt/tests/gnome-boxes/xorg.conf /etc/X11

    # cd /tmp
    # git clone https://github.com/vbenes/gnome-boxes.git

    usermod -G10 test
    sudo echo yes > /home/test/.config/gnome-initial-setup-done

    systemctl restart libvirtd.service
    systemctl restart abrtd.service
}

enable_sudo
install_deps
env_preprequsites

# Here we store exit code for the task in tmp file
# Because we need a report
# TODO: write a better rhts-run-simple-test
sudo -u test dogtail-run-headless-next "behave -t $1 -k -f html -o /tmp/report_$TEST.html -f plain"; rc=$?

RESULT="FAIL"
if [ $rc -eq 0 ]; then
  RESULT="PASS"
fi
rhts-report-result $TEST $RESULT "/tmp/report_$TEST.html"
exit $rc
