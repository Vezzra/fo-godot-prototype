#ifndef GDCPPTEST_H
#define GDCPPTEST_H

#include <Godot.hpp>
#include <Node.hpp>

namespace godot {

class GDCppTest : public Node {
    GODOT_CLASS(GDCppTest, Node)

private:
    float time_passed;

public:
    static void _register_methods();

    GDCppTest();
    ~GDCppTest();

    void _init(); // our initializer called by Godot

    void _process(float delta);
};

}

#endif