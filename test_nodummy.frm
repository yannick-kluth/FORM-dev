Index i,j,k;
Vector v1,v2;
CF f,g;
L F1 = f(i,j) * g(j,k);
L F2 = v1(i) * v2(i);
Sum i,j,k;

Print "--- Standard Output ---";
Print;
.sort

Print "--- nodummy (default) ---";
Format nodummy;
Print;
.sort

Print "--- nodummy(idx) ---";
Format nodummy(k);
Print;
.sort

Print "--- back to normal ---";
Format normal;
Print;
.end
