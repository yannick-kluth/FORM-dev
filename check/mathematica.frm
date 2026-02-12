#ifndef `TEST'
  #message Use -D TEST=XXX
  #terminate
#else
  #include `NAME_' # `TEST'
#endif
.end

*--#[ math_basic :
* Test: Basic Mathematica Formatting
On HighFirst;
Off Statistics;
Format Mathematica;
Symbol x,y;
L F = (x+y)^2;
Print +s F;
.end
assert succeeded?
assert result("F") =~ expr("(+x^2+2*x*y+y^2)")
*--#] math_basic :

*--#[ math_dotproduct :
* Test: DotProduct brackets should be (a.b) not [a.b]
On HighFirst;
Off Statistics;
Format Mathematica;
Vector v,w;
L F = v.w;
Print +s F;
.end
assert succeeded?
assert result("F") =~ expr("(+(v.w))")
*--#] math_dotproduct :

*--#[ math_kronecker :
* Test: KroneckerDelta output
On HighFirst;
Off Statistics;
Format Mathematica;
Index i,j;
L F = d_(i,j);
Print +s F;
.end
assert succeeded?
assert result("F") =~ expr("(+KroneckerDelta[i,j])")
*--#] math_kronecker :

*--#[ math_sumindex :
* Test: Summation index should be sumindex not _?
On HighFirst;
Off Statistics;
Format Mathematica;
Function f;
Index i,j,k;
L F = f(i,j)*d_(j,k);
Sum j;
Print +s F;
.end
assert succeeded?
assert result("F") =~ expr("(+f[i,k])")
*--#] math_sumindex :

*--#[ math_sumindex_explicit :
* Test: Explicit verification of sumindex formatting
* We need to see if a contracted index inside a function argument uses 'sumindex' 
* instead of the internal N1_? representation when printed.
On HighFirst;
Off Statistics;
Format Mathematica;
Function f;
Index i;
L G = f(i)*f(i);
Sum i;
Print +s G;
.end
assert succeeded?
assert result("G") == "(+f[N1sumindex]*f[N1sumindex])"
*--#] math_sumindex_explicit :

*--#[ math_sqrt_power :
* Test: Sqrt and Power formatting from internal functions
On HighFirst;
Off Statistics;
Format Mathematica;
Symbol x,y,n;
* Test explicit sqrt_ function
L F1 = sqrt_(x+y);
* Test explicit root_ function (nth root)
L F2 = root_(n, x+y);
Print +s F1, F2;
.end
assert succeeded?
assert result("F1") =~ expr("(+Sqrt[x + y])")
assert result("F2") =~ expr("(+Power[x + y,1/(n)])")
*--#] math_sqrt_power :
