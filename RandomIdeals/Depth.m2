-- -*- coding: utf-8 -*-
--=========================================================================--
--=========================================================================--
--=========================================================================--
{*
Author: Bart Snapp. Revised in May 2016 by David Eisenbud and Branden Stone
This file is in the public domain.
*} 
newPackage(
     "Depth",
     Version => "1.0", 
     Date => "September 2010, rev May 2016",
     Authors => {
	  {Name => "Bart Snapp", 
	      Email => "snapp@math.ohio-state.edu", 
	      HomePage => "http://www.math.ohio-state.edu/~snapp/"
	      },
	  {Name => "David Eisenbud", 
	      Email => "de@msri.org",
	      HomePage => "http://www.msri.org/~de"
	  },
	  {Name => "Branden Stone", 
	      Email => "bstone@adelphi.edu",
	      HomePage => "http://math.adelphi.edu/~bstone/"
	  }
	  },
     Headline => "aids in computations related to depth",
     DebuggingMode => false
     )

--=========================================================================--
     
export{
    "systemOfParameters",
    "regularSequenceCheck",
    "isRegularSequence",
    "inhomogeneousSystemOfParameters",
    "isCM",
    "Sparseness",
    "Bound",
    "Attempts",
    "Maximal"
    } 
        
--=========================================================================--

-- Depreciated Code (Branden Stone)
-- All this does is check where the ext modules don't vanish.
--depth(Ideal,Module) := ZZ => (I,M) -> (
--     AI := (ring I)^1/I;
--     for i from 0 to dim ring M do(
--	  if Ext^i(AI,M) != 0 then return i); 
--     infinity
--     )

depth(Ideal,Module) := ZZ => (J,M) -> (
      
     R := ring J;
     
     if not isCommutative R then error "'Depth' not implemented yet for noncommutative rings.";
     if R =!= ring M then error "expected modules over the same ring";    
    
     -- Checks dimension of M
     if dim M === 0 then  return 0;
     -- Checks if M is a rank one free module over polynomial ring
     if (R^1 === M and isPolynomialRing R and isField coefficientRing R) then return codim J;
     -- Checks if J is maximal ideal
--     if (ideal vars R) === J then return depth M;
     -- Checks if J is primary to maximal ideal
     if dim J === 0 then return depth M; 
--     if dim(J + ann M) === 0 then return 0; 


     S := (flattenRing R)_0;
     pS := presentation S;
     S0 := ring pS;
     
     m := presentation M;    
     MM := coker( (presentation S ** sub(target m, S0)) |sub(m,S0));

     JJ := ideal(sub(gens J,S0)|pS);
    
     AJ := S0^1/JJ;
     d := dim MM;

     complete resolution(AJ,LengthLimit=>d);

     s := scan(0..(d-1), i -> ( 
--	    print i;
	    if Ext^i(AJ,MM) != 0 then break i;    
	    )
	);
    
     if s =!= null then return s else return d
     )
///
restart
loadPackage("Depth", Reload => true)
S = ZZ/101[x_1..x_(9)];
coefficientRing S
J = ideal vars S;
M = S/J^5;
coefficientRing M
time depth(J,S)
///     



///
--------------------------------------------------------
-- New Methods in Depth.m2
-- * depth M
-- * dIM(J,M), soon to be new depth(J,M)
-- * systemOfParameters
--
-- todo: ?give timed check for random NZD for dim 1?
--       make work for modules over quotients (tonight)
--
restart
--uninstallPackage "Depth"
loadPackage("Depth", Reload => true)
S = ZZ/101[x_1..x_(9)];
J = ideal vars S;
M = S^1/J^5;

time depth(J,M) -- used 87.7697 seconds
time depth M 
time dIM(J,M)
time dim M

restart
loadPackage("Depth", Reload => true)
    	    
