#!/bin/bash
# sudo@redhat.com, 2022
# Creates insights-client archive to /tmp/insights.tar.gz
# Applies whatever you do in validate_content and then uploads to Red Hat
# To use, rename /usr/bin/insights-client to /usr/bin/insights-client-bin

validate_content()
{
	insights_dir=$(find /tmp/* -maxdepth 0 -type d)
	grep -r "[1-2][0-9][0-9][0-9][0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]" $insights_dir
	grep -r "Magnus" /tmp/insights* $insights_dir
}

insights-client-bin --no-upload -of /tmp/insights.tar.gz
cd /tmp
tar xvzf insights.tar.gz >/dev/null 2>&1
validate_content
tar cvzf $insights-dir insights.tar.gz >/dev/null 2>&1
insights-client-bin --payload /tmp/insights.tar.gz --content-type gz
rm -rf /tmp/insights*
