TEMPLATE          = app
win32:TEMPLATE    = vcapp
CONFIG           += c++11 exceptions largefile rtti static stl warn_on
CONFIG           -= app_bundle
macx:DEFINES     += QT_MAC_USE_COCOA=1
TARGET            = Build/ExtractDebugInfo
macx {
  DESTDIR         = Build
  TARGET          = ExtractDebugInfo
}
DEPENDPATH       += .
INCLUDEPATH      += . ../ ../Tuvok/Basics/3rdParty ../Tuvok
QMAKE_LIBDIR     += ../Tuvok/Build ../Tuvok/IO/expressions
LIBS              = -lTuvok -ltuvokexpr
QT               += opengl
unix:LIBS        += -lz
win32:LIBS       += shlwapi.lib

include(../Tuvok/flags.pro)

# Find the location of QtGui's prl file, and include it here so we can look at
# the QMAKE_PRL_CONFIG variable.
TEMP = $$[QT_INSTALL_LIBS] libQtGui.prl
PRL  = $$[QT_INSTALL_LIBS] QtGui.framework/QtGui.prl
TEMP = $$join(TEMP, "/")
PRL  = $$join(PRL, "/")
exists($$TEMP) {
  include($$TEMP)
}
exists($$PRL) {
  include($$PRL)
}

### Should we link Qt statically or as a shared lib?
# If the PRL config contains the `shared' configuration, then the installed
# Qt is shared.  In that case, disable the image plugins.
contains(QMAKE_PRL_CONFIG, shared) {
  QTPLUGIN -= qgif qjpeg qtiff
} else {
  QTPLUGIN += qgif qjpeg qtiff
}

# Input

SOURCES += main.cpp