S = ZZ/101[x_1..x_(9)]
I = minors(2, genericMatrix(S,x_1,3,3))
M = S^1/I;
J = (ideal vars S)^1;

time depth(J,M) -- used 3.24255 seconds with J = (ideal vars S)^1;
time depth M 

restart
loadPackage("Depth", Reload => true)

S = ZZ/101[x_1..x_(9)]
I = minors(2, genericMatrix(S,x_1,3,3))
M = S^1/I;
J = (ideal vars S)^2;

time depth(J,M) -- used 308.183 seconds with J = (ideal vars S)^2;

restart
loadPackage("Depth", Reload => true)

S = ZZ/101[x_1..x_(15)]
I = minors(3, genericMatrix(S,x_1,3,5))
M = (S/I)^1;
J = (ideal vars (S/I))^2;
ring J === ring M
(ideal vars ring M) === J

time depth M
time depth(J,M) -- bad

restart
loadPackage("Depth", Reload => true)

S = ZZ/101[x,y,z,w]
I = minors(2, matrix{{x,y,z},{y,z,w}} )
SS = S/I
M = (SS)^1;
J = apply( 4, i -> (depth( ideal(vars SS)_(toList(0..i)), M )))
J = apply( 4, i -> (dIM( ideal(vars SS)_(toList(0..i)), M )))

restart
loadPackage("Depth", Reload => true)

S = ZZ/101[x_1..x_(16)]
I = minors(4, genericMatrix(S,x_1,4,4))
R = S/I;
J = minors(2, genericMatrix(R,x_1,4,4))
M = R^1/minors(3, genericMatrix(R,x_1,4,4));

ring J === ring M
(ideal vars ring M) === J

time depth M
time depth(J,M) -- bad

time depth(ideal vars S, S^1)

------------------------------
-- systemOfParameters
--
restart
loadPackage("Depth", Reload => true)

S = ZZ/101[a,b,c]
I = ideal"cb,b2,ab,a2"
codim I 

inhomogeneousSystemOfParameters(I,S) -- original method (still works)
systemOfParameters(codim I, I)
systemOfParameters(codim I, I, Density => 1, Attempts =>2)

I = ideal"cb,b2,a2"
systemOfParameters(1,I)

I = ideal"ab,ac,bc"
systemOfParameters(codim I, I)
systemOfParameters(I, Attempts => 1, Density => .01)
time systemOfParameters(I, Attempts => 10000, Density => .01)     

n=5;m=2;     
S = ZZ/101[vars(0..n-1)]
I = ideal apply ( numgens S, j-> (
	product flatten( (for k to j-1 list S_k)| (for k from j+1 to numgens S-1 list S_k))
	)
    )
systemOfParameters(I, Density => .2,  Attempts => 1000)

L = toList(0..n-1)
subs = subsets(L,m)
I = ideal(apply(subs, p -> product(p, i-> S_i)))
     systemOfParameters(I, Density => .2,  Attempts => 1000, Verbose => true)
     systemOfParameters(I, Verbose =>true)


///
-----------------------------------------------------------------------------

depth(Module) := ZZ => M -> (
    --depth of a module with respect to the max ideal, via finite proj dim
    --gives error if the ultimate coeficient ring of R = ring M is not a field.
    
    if dim M === 0 then  return 0; -- quick test for depth 0
    
    R := ring M;
    S := (flattenRing R)_0;
    
    if not isCommutative R then error"depth undefined for noncommutative rings";
    if not isField coefficientRing S then error"input must be a module over an affine ring";
    
    S0 := ring presentation S;
        
    m := presentation M;    
    mm := (presentation S ** sub(target m, S0)) |sub(m,S0);
    numgens S0 - length res coker mm
     )    

///
restart
loadPackage("Depth", Reload =>true)

T = ZZ/101[a,b,c]
keys T
J = ideal "a2,b4"
M = (T/ideal vars T)^1
depth M
///
-----------------------------------------------------------------------------

