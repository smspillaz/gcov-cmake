from conans import ConanFile
from conans.tools import download, unzip
import os

VERSION = "0.0.2"


class GCovCMake(ConanFile):
    name = "gcov-cmake"
    version = os.environ.get("CONAN_VERSION_OVERRIDE", VERSION)
    requires = ("cmake-include-guard/master@smspillaz/cmake-include-guard", )
    generators = "cmake"
    url = "http://github.com/polysquare/gcov-cmake"
    licence = "MIT"

    def source(self):
        zip_name = "gcov-cmake.zip"
        download("https://github.com/polysquare/"
                 "gcov-cmake/archive/{version}.zip"
                 "".format(version="v" + VERSION),
                 zip_name)
        unzip(zip_name)
        os.unlink(zip_name)

    def package(self):
        self.copy(pattern="*.cmake",
                  dst="cmake/gcov-cmake",
                  src="gcov-cmake-" + VERSION,
                  keep_path=True)
