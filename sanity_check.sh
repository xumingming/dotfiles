#!/bin/bash

egrep 'alipay|alibaba' -ri . | grep -v sanity_check.sh
