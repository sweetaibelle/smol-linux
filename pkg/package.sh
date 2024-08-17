#!/bin/bash

# Useful variables.
source config.sh

# Generic functions we'll want to use in multiple places.
source pkg/base.sh

# Pull in all the various package functions, so we can use them in the main script.
source pkg/core_utils.sh
source pkg/kernel.sh
source pkg/boot.sh
source pkg/editors.sh
source pkg/shells.sh
