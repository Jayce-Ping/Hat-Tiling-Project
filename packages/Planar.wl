(* ::Package:: *)

BeginPackage["Planar`"]


{
PlanarPolygonFragmentation
}


Begin["Private`"]


(* ::Section::Initialization:: *)
(*(*code from WFR*)*)


(* ::Subsection::Initialization::Closed:: *)
(*(*coordinate transforms*)*)


(* ::Input::Initialization:: *)
LocalizeVertex[mins_,scale_,dim_
]:=Function[
Round[Together[
Plus[1,dim Divide[
#-mins,
scale]]]]
]


(* ::Input::Initialization:: *)
CartesianNeighborhood[vertex_]:=Module[
{directions={{0,0},{1,0},{0,1},{-1,0},{0,-1}}},
Map[Plus[vertex,#]&,directions]
]


(* ::Subsection::Initialization::Closed:: *)
(*(*Localization*)*)


(* ::Input::Initialization:: *)
InitializeData[0][pts1_]:=InitializeData[
Association[
"PolygonCount"->0,
"VertexCount"->0,
"IntersectionCount"->0,
"Polygons"->Association[],
"Vertices"->Association[],
"Localities"->Association[],
"Edges"->Association[],
"Adjacencies"->Association[]
]][pts1]


(* ::Input::Initialization:: *)
InitializeData[data_][pts1_]:=Module[
{nextData=data,len1,inds},
len1=Length[pts1];
inds=Range[len1]+nextData["VertexCount"];
MapThread[Set[nextData["Vertices",#1],#2]&,{inds,pts1}];
nextData["Polygons",nextData["PolygonCount"]+1]=inds;
nextData["VertexCount"]+=len1;
nextData["PolygonCount"]+=1;
Map[Set[nextData["Edges",#1],Association[]]&,inds];
Map[MapApply[Set[nextData["Edges",#1,#2],#3]&,
Partition[#1,3,1,1]]&,
{inds,Reverse[inds]}];
nextData]


(* ::Input::Initialization:: *)
AddFalseVertex[data_][key_,loc_,xy_,span_
]:=Module[{nextData=data},
Set[nextData["Vertices",key],xy];
Set[nextData["Localities",key],loc];
Set[nextData["Occupancies",loc],
Union[Lookup[nextData["Occupancies"],
Key[loc],{}],span]];
nextData
]


(* ::Input::Initialization:: *)
LocalizeOneSegment[data_
][polyKey_,span_
]:=Module[{nextData=data,
round,init,locs,newxy,newlocs,keys,
res=Association[],ind=0},
round=data["LocalizeVertex"];
init={span};
FixedPoint[Function[empties,
locs=Map[
Lookup[nextData["Localities"],#]&,
empties];
Catenate[MapThread[
Function[{empty,locpair},
Switch[
Apply[EuclideanDistance,locpair],
(* nearest *)
0|1,res[++ind]=empty;{},
(* next nearest *)
Sqrt[2],
keys=Table[Square[++nextData["VertexCount"]],2];
newlocs=Map[locpair[[Sequence@@#]]&,
{{{1,1},{2,2}},{{2,1},{1,2}}},{2}];
MapThread[Set[nextData,
AddFalseVertex[nextData
][#1,#2,Missing[],span]]&,
{keys,newlocs}
];
Map[Set[res[++ind],#]&,
Join[{empty[[1]],#}&/@keys,
{#,empty[[2]]}&/@keys]];
{},
(* not near *)
_,
newxy=Mean[
Lookup[nextData["Vertices"],empty]
];
newlocs=round[newxy];
keys=Square[++nextData["VertexCount"]];
Set[nextData,
AddFalseVertex[nextData
][keys,newlocs,newxy,span]];
{{empty[[1]],keys},{keys,empty[[2]]}}
]],
{empties,locs}]]
],init];
Set[nextData["Polygons",polyKey],
Union[Catenate[Values[res]],
nextData["Polygons",polyKey]]];
nextData
]


(* ::Input::Initialization:: *)
LocalizeOnePolygon[data_
][polyKey_,inds_]:=Module[{
nextData=data,locs,segs},
locs=Lookup[nextData["Localities"],inds];
segs=Partition[locs,2,1,1];
segs=MapApply[EuclideanDistance[#1,#2]>1&,segs];
segs=Part[Partition[inds,2,1,1],
Flatten[Position[segs,True]]];
Map[Set[nextData,
LocalizeOneSegment[nextData
][polyKey,#]]&,
segs];
(* faster here *)
locs=Lookup[nextData["Localities"],
nextData["Polygons",polyKey]];
locs=Table[#,5]&/@locs;
locs=Plus[locs,Table[
{{0,0},{1,0},{0,1},{-1,0},{0,-1}},
Length[locs]]];
Map[Set[nextData["Adjacencies",
First[#]],#]&,locs];
nextData
]


(* ::Input::Initialization:: *)
LocalizeData[data_,dim_]:=Module[
{nextData=data,minmax,scale,round},
minmax=Map[MinMax,
Transpose[Values[data["Vertices"]]]];
scale=Max[Abs[Subtract@@@minmax]];
round=LocalizeVertex[
minmax[[All,1]],scale,dim];
nextData["LocalizeVertex"]=round;
nextData["MinMax"]=Transpose[
Map[round,Transpose@minmax]];
(* speedup here by threading *)
KeyValueMap[
Set[nextData["Localities",#1],
round[#2]]&,
nextData["Vertices"]];
(* speedup here by threading *)
Set[nextData["Occupancies"],GroupBy[
Normal[nextData["Localities"]],
Last->First]];
KeyValueMap[Set[nextData,
LocalizeOnePolygon[
nextData
][#1,#2]]&,
nextData["Polygons"]];
nextData
]


(* ::Input::Initialization:: *)
ExtendFragment[edges_,points_][seq_
]:=Join[
If[MemberQ[points,#],
{#},{}
]&[
edges[Sequence@@seq[[{2,1}]]]
],
seq,
If[MemberQ[points,#],
{#},{}
]&[
edges[Sequence@@seq[[{-2,-1}]]]]
]


(* ::Input::Initialization:: *)
CriticalFragments[edges_,points_,polygon_
]:=Module[
{res,len,ind=1,init,neighbors,
remaining=points},
res=Association[];
len=Length[DeleteCases[polygon,Square[_]]];
While[UnsameQ[remaining,{}],
init=First[remaining];
neighbors=Riffle[Keys[edges[init]],{init}];
(* careful of spurious points here *)
If[Length[neighbors]<2,
res[ind]={init},
res[ind]=FixedPoint[
ExtendFragment[edges,remaining],
neighbors,len];
(* cyclic overflow error *)
If[Length[res[ind]]>len,
res[ind]=Join[First/@Most[#],Last[#]
]&[DeleteDuplicates[
Partition[res[ind],2,1]]
]]];
remaining=Complement[remaining,res[ind]];
ind++;
];
Values[res]
]


(* ::Input::Initialization:: *)
ClassifierGraph[data_]:=Module[{nextData=data,
bins,thick,criticalBins,graph},
bins=Map[Union[Lookup[data["Localities"],#]]&,
Values[data["Polygons"]]];
thick=Reverse[Map[Union[
Catenate[Lookup[data["Adjacencies"],#]]
]&,bins]];
criticalBins=Apply[Union,MapThread[
Intersection,{bins,thick}]];
graph=WeaklyConnectedComponents[
Graph[Union[Flatten[Map[Function[crit,
Map[Sort[UndirectedEdge[crit,#]]&,
Rest[Lookup[data["Adjacencies"],Key[crit],{}]
]]],criticalBins]]]]];
graph=Map[Union[Catenate[
Lookup[data["Occupancies"],#]]
]&,graph];
nextData["CriticalBins"]=criticalBins;
nextData["ClassifierGraph"]=graph;
nextData
]


(* ::Input::Initialization:: *)
ProblemSets[data_]:=Module[{
nextData=data,polyfilters,criticalPoints,criticalFrags,
fragCheck,problems},
polyfilters=Map[Association,Map[#->#&,
Values[data["Polygons"]],{2}]];
criticalPoints=Map[
Function[{filter},Map[
Lookup[filter,#,Nothing]&,
Lookup[data["Occupancies"],
nextData["CriticalBins"]]]],
polyfilters];
criticalPoints=Map[
Catenate@*Union,
criticalPoints];
criticalFrags=Catenate[Map[
CriticalFragments[
data["Edges"],
criticalPoints[[#]],
data["Polygons",#]
]&,{1,2}]];
fragCheck=Association[Catenate[
MapIndexed[Thread[#1->#2[[1]]]&,
criticalFrags]]];
fragCheck=Map[#->Lookup[fragCheck,#,Nothing]&,
nextData["ClassifierGraph"]];
fragCheck=WeaklyConnectedComponents[Graph[
fragCheck[[All,1]],If[IntersectingQ@@#[[All,-1]],
UndirectedEdge@@#[[All,1]],Nothing
]&/@Subsets[fragCheck,{2}]]];
fragCheck=MapApply[Join,
fragCheck];
problems=GroupBy[criticalFrags,
Function[frag,
IntersectingQ[frag,#]&/@fragCheck
]  ];
problems=Transpose[Function[filter,
Map[Lookup[filter,#,Nothing]&,
Values[problems],{2}]]/@polyfilters];
problems=DeleteCases[problems,{},{3}];
problems=DeleteCases[problems,{_,{}}|{{},_}];
problems=Map[Sort@*Catenate,
Map[Sort/@Partition[#,2,1]&,
problems,{3}],{2}];
nextData["ProblemSets"]=problems;
nextData
]


(* ::Subsection::Initialization::Closed:: *)
(*(*intersection solving (this can also stand alone)*)*)


(* ::Input::Initialization:: *)
ProvisionalZeroQ[expr_,cut_:2^6*$MachineEpsilon
]:=SameQ[Chop[N[expr],cut],0]


(* ::Input::Initialization:: *)
ConnectedSets[parts_]:=FixedPoint[
MapApply[Union,Gather[#,IntersectingQ]
]&,parts]


(* ::Input::Initialization:: *)
ColinearMerge[segs_,vertices_,vectors_][colinear_
]:=Module[
{inds,pts,vec1,root1,norm1,ordering,
keys,pars,repart,rev},
vec1=vectors[First[colinear]];
norm1=vec1 . vec1;
root1=vertices[First[segs[First[colinear]]]];
inds=Lookup[segs,colinear];
rev=Association[MapThread[Rule,{inds,colinear}]];
pts=Lookup[vertices,#]&/@inds;
ordering=Association[MapThread[#1->Divide[
Dot[#2-root1,vec1],norm1]&,
{Catenate[inds],Catenate[pts]}]];
ordering=Sort[ordering,NumericalOrder];
keys=Keys[ordering];
pars=Map[Sort,Map[Position[keys,#][[1,1]]&,inds,{2}]];
pars=ConnectedSets[MapApply[keys[[#1;;#2]]&,pars]];
pars=KeyDrop[ordering,Complement[keys,#]]&/@pars;
pars=Divide[#-First[#],Last[#]-First[#]]&/@pars;
repart=Map[Function[gathered,Lookup[rev,Select[inds,
SubsetQ[Keys[gathered],#]&]]],pars];
Thread[repart->pars]
]


(* ::Input::Initialization:: *)
ColinearQ[segs_,vertices_,vectors_][inds_
]:=Module[{vec,pts},
vec=Reverse[Times[{1,-1},vectors[First[inds]]]];
pts=Lookup[vertices,First/@Lookup[segs,inds]];
ProvisionalZeroQ[Apply[Subtract,# . vec&/@pts]]
]


(* ::Input::Initialization:: *)
IndexedAssociation[list_,offset_:0]:=Association[
MapIndexed[(#2[[1]]+offset)->#1&,list]
]


(* ::Input::Initialization:: *)
DotThread[vec1_,vec2_]:=Total[Transpose[Times[vec1,vec2]]]


(* ::Input::Initialization:: *)
FilterIntersectionPairs[
a1_,b1_,a2_,b2_,m1_,m2_,n1_,n2_
]:=Module[{test1,test2},
test1=Ceiling[Sign[Times[
DotThread[n1,a2-a1],
DotThread[n1,b2-a1]]
]/2];
test2=Ceiling[Sign[Times[
DotThread[n2,a1-a2],
DotThread[n2,b1-a2]]
]/2];
Flatten[Position[
MapThread[And[#1==0,#2==0]&,
{test1,test2}],
True]]
]


(* ::Input::Initialization:: *)
InitializeCaseSplit[segs_,vertices_,passKeys_
]:=Module[{vectors,keys,
v1s,v2s,n1s,n2s,test,
indsTrue,indsFalse,
a1,b1,a2,b2,
caseSplit},
vectors=MapApply[#2-#1&,Association[
KeyValueMap[#1->Lookup[vertices,#2]&,segs]
]];
keys=If[TrueQ[passKeys],
Subsets[Keys[segs],{2}],passKeys];
{v1s,v2s}=Lookup[N@vectors,#]&/@Transpose[keys];
{n1s,n2s}=Map[# . {{0,-1},{1,0}}&,{v1s,v2s}];
test=Map[ProvisionalZeroQ,DotThread[N@v1s,N@n2s]];
indsFalse=Catenate[Position[test,False]];
indsTrue=Catenate[Position[test,True]];
caseSplit=Association[];
Set[caseSplit[True],
ConnectedSets[Select[
keys[[indsTrue]],
ColinearQ[segs,vertices,vectors]]]
];
If[Length[indsFalse]==0,
Set[caseSplit[False],
{}
];
,
keys=keys[[indsFalse]];
v1s=v1s[[indsFalse]];
v2s=v2s[[indsFalse]];
n1s=n1s[[indsFalse]];
n2s=n2s[[indsFalse]];
{a1,b1}=N@Transpose[Map[
Lookup[vertices,#]&,
Lookup[segs,
First[Transpose[keys]]]]];
{a2,b2}=N@Transpose[Map[
Lookup[vertices,#]&,
Lookup[segs,
Last[Transpose[keys]]]]];
indsFalse=FilterIntersectionPairs[
a1,b1,a2,b2,v1s,v2s,n1s,n2s];
Set[caseSplit[False],
keys[[indsFalse]]
];
];
Association[
"Vertices"->vertices,
"Segments"->segs,
"Vectors"->vectors,
"Cases"->caseSplit
]
]


(* ::Input::Initialization:: *)
ColinearPhase[data_]:=Module[
{nextData=data,segs,vertices,vectors,len,
mergeRes,addKeys,fixSegs},
segs=data["Segments"];
vertices=data["Vertices"];
vectors=data["Vectors"];
len=Length[segs];
mergeRes=Catenate[
ColinearMerge[segs,vertices,vectors][
#]&/@data["Cases",True]];
MapIndexed[Set[segs[len+#2[[1]]],
Keys[Last[#1]][[{1,-1}]]]&,mergeRes];
addKeys=Range[len+1,len+Length[mergeRes]];
Map[Set[vectors[#],Apply[#2-#1&,
Lookup[vertices,Lookup[segs,#]]]]&,
addKeys];
fixSegs=Catenate[MapThread[Thread[#1->#2]&,
{First/@mergeRes,addKeys}]];
Set[
nextData["Cases",False],
Union[Map[Sort,data["Cases",False]/.fixSegs]]
];
KeyDropFrom[vectors,First/@fixSegs];
KeyDropFrom[segs,First/@fixSegs];
nextData["Graph"]=Flatten[Join[
Map[Function[segind,
MapIndexed[segind->(#2[[1]]-1)->#1&,
Lookup[vertices,Lookup[segs,segind]]]],
Complement[Range[len],fixSegs[[All,1]]]],
MapThread[Function[{key,assoc},
KeyValueMap[key->#2->Lookup[vertices,#1]&,assoc]
],{addKeys,Last/@mergeRes}]]];
nextData["Segments"]=segs;
nextData["Vectors"]=vectors; 
nextData
]


(* ::Input::Initialization:: *)
(* usage of N here is hackish  *)
IntersectionPoint[a1_,a2_,m1_,m2_
]:=Module[{den,sign,tpar,spar},
den=Dot[m1,Times[Reverse[m2],{-1,1}]];
sign=Sign[den];
den=Abs[den];
tpar=Divide[Plus[
Dot[a1,Times[Reverse[m2],{1,-1}]],
Dot[a2,Times[Reverse[m2],{-1,1}]]
],sign];
If[!TrueQ[0<=N[tpar]<=den],Return[
Failure["Bounds",Association[
"Data"->tpar/den
]]
]];
spar=Divide[Plus[
Dot[a1,Times[Reverse[m1],{1,-1}]],
Dot[a2,Times[Reverse[m1],{-1,1}]]
],sign];
If[!TrueQ[0<=N[spar]<=den],Return[
Failure["Bounds",Association[
"Data"->spar/den
]]
]];
{tpar/den,spar/den,Together[a1+m1*tpar/den]}
]


(* ::Input::Initialization:: *)
IntersectionPhase[data_]:=Module[
{segs,vertices,vectors,parallelFalse,
intersecting,cross,pars,crossGather,graph},
segs=data["Segments"];
vertices=data["Vertices"];
vectors=data["Vectors"];
parallelFalse=Lookup[data["Cases"],False,{}];
(* re-write this to thread *)
cross=Map[Function[keypair,
Apply[IntersectionPoint,
Join[Lookup[vertices,Map[First,Lookup[segs,keypair] ]],
Lookup[vectors,keypair]]]],
parallelFalse];
intersecting=Catenate[Position[Map[FailureQ,cross],False]];
pars=cross[[intersecting,{1,2}]];
cross=cross[[intersecting,-1]];
crossGather=Map[Union,Gather[Range[Length[cross]],
(*Equal[#1,#2]&*)(* buggy here *)
ProvisionalZeroQ[Norm[N[cross[[#1]]-cross[[#2]]]]]&
]];
crossGather=Association[Catenate[Map[
Function[one,one->First[#]
]/@#&,crossGather]]];
graph=Flatten[MapThread[
MapThread[#1->#2->#3&,
{#2,#3,Table[cross[[crossGather[#1]]],2]}]&,
{Range[Length[cross]],
parallelFalse[[intersecting]],
pars}]];
Join[data["Graph"],graph]
]


(* ::Input::Initialization:: *)
SolvePlanarIntersectionsGraph[
segs_Association,vertices_Association,passKeys_:True
]:=Module[{data,graph,vlist,duplicates,ind=0
},
data=InitializeCaseSplit[segs,vertices,passKeys];
data=ColinearPhase[data];
graph=IntersectionPhase[data];
graph=Map[
KeySort[Association[#],NumericalOrder]&,
GroupBy[graph,First->Last]];
graph=Values[Values/@graph];
vlist=Catenate[graph];
duplicates=Map[ReverseSortBy[Union[#],Precision]&,
Gather[Range[Length[vlist]],
ProvisionalZeroQ[Norm[N[vlist[[#1]]-vlist[[#2]]]]]&]];
duplicates=Association[Catenate[Map[
Function[one,one->First[#]
]/@#&,duplicates]]];
graph=Map[Function[null,++ind],graph,{2}];
graph=Map[vlist[[DeleteDuplicates[Lookup[duplicates,#]
]]]&,graph];
graph=Graph[Union[Sort/@MapApply[UndirectedEdge,
Catenate[Map[Partition[#,2,1]&,graph]]]]];
Graph[
Tooltip[#,{VertexOutDegree[graph,#],#}]&/@VertexList[graph],
EdgeList[graph],
VertexCoordinates->Map[#->#&,VertexList[graph]]
]
]


(* ::Input::Initialization:: *)
SolvePlanarIntersectionsGraph[segs_]:=Module[
{rev,vertices,newSegs},
vertices=Union[Catenate[segs]];
vertices=IndexedAssociation[vertices];
rev=AssociationMap[Reverse][vertices];
newSegs=Map[Lookup[rev,#1]&,segs];
newSegs=IndexedAssociation[newSegs];
SolvePlanarIntersectionsGraph[
newSegs,vertices
]
]


(* ::Subsection::Initialization::Closed:: *)
(*(*reordering*)*)


(* ::Input::Initialization:: *)
(*UpdateOrderings[data_]:=Module[{nextData=data},
Map[Set[nextData,OneProblemReorder[nextData][#]]&,
nextData["ProblemSets"]];
nextData
]*)


(* ::Input::Initialization:: *)
PlanarPolygonFragmentation::order="Classification may have failed due to precision error.";


(* ::Input::Initialization:: *)
CustomFindShortestPath[data_][graph_,del_,start_,end_]:=Module[
{flood,next,vec},
vec=Append[Subtract@@Lookup[data["Vertices"],{start,end}],0];
flood={{start}};
(*Echo[start->end];*)
While[!MemberQ[Catenate[
next=Lookup[graph,Last/@flood,{True}]],end],
flood=Catenate[MapThread[
If[TrueQ[First[#2]],Nothing,
Function[one,
If[Or[
MemberQ[del,one],
MemberQ[#1,one]
],
Nothing,
Append[#1,one]
]
]/@Select[#2,
(* colinearQ hack here*)
ProvisionalZeroQ[
Last[Cross[vec,
(* precision assumption *)
(* may need scale-set? *)
N@Append[Subtract@@Lookup[
data["Vertices"],{start,#}],0]
]]]&
]]&,
{flood,next}]];
If[SameQ[flood,{}],
ResourceFunction["ResourceFunctionMessage"
][PlanarPolygonFragmentation::order];
Return[{start,end}]
]
];
Append[flood[[Position[next,end][[1,1]]]],end]
]


(* ::Input::Initialization:: *)
OneProblemReorder[data_][graph_,probs_]:=Module[
{nextData=data,vl,inits,checks,norms,
fixthis,lookup,rules,res},
vl=VertexList[graph];
inits=Map[Partition[nextData["Orderings",#],4,1,1]&,{1,2}];
checks=Map[Association[Map[Rest[Most[#]]->Union[{First[#],Last[#]}]&,#]]&,inits];
inits=Map[Most@*Rest,inits,{2}];
norms=MapThread[
Function[{check,prob},
Map[Function[pair,
If[TrueQ[Lookup[check,Key[pair],True]],Reverse[pair],pair]
],prob]],
{checks,probs}];
fixthis=Complement[Flatten[norms],vl];
(* check collisions *)
If[Length[fixthis]>0,
fixthis=Association[Map[Function[missing,
missing->SelectFirst[vl,
ProvisionalZeroQ[Norm[Apply[Subtract,
N[Lookup[data["Vertices"],{#,missing}]]]
]]&]],fixthis]];
norms=Map[Lookup[fixthis,#,#]&,norms,{3}];
checks=Map[Association[Map[Lookup[fixthis,#,#]&,
Normal[#],{3}]]&,checks];
inits=Map[Lookup[fixthis,#,#]&,inits,{3}];
];
lookup=Association[
Map[#->VertexOutComponent[graph,#,{1}]&,
VertexList[graph]]];
(*Echo[inits->Graph[graph,VertexLabels->Automatic,
VertexCoordinates->(#->data["Vertices",#]&/@VertexList[graph])]];*)
rules=Association[Flatten[MapThread[
Function[{norm,check},
MapApply[Rule[{#1,#2},
CustomFindShortestPath[nextData][
lookup,Lookup[check,Key[{#1,#2}],{}]
,#1,#2]
]&,norm]],{norms,checks}]]];
res=Map[Catenate,Map[Most[Lookup[rules,Key[#],#]]&,inits,{2}]];
MapIndexed[Set[nextData["Orderings",#2[[1]]],#1]&,res];
nextData
]


(* ::Subsection::Initialization::Closed:: *)
(*(*solver outer loop*)*)


(* ::Input::Initialization:: *)
SolveOneIntersection[data_][problem_]:=Module[
{nextData=data,segs,keys,graph,
newVertices,newKeys},
segs=problem;
keys=Tuples[Apply[{Range[#1],Range[#1+1,#1+#2]}&,Length/@segs]];
segs=IndexedAssociation[Catenate[segs]];
graph=SolvePlanarIntersectionsGraph[segs,data["Vertices"],keys];
(*Echo[Iconize[{segs,data["Vertices"],keys}]];*)
(* re-write vertices to indices *)
newVertices=Map[If[TrueQ[
Lookup[data["ReverseVertices"],Key[#],True]
],#,Nothing]&,
VertexList[graph]];
newKeys=Table[++nextData["VertexCount"],
Length[newVertices]];
(* perhaps more thought needed here? *)
nextData["IntersectionCount"]+=Length[newKeys];
MapThread[CompoundExpression[
Set[nextData["Vertices",#1],#2],
Set[nextData["ReverseVertices",#2],#1]
]&,{newKeys,newVertices}];
graph=Graph[Map[Apply[UndirectedEdge,
Lookup[nextData["ReverseVertices"],
Apply[List,#]]]&,
EdgeList[graph]]];
(*Echo[Iconize/@{nextData,graph,problem}];*)
nextData=OneProblemReorder[nextData][graph,problem];
nextData["SolutionGraph"]=GraphUnion[
graph,nextData["SolutionGraph"]];
nextData
]


(* ::Input::Initialization:: *)
SolveIntersections[data_]:=Module[
{nextData=data},
nextData["ReverseVertices"]=AssociationMap[Reverse][
KeySelect[data["Vertices"],IntegerQ]
];
nextData["SolutionGraph"]=Graph[MapApply[UndirectedEdge,
Complement[Catenate[
Map[Sort/@Partition[#,2,1,1]&,
Values[data["Orderings"]]]],
Flatten[data["ProblemSets"],2]]]];
Map[Set[nextData,
SolveOneIntersection[nextData][#]]&,
data["ProblemSets"]];
nextData]


(* ::Subsection::Initialization::Closed:: *)
(*(*extraction*)*)


(* ::Input::Initialization:: *)
GraphToAddLinks[edges_][getVertex_,graph_,vertex_]:=Module[
{nextEdges=edges,outc,sorted},
outc=VertexOutComponent[graph,vertex,{1}];
If[Length[outc]<3,
sorted=outc,
sorted=SortBy[outc,
Apply[ArcTan,N[Apply[Subtract,
Lookup[getVertex,{#,vertex}]]]]&,
NumericalOrder]];
MapApply[
Set[nextEdges[#1,vertex],#2]&,
Partition[sorted,2,1,1]];
nextEdges
]


(* ::Input::Initialization:: *)
FinalizeResults[data_]:=Module[
{graph,getVertex,edges},
graph=data["SolutionGraph"];
getVertex=data["Vertices"];
edges=Association[#->Association[]&/@VertexList[graph]];
Map[Set[edges,GraphToAddLinks[edges][getVertex,graph,#]]&,
VertexList[graph]];
Association[
"Edges"->edges,
"Vertices"->KeyTake[getVertex,VertexList[graph]],
"Orderings"->data["Orderings"]
]
]


(* ::Input::Initialization:: *)
ExtractPolygons[edges_,inits_]:=Module[
{boundaries=Association[],unseen,
cursor,start,boundary,ind},
unseen=inits;
While[UnsameQ[unseen,{}],
cursor=First[unseen];
start=cursor;
boundary=Association[];
ind=1;
Until[SameQ[start,cursor],
boundary[ind++]=First[cursor];
unseen=DeleteCases[unseen,cursor];
cursor={Last[cursor],
edges[Sequence@@cursor]};
];
boundaries[Length[boundaries]+1]=boundary;
];
boundaries=Values/@boundaries;
Values[boundaries]
]


(* ::Input::Initialization:: *)
ClassifyFragment[checks_][fragment_
]:=Module[{directions,comp1,comp2},
directions=Map[Function[check,
comp1=SelectFirst[Partition[fragment,2,1,1],
!TrueQ[comp2=Lookup[check,Key[#],True]]&];
SameQ[comp1,comp2]
],checks];
Apply[SameQ,Values[directions]]
]


(* ::Subsection::Initialization::Closed:: *)
(*(*main*)*)


(* ::Input::Initialization:: *)
windingNumber[poly_]:=Module[
{vertices=poly[[1]]},
WindingCount[Line[Append[#,First[#]]&@vertices],
RandomPoint[poly]]
]


(* ::Input::Initialization:: *)
planarPolygonFragmentation[poly1_,poly2_,passDim_
]:=Module[
{dim=passDim,data=0,pts1,pts2,orderings,
inits,res,check,pointlike,outkey},
pts1=First[poly1];
pts2=First[poly2];
Map[Set[data,InitializeData[data][#]]&,{pts1,pts2}];
data["Inputs"]=data["Polygons"];
data["Orderings"]=data["Polygons"];
orderings=data["Polygons"];
(* substantial time cost here *)
(*Echo["",LOCAL];*)
data=LocalizeData[data,dim];
(*Echo["",GRAPH];*)
data=ClassifierGraph[data];
(*Echo["",PROBS];*)
data=ProblemSets[data];
(*Echo["",SOLVE];*)
data=SolveIntersections[data];
(*Echo["",FIN];*)
data=FinalizeResults[data];
(*Echo["",EXT];*)
inits=Catenate[KeyValueMap[If[
Length[#2]>2,
Thread[{#1,Keys[#2]}],{}]&,data["Edges"]]];
res=ExtractPolygons[data["Edges"],inits];
(* failure mode exits *)
If[SameQ[Length@res,0],
(* this is potentially unstable *)
outkey=SameQ[
windingNumber[poly1],
windingNumber[poly2]
];
If[Or[
TrueQ[RegionMember[poly1,poly2[[1,1]]  ]],
TrueQ[RegionMember[poly2,poly1[[1,1]] ]]
],
outkey=Not[outkey];
];
Return[KeySort[Association[
Not[outkey]->{poly1,poly2},
outkey->{}]]]
];
check=Map[Association[Catenate[Map[
{#->#,Reverse[#]->#}&,
Partition[#,2,1,1]]]]&,
data["Orderings"]];
(* success mode exit *)
pointlike=Select[res,
Function[inds,
!AllTrue[Values[data["Orderings"]],
!SameQ[Union[inds],Union[#]]&]]];
If[Length[pointlike]>0,
res=List[Complement[res,pointlike],pointlike];
outkey=ClassifyFragment[check][res[[1,1]]];
res=KeySort[Association[
MapThread[Rule,{{outkey,Not[outkey]},res}]]],
res=KeySort[GroupBy[res,ClassifyFragment[check]]]
];
Map[SortBy[#,Length@@#&]&,
Map[Polygon[
Lookup[data["Vertices"],#]
]&,res,{2}]]
]


(* ::Input::Initialization:: *)
ToSimplePolygon[vertices:{_List...}
]:=If[And[
MatrixQ[vertices,NumericQ],
MatchQ[Dimensions[vertices],{_,2}]
],Polygon[vertices],True]


(* ::Input::Initialization:: *)
ToSimplePolygon[
vertices:{_List...},
data:{_Integer...}
]:=If[And[
MatrixQ[vertices,NumericQ],
MatchQ[Dimensions[vertices],{_,2}]
],Polygon[vertices[[data]]],True]


(* ::Input::Initialization:: *)
ToSimplePolygon[__]:=True


(* ::Input::Initialization:: *)
PlanarPolygonFragmentation::input="Input polygons failed to canonicalize.";


(* ::Input::Initialization:: *)
PlanarPolygonFragmentation[
Polygon[data1__],Polygon[data2__],
OptionsPattern[{"BinCount"->1}]]:=Module[
{poly1,poly2,dim,fail},
dim=OptionValue["BinCount"];
If[!And[IntegerQ[dim],Positive[dim]],
dim=1];
poly1=ToSimplePolygon[data1];
poly2=ToSimplePolygon[data2];
fail=Or[TrueQ[poly1],TrueQ[poly2]];
If[fail,
ResourceFunction["ResourceFunctionMessage"][PlanarPolygonFragmentation::input]
];
planarPolygonFragmentation[poly1,poly2,dim]/;Not[fail]
]


(* ::Section:: *)
(*End*)


End[]
EndPackage[]