depth(Ideal,Ring) := ZZ => (I,A) -> (
     depth(I,module A)
     )

-----------------------------------------------------------------------------

depth(Ideal,QuotientRing) := ZZ => (I,A) -> (
     R := ambient A;
     if isField coefficientRing A and isPolynomialRing R and I == ideal gens A and isHomogeneous ideal A then (
	  d := dim R;
	  d - length res(ideal A, LengthLimit => d)) else 
     depth(I,module A)
     )

-----------------------------------------------------------------------------

depth(Ring) := ZZ => A -> depth(A^1)

-----------------------------------------------------------------------------

depth(Ideal,Ideal) := ZZ => (I,A) -> (
     depth(I,module A)
     )

-----------------------------------------------------------------------------

-- Depreciated Code (Branden Stone)
--depth(Ideal,PolynomialRing) := ZZ => (I,A) -> (
--     if isField coefficientRing A then codim I else depth(I,module A)
--     ) -- if we can compute dimensions over ZZ, then we can remove this if-then statement

-----------------------------------------------------------------------------



--=========================================================================--

regularSequenceCheck = method()
regularSequenceCheck(List, Module) := ZZ => (X,M) -> (
     X = splice X;
     for i from 0 to #X-1 do (
     	  f := X_i * id_M;
     	  if not isInjective f
     	  then return i else M = coker f);
     #X)

-----------------------------------------------------------------------------

-----------------------------------------------------------------------------

regularSequenceCheck(List, Ring) := ZZ => (X,A) -> (
     regularSequenceCheck(X,A^1)
     )

-----------------------------------------------------------------------------

regularSequenceCheck(Matrix, Module) := ZZ => (X,M) -> (
     regularSequenceCheck(flatten entries X,M)
     )

-----------------------------------------------------------------------------

regularSequenceCheck(Matrix, Ring) := ZZ => (X,A) -> (
     regularSequenceCheck(flatten entries X,A)
     )

--=========================================================================--

isRegularSequence = method()
isRegularSequence(List, Module) := Boolean => (X,M) -> (
     if isHomogeneous matrix{X} and isHomogeneous M then (
	  g := reduceHilbert hilbertSeries M;
     	  f := reduceHilbert hilbertSeries (M/ideal X);
	  if numerator f == 0 then return false;
     	  R := degreesRing M; 
     	  T := R_0;
     	  numerator f * value denominator g == (value denominator f) * product(X,i-> (1-T^(first degree i))) * numerator g
	  ) 
     else 
     regularSequenceCheck(X,M) == #splice(X) and ideal(X)*M != M
     )

-- this routine actually consists of 2 tests. In the homogeneous case,
-- we use an exercise from Eisenbud's book "Commutative algebra with a
-- view toward Algebraic Geometry." See p. 555. Otherwise the routine
-- is rather naive.

-----------------------------------------------------------------------------

--isRegularSequence(Sequence, Module) := Boolean => (X,M) -> isRegularSequence(toList X,M)

-----------------------------------------------------------------------------

isRegularSequence(Matrix, Module) := Boolean => (X,M) -> isRegularSequence(flatten entries X,M)

-----------------------------------------------------------------------------

isRegularSequence(List, Ring) := Boolean => (X,A) -> isRegularSequence(X,A^1)

-----------------------------------------------------------------------------

--isRegularSequence(Sequence, Ring) := Boolean => (X,A) -> isRegularSequence(toList X,A^1)

-----------------------------------------------------------------------------

isRegularSequence(Matrix, Ring) := Boolean => (X,A) -> isRegularSequence(X,A^1)

-----------------------------------------------------------------------------

isRegularSequence(List) := Boolean => X -> isRegularSequence(X,ring(X_0))

-----------------------------------------------------------------------------

isRegularSequence(Matrix) := Boolean => X -> isRegularSequence(X,ring X)

--=========================================================================--

