* Tests for preprocessor variable scoping (#define, #redefine, #globaldefine)

*--#[ Scoping_Simple_Define :
    #procedure test()
        #define localvar "local"
    #endprocedure
    #call test()
    Local F = 0;
    #ifdef `localvar'
        Local F = 1;
    #endif
    Print;
    .end
    assert succeeded?
    assert result("F") =~ expr("0")
*--#] Scoping_Simple_Define :

*--#[ Scoping_GlobalDefine :
    #procedure test()
        #globaldefine globalvar "global"
    #endprocedure
    #call test()
    Local F = 0;
    #ifdef `globalvar'
        Local F = 1;
    #endif
    Print;
    .end
    assert succeeded?
    assert result("F") =~ expr("1")
*--#] Scoping_GlobalDefine :

*--#[ Scoping_Redefine_Global :
    #define var "outer"
    #procedure test()
        #redefine var "inner"
    #endprocedure
    #call test()
    Symbols x, outer, inner;
    Local F = x*`var';
    Print;
    .end
    assert succeeded?
    assert result("F") =~ expr("x*inner")
*--#] Scoping_Redefine_Global :

*--#[ Scoping_Redefine_Local :
    #procedure test()
        #redefine var "inner"
    #endprocedure
    #call test()
    Local F = 0;
    #ifdef `var'
        Local F = 1;
    #endif
    Print;
    .end
    assert succeeded?
    assert result("F") =~ expr("0")
*--#] Scoping_Redefine_Local :

*--#[ Scoping_Nested_GlobalDefine :
    #procedure nested()
        #globaldefine nestedvar "nested"
    #endprocedure
    #procedure outer()
        #call nested()
    #endprocedure
    #call outer()
    Local F = 0;
    #ifdef `nestedvar'
        Local F = 1;
    #endif
    Print;
    .end
    assert succeeded?
    assert result("F") =~ expr("1")
*--#] Scoping_Nested_GlobalDefine :

*--#[ Scoping_Shadowing :
    #globaldefine var "global"
    #procedure test()
        #define var "local"
        #message Inside: `var'
    #endprocedure
    #call test()
    Symbols x, global, local;
    Local F = x*`var';
    Print;
    .end
    assert succeeded?
    assert result("F") =~ expr("x*global")
*--#] Scoping_Shadowing :

*--#[ Scoping_GlobalDefine_Shadowed :
    #procedure test()
        #define var "local"
        #globaldefine var "global"
    #endprocedure
    #call test()
    Symbols x, global, local;
    Local F = x*`var';
    Print;
    .end
    assert succeeded?
    assert result("F") =~ expr("x*global")
*--#] Scoping_GlobalDefine_Shadowed :

*--#[ Scoping_GlobalDefine_Reallocate_Redefine :
    #procedure test()
        #ifndef `allTensors'
            #globaldefine allTensors "A"
        #else
            #redefine allTensors "`allTensors',AFieldStrength"
        #endif
    #endprocedure

    #procedure outer()
        #call test()
        #call test()
    #endprocedure

    #call outer()
    
    Symbols x, A, AFieldStrength;
    Local F = x*`allTensors';
    Print;
    .end
    assert succeeded?
    assert result("F") =~ expr("x*A*AFieldStrength")
*--#] Scoping_GlobalDefine_Reallocate_Redefine :

*--#[ Scoping_GlobalDefine_Loop :
    #procedure test()
        #do i = 1,1
            #globaldefine loopglobalvar "survived"
        #enddo
    #endprocedure
    #call test()
    Local F = 0;
    #ifdef `loopglobalvar'
        Local F = 1;
    #endif
    Print;
    .end
    assert succeeded?
    assert result("F") =~ expr("1")
*--#] Scoping_GlobalDefine_Loop :
