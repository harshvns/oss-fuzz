FROM gcr.io/oss-fuzz-base/base-builder

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    make autoconf automake libtool build-essential \
    libcups2-dev libcupsfilters-dev libppd-dev \
    libavahi-common-dev libavahi-client-dev libavahi-glib-dev libdbus-1-dev libglib2.0-dev \
    pkg-config gettext autopoint && \
    rm -rf /var/lib/apt/lists/*

# Clone cups-browsed source
RUN git clone --depth 1 https://github.com/OpenPrinting/cups-browsed.git $SRC/cups-browsed

# Copy build script and fuzzer folder
COPY build.sh $SRC/
COPY fuzzer/ $SRC/cups-browsed/fuzzer/

# Set working directory
WORKDIR $SRC/cups-browsed