inhomogeneousSystemOfParameters = method(Options => {Sparseness => .5, Bound => 1, Attempts => 100, Maximal => true})
inhomogeneousSystemOfParameters(Ideal,Ring) := Matrix => opts -> (I,A) -> (
     k := coefficientRing A;
     f := gens I;
     r := numColumns f;
     c := codim I;
     if c == infinity then return map(A^1,A^0,0);
     PHI := 0;
     longestSeq := 0;
     for i from 0 to opts.Attempts do (
	  phi := matrix randomMutableMatrix(r,c,opts.Sparseness,opts.Bound);
	  rcs := regularSequenceCheck(compress(f*phi),A);
	  if rcs == c then return f*phi; 
	  if not opts.Maximal then if rcs > longestSeq then (
	       PHI = phi;
	       longestSeq = rcs;
	       );
	  );
     if PHI == 0 then << "--warning: no maximal regular sequence found" <<endl;
     compress(f*PHI)
     )


TEST /// 
A = ZZ/5051[x, y, z];
I = ideal (x, x*y, y*z);
-- the success of this test depends on the random number generator:
setRandomSeed()
assert(inhomogeneousSystemOfParameters(I,A,Bound=>100,Sparseness=>.9) - matrix {{90*y*z-2*x, -71*y*z+38*x}}==0)
///

-----------------------------------------------------------------------------

inhomogeneousSystemOfParameters(Ring) := Matrix => opts -> A -> inhomogeneousSystemOfParameters(ideal gens A,A)
inhomogeneousSystemOfParameters(Ideal) := Matrix => opts -> I -> inhomogeneousSystemOfParameters(I,ring I)

	       
--=========================================================================--

isCM = method()
isCM(Ring) := Boolean => (A) -> (
     dim(A) == depth(A) -- note we should *not* switch to modules - see depth(Ideal,QuotientRing)
     )

-----------------------------------------------------------------------------

isCM(Module) := Boolean => (M) -> (
     dim(M) == depth(M)
     )

--=========================================================================--
--=========================================================================--

systemOfParameters = method(Options => {Density => 0, Attempts => 100, Verbose => false})
systemOfParameters(ZZ,Ideal) := opts -> (c,I) ->(
den := opts.Density;
att := opts.Attempts;
if numgens I == c then return I;
    --takes care of I = 0 and I principal;
sgens := sort (gens trim I, DegreeOrder => Ascending, MonomialOrder => Descending);
if den == 0 then den = ((1+c)/(numcols sgens));
if opts.Verbose == true then <<"Attempts: "<<att<<" Density: "<< den<<endl;
n :=numcols sgens;
J := ideal sgens_{0};
if c == 1 then return J;
K := J;
c' := 1;
c'' := c;
for i from 1 to n-1 do(
    c'' = codim(K = J + ideal(sgens_{i}));
    if c''>c' then (
        J = K;
	c' = c''));
if c' == c then return J;
scan(att, j->(
rgens := sgens * random(source sgens, source sgens, Density => 1.0*den);
for i from 0 to n-1 do(
    c'' = codim(K = J + ideal(rgens_{i}));
    if c''>c' then(
        J = K;
	c' = c'';
	if c' == c then break c'));
if c'==c then break
if opts.Verbose == true then print j));
if numgens J !=c then error "no regular sequence found; try increasing Density or Attempts options";
J)


systemOfParameters Ideal := opts -> I -> 
                             systemOfParameters(codim I, I,
			     Density => opts.Density, 
			     Attempts => opts.Attempts,
			     Verbose => opts.Verbose)




///
uninstallPackage "Depth"
restart
notify = true
installPackage "Depth"
loadPackage ("Depth", Reload=>true)
S = ZZ/101[a,b,c]
I = ideal"cb,b2,ab,a2"
codim I 
systemOfParameters(codim I, I)
systemOfParameters(codim I, I, Density => 1, Attempts =>2)
viewHelp Depth
     I = ideal"cb,b2,a2"
     systemOfParameters(1,I)
     I = ideal"ab,ac,bc"
     systemOfParameters(codim I, I)
     systemOfParameters(I, Attempts => 1, Density => .01)
     systemOfParameters(I, Attempts => 10000, Density => .01)     
