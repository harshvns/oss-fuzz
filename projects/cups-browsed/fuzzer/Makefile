TARGETS = fuzz_cups_browsed

INCDIR = -I.. -I/usr/include/cups -I/usr/local/include
LIBDIR = -L../src/.libs -L/usr/lib -L/usr/local/lib

BUILD_FLAGS = -g -O0
LINK_FLAGS = -Wl,--allow-multiple-definition -lppd -lcupsfilters -lcups -lavahi-client -lavahi-glib -ldbus-1 -lglib-2.0 -ljpeg -lz -ldl

all: $(TARGETS)

clean:
	rm -f *.o $(TARGETS)

fuzz_cups_browsed.o:
	$(CXX) $(CXXFLAGS) $(INCDIR) $(BUILD_FLAGS) -c -o fuzz_cups_browsed.o fuzz_cups_browsed.cc

fuzz_cups_browsed: fuzz_cups_browsed.o
	$(CXX) $(CXXFLAGS) $(LIBDIR) -fsanitize=fuzzer,address -o fuzz_cups_browsed fuzz_cups_browsed.o ../src/.libs/libcups-browsed.a $(LINK_FLAGS)

ossfuzz:
	cp $(TARGETS) $OUT