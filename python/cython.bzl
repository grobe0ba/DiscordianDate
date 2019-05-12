def cc_cython_binary(name, python_src, copts, linkopts):
    basename = python_src[:-len(".py")]
    native.genrule(
        name = name + "_codegen",
	tools = [],
	srcs = [ python_src ],
        cmd = "\\\n".join([
            "cython --embed-positions --line-directives --embed -2 -o $(location " + basename + ".c) $(location " + python_src + ");",
            ]),
        outs = [ basename + ".c" ],
        visibility = [ "//visibility:public" ],
    )

    native.cc_binary(
        name = name,
        srcs = [ basename + ".c" ],
	copts = [ "-I/usr/include/python2.7" ] + copts,
        linkopts = [ "-lpython2.7" ] + linkopts,
        visibility = [ "//visibility:public" ],
    )