n=5;m=2;     
S = ZZ/101[vars(0..n-1)]
     I = ideal apply(numgens S, 
	 j-> product flatten( (for k to j-1 list S_k)| (for k from j+1 to numgens S-1 list S_k)))
     systemOfParameters(I, Density => .2,  Attempts => 1000)
L = toList(0..n-1)
subs = subsets(L,m)
I = ideal(apply(subs, p -> product(p, i-> S_i)))
     systemOfParameters(I, Density => .2,  Attempts => 1000, Verbose => true)
     systemOfParameters(I, Verbose =>true)
///
--=========================================================================--
--=========================================================================--

beginDocumentation() -- the start of the documentation

-----------------------------------------------------------------------------

doc ///
   Key
    Depth
   Headline
    Finds depth of a module and regular sequences in an ideal
   Description
    Text
     The depth of an ideal on a module is a fundamental invariant, a kind
     of arithmetic version of codimension. In many local or graded cases one is interested
     in the depth of the maximal ideal on the module, and then we speak just of the 
     depth of the module (or, when the module is the ring itself, the depth of the ring.)
     Over a regular ring, depth is most efficiently computed using the Auslander-Buchsbaum
     formula depth M = dim R - pdim M, where pdim is the projective dimension. In general,
     depth(I,M) = min {i | Ext^i(R/I,M) != 0}. Both these methods are incorporated.
     
     The depth of I on M is also the length of a maximal regular sequence on M contained in
     I. The other routines in this package try probabilistically to find regular 
     sequences in an ideal; in a regular or Cohen-Macaulay ring, the length of
     such a sequence is equal to the codimension of the ideal, so
     (inhomogeneousSystemOfParameters,Ideal) and (systemOfParameters, Ideal), without
     further arguments, look for regular sequences of length codim I.  
     
     To find such sequences, one can simply take an appropriate number of
     random linear combinations of the generators of the ideal. Since being a regular
     sequence is a matter of certain elements not being in certain prime ideals, this
     succeeds with very high probability over any field of reasonable size. But it 
     produces inhomogeneous generators. For many applications, when the ideal is
     homogeneous, a homogeneous regular sequence is needed; this is provided, again
     probabilistically, by the routine systemOfParameters.
    Example
     S = ZZ/101[a,b,c,d]
     K = koszul vars S
     apply(numgens S, i-> depth coker K.dd_(i+1))

     I = ideal"ab,bc,cd,da"
     codim I
     setRandomSeed 0
     inhomogeneousSystemOfParameters I
     systemOfParameters 
     systemOfParameters(I, Density => .1, Attempts => 1000, Verbose => true)
   Caveat
    The systemOfParameters code could be improved by working one degree at a time,
    using a knowledge of the codim of the ideal generated by elements of degrees <=d 
    for each d.
   SeeAlso
    depth
    inhomogeneousSystemOfParameters
    systemOfParameters
///

