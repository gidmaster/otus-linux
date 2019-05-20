#!/bin/bash

declare -r module_dir="/usr/lib/dracut/modules.d/01test"

mkdir "$module_dir"
mv /vagrant/dracut/module-setup.sh "$module_dir"
mv /vagrant/dracut/test.sh "$module_dir"

dracut -fv