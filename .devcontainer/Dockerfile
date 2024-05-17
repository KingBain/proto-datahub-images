#-------------------------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See https://go.microsoft.com/fwlink/?linkid=2090316 for license information.
#-------------------------------------------------------------------------------------------------------------

FROM cgr.dev/chainguard/az:latest

# Install a shell and other essential tools
RUN apk add --no-cache bash \
    && ln -sf /bin/bash /bin/sh

COPY first-run-notice.txt /tmp/scripts/