------------------------------------------------------------
-- DOCUMENTATION systemOfParameters
------------------------------------------------------------
doc ///
   Key
    systemOfParameters
    (systemOfParameters, Ideal)
    (systemOfParameters, ZZ, Ideal)
    [systemOfParameters,Attempts]
    [systemOfParameters,Density]
    [systemOfParameters,Verbose]        
   Headline
    finds a relatively sparse homogeneous regular sequence of minimal degree in an ideal
   Usage
    J = systemOfParameters I
    J = systemOfParameters (i,I)
   Inputs
    I:Ideal
    i:ZZ
    Verbose => Boolean
    Attempts => ZZ
    Density => RR
     or QQ or ZZ; will be converted to RR
   Outputs
    J:Ideal
     generated by a regular sequence of length i
   Description
    Text
     First sorts the generators of trim I by ascending degree, ascending monomial
     order. Looks first for as much of a regular sequence among the generators as possible,
     then tries up to Attempts sparse random combinations of given Density.
     The defaut valuse of Density is (1+codim I)/(numgens trim I).
    Example
     S = ZZ/101[a,b,c,d]
     I = ideal"ab,bc,cd,da"
     codim I
     setRandomSeed 0
     inhomogeneousSystemOfParameters I
     systemOfParameters I
     systemOfParameters(I, Density => .1, Attempts => 1000, Verbose => true)
   Caveat
    could be rewritten to take into account the codimensions of the sub ideals generated
    by the elements of degree up to d for each d.
   SeeAlso
    regularSequenceCheck
    Depth
    inhomogeneousSystemOfParameters
///


-----------------------------------------------------------------------------

document {
     Key => {
	  (depth, Ideal, Ring),
	  (depth, Ring),
	  (depth, Ideal, Module),
	  (depth, Module),
	  (depth, Ideal, Ideal),
	  (depth, Ideal, PolynomialRing),
	  (depth, Ideal, QuotientRing)
	  },
     Headline => "computes the depth of a ring",
     Usage => "depth(I,A)",
     Inputs => {
	  "I" => {},
	  "A" => {}
	  },
     Outputs => {
	  ZZ => {"the ", TT "I", "-depth of a ring"}
	  },
          "The function ", TT "depth(I,A)", ", computes the ", TT "I",
"-depth of a ring. In the most general setting, it does this by computing ", 
TT "Ext^i(A^1/I,A)", " and noting where it does not vanish. 
 If the ring in 
question is a polynomial ring over a field, then it merely computes the codimension of ", TT "I", 
". If the ring in question is a quotient of a polynomial ring over a field and we are computing 
the depth over the ideal generated by  ", TO (gens, Ring), ", then it computes the 
difference between the dimension of this polynomial ring and the projective dimension of the 
quotient ring. If the ideal is omitted, then the depth is taken over the ideal generated by ", TO (gens, Ring), ".", 
     EXAMPLE lines ///
     A = QQ[x_1..x_3]/ideal(x_1^2, x_1*x_2);
     depth A
     ///,
     "If ", TT "I", " contains a unit, then ", TT "depth(I,A)", " outputs ", TO "infinity", ".",
     EXAMPLE lines ///
     depth(ideal(1),ZZ)
     ///,
     PARA {
     	  "This symbol is provided by the package ", TO Depth, "."
     	  }
     }	   

-----------------------------------------------------------------------------

