#include "gdcpptest.h"

using namespace godot;

void GDCppTest::_register_methods() {
    register_method("_process", &GDCppTest::_process);
    register_signal<GDCppTest>((char *)"ping");
}

GDCppTest::GDCppTest() {
}

GDCppTest::~GDCppTest() {
    // add your cleanup here
}

void GDCppTest::_init() {
    // initialize any variables here
    time_passed = 0.0;
}

void GDCppTest::_process(float delta) {
    time_passed += delta;
    if(time_passed > 2.0) {
        emit_signal("ping");
        time_passed = 0.0;
    }
}
