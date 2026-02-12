* Tests for list support in the preprocessor

*--#[ List_Indexing_1 :
    Symbols a, b, c, d;
    #define mylist "a, b, c, d"
    Local F1 = `mylist[1]';
    Local F2 = `mylist[3]';
    Local F4 = `mylist[4]';
    Print;
    .end
    assert succeeded?
    assert result("F1") =~ expr("a")
    assert result("F2") =~ expr("c")
    assert result("F4") =~ expr("d")
*--#] List_Indexing_1 :

*--#[ List_Indexing_OOB :
    Symbols a, b;
    #define mylist "a, b"
    Local F0 = `mylist[0]';
    Local F3 = `mylist[3]';
    Print;
    .end
    assert succeeded?
    assert result("F0") =~ expr("2")
    assert result("F3") =~ expr("0")
*--#] List_Indexing_OOB :

*--#[ List_Slicing_1 :
    Symbols a, b, c, d, e;
    CF fun;
    #define mylist "a, b, c, d, e"
    Local F1 = fun(`mylist[1:3]');
    Local F2 = fun(`mylist[2:4]');
    Local F3 = fun(`mylist[3:]');
    Local F4 = fun(`mylist[:2]');
    Print;
    .end
    assert succeeded?
    assert result("F1") =~ expr("fun(a, b, c)")
    assert result("F2") =~ expr("fun(b, c, d)")
    assert result("F3") =~ expr("fun(c, d, e)")
    assert result("F4") =~ expr("fun(a, b)")
*--#] List_Slicing_1 :

*--#[ List_Slicing_Fix :
    Symbols a, b, c;
    #define mylist "a, b, c"
    Local F = `mylist[3:1]';
    Print;
    .end
    assert succeeded?
    assert result("F") =~ expr("0")
*--#] List_Slicing_Fix :

*--#[ List_Length :
    Symbols a, b, c;
    #define empty ""
    #define single "a"
    #define multi "a, b, c"
    Local L0 = `empty[0]';
    Local L1 = `single[0]';
    Local L3 = `multi[0]';
    Print;
    .end
    assert succeeded?
    assert result("L0") =~ expr("0")
    assert result("L1") =~ expr("1")
    assert result("L3") =~ expr("3")
*--#] List_Length :

*--#[ List_Containment :
    Symbols alpha, beta, gamma, delta;
    #define mylist "alpha, beta, gamma, delta"
    Local C1 = `mylist[?beta]';
    Local C2 = `mylist[?omega]';
    Print;
    .end
    assert succeeded?
    assert result("C1") =~ expr("2")
    assert result("C2") =~ expr("0")
*--#] List_Containment :

*--#[ List_String_Replace :
    Symbols foo, bar, baz, qux;
    #define mystr "foo/bar/baz"
    Local R1 = `mystr[s/bar/qux/]';
    Local R2 = `mystr[s!/!-!]';
    Print;
    .end
    assert succeeded?
    assert result("R1") =~ expr("foo*baz^-1*qux^-1")
    assert result("R2") =~ expr("- baz - bar + foo")
*--#] List_String_Replace :

*--#[ List_Bracket_Awareness :
    Symbols a, b, x, y, [1, 2];
    CFunctions fun;
    #define mylist "fun(a,b), [1,2]"
    Local E1 = `mylist[1]';
    Local E2 = `mylist[2]';
    Print;
    .end
    assert succeeded?
    assert result("E1") =~ expr("fun(a,b)")
    assert result("E2") =~ expr("[1,2]")
*--#] List_Bracket_Awareness :
