#!/bin/bash

egrep 'alipay|alibaba' -ri . | grep -v auto-save-list | grep -v projectile-bookmarks.eld | grep -v recentf | grep -v projectile.cache | grep -v sanity_check.sh
