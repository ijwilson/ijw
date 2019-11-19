# Note that make clean must be run before any other compilations

files = gsl_distributions.o gsl_tests.o newio.o
files = gsl_distributions.o newio.o

CFLAGS       = -fPIC -g -pedantic -Wall -Wextra -ggdb3
CXXFLAGS     = -fPIC -Wall -Werror -fpic
LDFLAGS      = -shared 
GSLLDFLAGS= $(shell gsl-config --libs)

all:	 libijwr.so test testoptions


libijwr.so: $(files)
	$(CXX) $(LDFLAGS) $(files) -o libijwr.so $(GSLLDFLAGS)

test:	libijwr.so gsl_tests.o
	$(CXX) gsl_tests.o -Wl,-rpath=/home/nijw/include/ijw -o test $(GSLLDFLAGS) -lijwr -L/home/nijw/include/ijw

testoptions: options.o testoptions.o 
	$(CXX) -Wl,-rpath=/home/nijw/include/ijw options.o testoptions.o  -o testoptions  -lijwr  $(shell gsl-config --libs)  -L/home/nijw/include/ijw

clean:
	rm -f *.o test libijwr.so testoptions

options.o: options.cpp options.h
testoptions.o: testoptions.cpp options.h