document {
     Key => {regularSequenceCheck,  
	  (regularSequenceCheck,List,Module),
  	  (regularSequenceCheck,List,Ring),
  	  (regularSequenceCheck,Matrix,Module),
  	  (regularSequenceCheck,Matrix,Ring)
	  },
     Headline => "how much of a list is regular",
     Usage => "regularSequenceCheck(X,A)",
     Inputs => {
	  "X" => {"a ", TO "List", " or ", TO "Matrix"},
	  "A" => {"a ", TO "Ring", " or ", TO "Module"}
	  },
     Outputs => {ZZ},
     Caveat => {TT "regularSequenceCheck", " merely checks the injectivity of the maps in question. 
	  It does not check to see if ", TT "XA = A", "."},
     	  "Given a list ", TT "X", ", the function ", TT "regularSequenceCheck",
	  " gives an integer indicating how many initial elements of a ", TT "List", " form a regular sequence.",
     EXAMPLE lines ///
     A = ZZ[x_1..x_4]/(x_4^2)	  
     regularSequenceCheck({x_1..x_4},A)	    
     ///,
     PARA {
     	  "This symbol is provided by the package ", TO Depth, "."
     	  }
     }

-----------------------------------------------------------------------------

document {
     Key => {isRegularSequence,
	  (isRegularSequence,List,Ring),
  	  (isRegularSequence,Matrix,Module),
	  (isRegularSequence,List,Module),
	  (isRegularSequence,Matrix,Ring),
       	  (isRegularSequence,Matrix),
       	  (isRegularSequence,List)},
     Headline => "whether a list is regular over a ring or module",
     Usage => "isRegularSequence(X,A) or isRegularSequence(X) ",
     Inputs => {
	  "X" => {"a ", TO "List", " or ", TO "Matrix"},
	  "A" => {"a ", TO "Ring", " or ", TO "Module"}
	  },
     Outputs => {Boolean},
          "Given a list ", TT "X", ", the function ", TT "isRegularSequence", 
	  " tells if ", TT "X", " forms a regular sequence. If ", TT "X", 
	  " consists of homogeneous elements, it does this by comparing 
	  the hilbert series of ", TT "A", "
	  and the hilbert series of ", TT "A/XA", ". Otherwise it checks 
	  the injectivity of the maps defined by multiplication
	  by the elements of ", TT "X", " and also checks if ", TT "XA
	  = A", ".",
        EXAMPLE lines ///
	A = ZZ/2[x, y, z];
	X1 = {x, y*(x-1), z*(x-1)};
	isRegularSequence X1
	X2 = {z*(x-1), y*(x-1), x};
	isRegularSequence X2
	X3 = {1_A, x, y};
	isRegularSequence X3
	///,
      	PARA {
     	     "This symbol is provided by the package ", TO Depth, "."
     	     }
     	}
-----------------------------------------------------------------------------

document {
     Key => {inhomogeneousSystemOfParameters,
	  (inhomogeneousSystemOfParameters,Ideal,Ring),
	  (inhomogeneousSystemOfParameters,Ring),
	  (inhomogeneousSystemOfParameters,Ideal),	  
	  Attempts,
	  Bound,
	  Sparseness,
	  Maximal,
	  [inhomogeneousSystemOfParameters,Attempts],
	  [inhomogeneousSystemOfParameters,Bound],
	  [inhomogeneousSystemOfParameters,Maximal],
	  [inhomogeneousSystemOfParameters,Sparseness]},
     Headline => "generates a regular sequence",
     Usage => "inhomogeneousSystemOfParameters(I,A)",
     Inputs => {
	  "I" => Ideal,
	  "A" => Ring,
	  Attempts => ZZ => "number of attempts made to generate a regular sequence",
	  Bound => ZZ => "bound on the value of the random coefficients",
	  Sparseness => RR => "between 0 and 1 giving the frequency of the coefficients being equal to zero",
	  Maximal => Boolean => "whether to insist on searching for a maximal regular sequence"
	  },
     Outputs => {Matrix},
     "Given a ring and an ideal, ", TT "inhomogeneousSystemOfParameters", " attempts
     to generate a regular sequence contained in ", TT "I", ". The
     algorithm is based on one found in Chapter 5.5 of W. Vasconcelos'
     book: ", EM "Computational Methods in Commutative Algebra and
     Algebraic Geometry", ".",
     EXAMPLE lines ///
     A = ZZ/5051[x, y, z];
     I = ideal (x, x*y, y*z);
     X = inhomogeneousSystemOfParameters(I,A)
     isRegularSequence(X,A)
     ///,
     "Here are examples with optional inputs:",
     EXAMPLE lines ///
     A = ZZ/5051[x, y, z];
     I = ideal (x, x*y, y*z);
     inhomogeneousSystemOfParameters(I,A,Attempts=>1,Bound=>100,Sparseness=>.9)
     ///,
     "Here are examples with the optional input ", TT "Maximal => false", ":",
     EXAMPLE lines ///
     x = symbol x; y = symbol y;
     n = 2;
     A = ZZ/101[x_(1,1)..x_(n,n),y_(1,1)..y_(n,n)];
     X = transpose genericMatrix(A,n,n);
     Y = transpose genericMatrix(A,y_(1,1),n,n);
     b = ideal(X*Y - Y*X);
     B = A/b;
     inhomogeneousSystemOfParameters(B,Attempts=>1,Maximal=>false)
     ///,
     PARA {
     	  "This symbol is provided by the package ", TO Depth, "."
     	  }
     }
-----------------------------------------------------------------------------

document {
     Key => {isCM,
	  (isCM,Module),
  	  (isCM,Ring)},
     Headline => "whether a ring or module is Cohen-Macaulay",
     Usage => "isCM(A)",
     Inputs => {
	  "A" => {"a ", TO "Ring", " or ", TO "Module"}
	  },
     Outputs => {TO "Boolean"},
     Caveat => {"Typically when one thinks of a Cohen-Macaulay ring or
module, one is in the local case. Since the local case is not yet
implemented into Macaulay 2, we compute over the ideal generated by by ", TO (gens, Ring), "."}, 
"This command merely checks if the depth of ", TT "A", " equals the Krull dimension of ", TT"A",".",
        EXAMPLE lines ///
	A = ZZ/2[x,y,z];
	isCM(A)
	A = ZZ/2[x,y]/(x^2,x*y);
	isCM(A)
	A =  ZZ/101[a_1,a_2,b_1,b_2,c_1]/ideal(a_1*b_1,a_2*b_2,b_1*c_1);
	isCM(A)
	///,
      PARA {
     "This symbol is provided by the package ", TO Depth, "."
     }
     }

--=========================================================================--
--=========================================================================--
--=========================================================================--
TEST /// 
A = QQ[x,y,z]/ideal(x^2)
m = ideal vars A
assert(depth(m,A) == 2)
depth(ideal(y),A)
-- we don't compute dimensions over ZZ, for now.
-- A = ZZ[x,y]
-- m = ideal vars A
-- depth(m,A)
///

TEST /// 
A = ZZ/101[x_1..x_4]
assert(regularSequenceCheck({x_1..x_4},A^1)==4)
///
TEST///
	A = ZZ/2[x,y,z];
	assert(isCM(A) == true)
	A = ZZ/2[x,y]/(x^2,x*y);
	assert(isCM(A) == false)
///
TEST///
     n = 2;
     A = ZZ/101[x_(1,1)..x_(n,n),y_(1,1)..y_(n,n)];
     X = genericMatrix(A,n,n);
     Y = genericMatrix(A,y_(1,1),n,n);
     b = ideal(X*Y - Y*X);
     B = A/b;
     setRandomSeed 0
     assert(numcols inhomogeneousSystemOfParameters(B,Attempts=>1,Maximal=>false) == 6)
     assert(depth B == dim B)
     A = ZZ/5051[x, y, z];
     I = ideal (x, x*y, y*z);
     assert (0==inhomogeneousSystemOfParameters(I,A,Attempts=>1,Bound=>100,Sparseness=>.9)- matrix {{88*y*z, -34*x}})
///
TEST///
     S = ZZ/101[a,b,c,d]
     K = koszul vars S
     apply(numgens S, i-> depth coker K.dd_(i+1))

     I = ideal"ab,bc,cd,da"
     codim I
     setRandomSeed 0
     inhomogeneousSystemOfParameters I
     systemOfParameters 
     systemOfParameters(I, Density => .1, Attempts => 1000, Verbose => true)
///
TEST///
S = QQ[a..e]
m = ideal gens S
assert(depth (S^1/m) == 0)
depth QuotientRing := A -> depth (A^1)
assert (depth (S/m) == 0)
assert(depth(S^1/m) == 0)
assert(depth( (S/m)^1) ==0)
///

end--

uninstallPackage "Depth"
restart
installPackage "Depth"
check Depth

viewHelp Depth