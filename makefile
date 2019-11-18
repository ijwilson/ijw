# Note that make clean must bew run before any other compilations

files = gsl_distributions.o gsl_tests.o newio.o

files = gsl_distributions.o newio.o

CFLAGS       = -fPIC -g #-pedantic -Wall -Wextra -ggdb3
CXXFLAGS     =  -fPIC
LDFLAGS      = -shared
GSLLDFLAGS= $(shell gsl-config --libs)

all:	 libijwr.so


libijwr.so: $(files)
	$(CXX) $(LDFLAGS) $(files) -o libijwr $(GSLLDFLAGS)

test:	libijwr.so gsl_tests.o
	$(CXX) gsl_tests.o -o test $(GSLLDFLAGS) -lijwr 

testoptions: options.o testoptions.o 
	$(CXX) options.o testoptions.o  -o testoptions  -lijwr  -L/home/nijw/lib

clean:
	rm -f *.o test


options.o: options.cpp options.h
testoptions.o: testoptions.cpp options.h