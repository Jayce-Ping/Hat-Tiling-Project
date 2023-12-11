(* ::Package:: *)

BeginPackage["HappyTile`",{"DepictTile`", "Planar`"}]


(* ::Section::Closed:: *)
(*Symbol Declaration*)


{
	allRoatationsofOneTile,
	allRoatationsofTiles,
	findEqualTile,
	findEqualHat,
	canonicalPolygon
}


{
	codeUnion,
	codeJoin
}


{
	oneThirdVertexTheoremLis,
	oneFourthVertexTheoremLis,
	TshapeList,
	oneHalfTheoremList,
	oneThirdAndTwoThirdTheoremList,
	oneFourthAndThreeFourthTheoremList
}


{
	getVertexInformation,
	localize,
	canonicalizeTheoremList,
	getStateFromTheorem,
	generator
}


{
	PolygonListUnion
}


{
	getPointsBranches,
	growForcedPoint,
	BranchesNumberLimit,
	InvalidPointsDetect
}


{
	getBranchesOrderedByForce,
	MergeForced,
	BranchCompromise,
	ChoosePoints
}


{
	growthGraph,
	VisualizeNode
}


{
	growForcedThenBranch
}


{
	drawInfomration,
	getVerticesInf,
	hatInnerVertices,
	tilingState,
	stateMerge,
	growHatTiling,
	PrioritizeReflected,
	PrioritizeLessBranches
}


{
	tilingGraph,
	provisionalGraphBoundaryCycle
}


{
	colorRules,
	vertexConfigurationFind,
	quickShowVertexConfiguration
}


{
	transformCode
}


(* ::Section::Closed:: *)
(*Begin Private*)


(* ::Code::Initialization::Plain:: *)
Begin["Private`"]


(* ::Section::Closed:: *)
(*Polygon Canonicalize*)


canonicalPolygon[poly_]:=With[{verticesList = poly[[1]]},
	Polygon[
		RotateLeft[verticesList,
		First @ First @ Position[verticesList, First @ TakeSmallestBy[verticesList, Norm @* N,  1]] - 1]
	]
]


(* ::Section::Closed:: *)
(*Helper Functions*)


(* ::Input::Initialization::Plain:: *)
allRoatationsofOneTile[tile_]:={Mod[If[tile[[2]]==False,tile[[1]]+#,tile[[1]]-#],12],tile[[2]],tile[[3]]}&/@Range[0,11]/;Length[tile]==3
allRoatationsofTiles[tiles_]:=Transpose[allRoatationsofOneTile/@tiles]


(* ::Input::Initialization::Plain:: *)
findEqualTile[step_][pos_,tile_]:=With[
{
	p=Simplify[pos]
},
	With[{position = Position[Simplify[TileVertices[step]@@tile], p]},
	If[
		position==={},
		tile,
		{p,tile[[2]],tile[[3]],First[First[position]]}]
		]
]


(* ::Input::Initialization::Plain:: *)
findEqualHat[pos_,tile_]:=findEqualTile[{1, Sqrt[3]}][pos,tile]


(* ::Text:: *)
(*codeJoin is a little faster than codeUnion*)


codeUnion = Union[##, SameTest -> ( canonicalHat @@ #1 === canonicalHat @@ #2 &)]&;


codeJoin = DeleteDuplicatesBy[Join[##], canonicalHat @@ # &]&;


(* ::Text:: *)
(*Test if hat tiles align well with each other.*)


codeConsistentQ[code_] := Block[{
	innerVertices = Join @@ (hatInnerVertices @@@ code),
	boundaryVertices = DeleteDuplicates[Join @@ (hatVertices @@@ code)]
},
	!IntersectingQ[innerVertices, boundaryVertices]
]


(* ::Section::Closed:: *)
(*Theorem List*)


(* ::Subsection::Closed:: *)
(*1/3 * 3*)


(* ::Input::Initialization::Plain:: *)
oneThirdVertexTheoremLis=<|
{1,Sqrt[3]}->{
	{{0,False,12},{8,False,12},{2,False,14}},
	{{0,False,4},{2,False,12},{8,False,14}},
	{{0,False,4},{2,False,12},{10,False,12}},
	{{0,False,4},{4,False,4},{2,False,12}},
	{{0,False,4},{4,False,4},{8,False,4}},
	{{0,False,2},{0,False,6},{4,False,6}},
	{{0,False,2},{4,False,2},{4,False,6}},
	{{0,False,2},{4,False,2},{8,False,2}}
	}
,

{1,1}->{
{{0,False,2},{0,False,6},{4,False,6}},
{{0,False,2},{0,False,6},{8,False,2}},
{{0,False,2},{4,False,2},{8,False,2}},
{{0,False,4},{2,False,12},{4,False,4}},
{{0,False,4},{2,False,12},{8,False,14}},
{{0,False,4},{2,False,12},{10,False,12}},
{{0,False,4},{4,False,4},{8,False,4}},
(*{{0,False,6},{4,False,6},{8,False,6}},*)
{{0,False,12},{2,False,14},{8,False,12}}
(*{{0,False,12},{4,False,12},{8,False,12}}*)
}
|>;


(* ::Subsection::Closed:: *)
(*1/4 * 4*)


(* ::Input::Initialization::Plain:: *)
oneFourthVertexTheoremLis = <|
{1,Sqrt[3]}->{
		{{0,False,3},{4,False,9},{2,False,7},{10,True,11}},
		{{0,True,3},{6,False,7},{8,False,9},{10,False,11}}
	}
,
{1,1}->{
(*{{0,False,11},{3,False,11},{0,False,3},{10,False,9}},*)
(*{{0,False,11},{3,False,11},{6,False,11},{9,False,11}},*)
{{0,False,11},{9,False,3},{8,False,7},{10,False,9}},
(*{{1,False,9},{9,False,3},{7,False,9},{3,False,3}},*)
{{1,False,9},{9,False,3},{8,False,7},{11,False,7}}
(*{{2,False,7},{5,False,7},{8,False,7},{11,False,7}}*)
}
|>;


(* ::Subsection::Closed:: *)
(*1/2 + 1/4 + 1/4*)


(* ::Input::Initialization::Plain:: *)
TshapeList=<|
{1,Sqrt[3]}->{
	{{0,False,13},{0,False,9},{2,False,3}},
	{{0,True,13},{10,False,7},{0,False,9}},
	{{0,False,13},{10,True,7},{8,False,11}},
	{{0,False,13},{10,False,7},{0,False,9}}
	}

,

{1,1}->{
{{0,False,9},{0,False,13},{2,False,3}},
{{0,False,9},{0,False,13},{10,False,7}},
(*{{2,False,3},{0,False,13},{11,False,11}},*)
{{8,False,11},{0,False,13},{11,False,11}},
{{9,False,9},{0,False,13},{11,False,11}}
(*{{10,False,7},{0,False,13},{11,False,11}}*)
}
|>;


(* ::Subsection::Closed:: *)
(*1/2 + 1/2*)


oneHalfTheoremList=<|
{1,Sqrt[3]}->
	{
		{{0,False,13},{6,False,13}}
	}
	,
{1,1}->
	{
		{{0,False,13},{6,False,13}}
	}
	|>;


(* ::Subsection::Closed:: *)
(*1/3 + 2/3*)


(* ::Input::Initialization::Plain:: *)
oneThirdAndTwoThirdTheoremList=<|
	{1,Sqrt[3]}->{
	{{0,False,8},{0,False,14}},
	{{0,False,8},{0,True,12}},
	{{0,True,8},{0,False,12}},
	{{0,False,8},{2,False,12}},
	{{0,False,8},{6,True,4}},
	{{0,True,8},{6,False,4}},
	{{0,False,8},{8,False,4}},
	{{0,False,8},{10,True,14}},
	{{0,True,8},{10,False,14}},
	{{0,False,10},{2,False,2}},
	{{0,False,10},{6,True,6}},
	{{0,True,10},{6,False,6}},
	{{0,False,10},{10,False,6}},
	{{0,False,10},{10,True,2}},
	{{0,True,10},{10,False,2}}
	}
,
{1,1}->{
{{0,False,8},{0,False,14}},
{{0,False,8},{1,False,2}},
{{0,False,8},{2,False,12}},
{{0,False,8},{8,False,4}},
{{0,False,8},{9,False,6}},
{{0,False,10},{1,False,14}},
{{0,False,10},{2,False,2}},
{{0,False,10},{3,False,12}},
{{0,False,10},{9,False,4}},
{{0,False,10},{10,False,6}}
}
|>;


(* ::Subsection::Closed:: *)
(*1/4 + 3/4*)


(* ::Input::Initialization::Plain:: *)
oneFourthAndThreeFourthTheoremList=<|
{1,Sqrt[3]}->{
	{{0,False,1},{0,False,7}},
	{{0,False,1},{4,False,3}},
	{{0,False,1},{10,False,11}},
	{{0,False,1},{10,True,9}},
	{{0,False,5},{2,False,11}},
	{{0,False,5},{4,False,7}},
	{{0,False,5},{6,True,9}},
	{{0,False,5},{8,False,3}},
	{{0,True,1},{10,False,9}},
	{{0,True,5},{6,False,9}}
	}
,
{1,1}->{
{{0,False,1},{0,False,7}},
{{0,False,1},{4,False,3}},
{{0,False,1},{10,False,11}},
{{0,False,1},{11,False,9}},
{{0,False,5},{2,False,11}},
{{0,False,5},{3,False,9}},
{{0,False,5},{4,False,7}},
{{0,False,5},{8,False,3}}
}
|>;


(* ::Section::Closed:: *)
(*Get Vertex Information*)


(* ::Text:: *)
(*After make edge into 1/2 vertex, we only need to find all tiles covering the point at vertex.*)


(* ::Input::Initialization::Plain:: *)
getVertexInformation[step_][point_,state_]:=With[
	{pos=Position[TileVertices[step]@@#,_?(#==point&)]},
	If[pos!={}, {point,#[[2]],#[[3]],First@First@pos},Nothing]]&/@state


(* ::Section::Closed:: *)
(*Generator*)


(* ::Subsection::Closed:: *)
(*localize*)


(* ::Input::Initialization::Plain:: *)
localize[step_][state_,pt_,r_]:=Select[state,(AnyTrue[(#-pt&)/@(TileVertices[step]@@#), (Norm[Simplify[#]]<r&)]&)]


(* ::Subsection::Closed:: *)
(*From Theorem*)


(* ::Input::Initialization::Plain:: *)
canonicalizeTheoremList[oneTile_, list_] := RotateLeft[list, First @ First @ Position[list, oneTile] - 1];


(* ::Input::Initialization::Plain:: *)
getStateFromTheorem[vertexCoveringTiles_, theoremList_] := Union[
	If[
		SubsetQ[#, vertexCoveringTiles],
		DeleteCases[
			If[
				Length[vertexCoveringTiles] == 1,
				canonicalizeTheoremList[First[vertexCoveringTiles], #],
				#],
			Alternatives @@ vertexCoveringTiles
			],
		Nothing
	]& /@Flatten[allRoatationsofTiles[#]& /@theoremList, 1]
]


(* ::Subsection::Closed:: *)
(*Generator*)


(* ::Input::Initialization::Plain:: *)
generator[step_][state_,startpt_]:=generator[step][state,startpt,getVertexInformation[step][startpt,state]];


(* ::Input::Initialization::Plain:: *)
generator[step_][state_, startpt_, inf_List]:=Module[
{
	oneThirdV,oneFourthV,threeFourthV,twoThirdV,oneHalfV,
	branches  = Association[],
	configuration
},

	If[Total[vertexAngles/@inf[[All,4]]]>=1, Return[<||>]];
	
	
	oneThirdV=Count[inf[[All,4]], Alternatives@@oneThirdVertices];
	oneFourthV=Count[inf[[All,4]], Alternatives@@oneFourthVertices];
	oneHalfV=Count[inf[[All,4]], Alternatives@@oneHalfVertices];
	twoThirdV=Count[inf[[All,4]], Alternatives@@twoThirdVertices];
	threeFourthV=Count[inf[[All,4]], Alternatives@@threeFourthVertices];
	
	
	
	configuration = {oneFourthV,oneThirdV,oneHalfV,twoThirdV,threeFourthV};
	(*Echo[configuration];*)
	
	(*1/4 + 1/4 + edge *)
	If[
		MatchQ[configuration, {_?Positive,0,_,0,0} | {0,0,1,0,0}],
		Echo["T"];
		branches["1/4+1/4+1/2"] = Apply[{startpt, ##}&,
									QuietEcho @ getStateFromTheorem[inf[[All,2;;]], TshapeList[step]],{2}]
	];
	(*1/2 + 1/2*)
	If[
		MatchQ[configuration, {0,0,1,0,0}],
		Echo["1/2+1/2"];
		branches["1/2+1/2"] = Apply[{startpt, ##}&,
									QuietEcho @ getStateFromTheorem[inf[[All,2;;]], oneHalfTheoremList[step]],{2}]
	];

	(* 3 * 1/3 *)
	If[
		MatchQ[configuration, {0,_?Positive,0,0,0}],
		Echo["1/3 * 3"];
		branches["1/3+1/3+1/3"] = Apply[{startpt, ##}&,
									QuietEcho @ getStateFromTheorem[inf[[All,2;;]], oneThirdVertexTheoremLis[step]],{2}]
	];
	
		(* 4 * 1/4 *)
	If[
		MatchQ[configuration, {_?Positive,0, 0,0,0}],
		Echo["1/4 * 4"];
		branches["1/4+1/4+1/4+1/4"] = Apply[{startpt, ##}&,
									QuietEcho@getStateFromTheorem[inf[[All,2;;]], oneFourthVertexTheoremLis[step]],{2}]
	];
	
		(*1/3 + (2/3)*)
	If[
		MatchQ[configuration, {0,1,0,0,0}|{0,0,0,1,0}],
		Echo["1/3 + 2/3"];
		branches["1/3+2/3"] =  Apply[{startpt, ##}&,
									QuietEcho@getStateFromTheorem[inf[[All,2;;]],oneThirdAndTwoThirdTheoremList[step]],{2}]
	];
		
		(*1/4 + 3/4*)
	If[
		MatchQ[configuration, {1,0,0,0,0}|{0,0,0,0,1}],
		Echo["1/4 + 3/4"];
		branches["1/4+3/4"] =  Apply[{startpt, ##}&,
									QuietEcho@getStateFromTheorem[inf[[All,2;;]],oneFourthAndThreeFourthTheoremList[step]],{2}]
	];
	branches
]


(* ::Section::Closed:: *)
(*Brad Klee Polygon Handler*)


(* ::Subsection::Closed:: *)
(*Union Function*)


PolygonListUnion[polys_, passDim_:10]:=Fold[
	Select[
		Values[
			PlanarPolygonFragmentation[
				#1,
				#2,
				"BinCount" -> passDim
		]
	],Length[#]==1&][[1,1]]&, polys
]


(* ::Section::Closed:: *)
(*Grow on Points*)


(* ::Subsection::Closed:: *)
(*get branches for each points*)


Options[getPointsBranches]={step -> {1,Sqrt[3]}};
getPointsBranches[state_, pointsList_, opt:OptionsPattern[]]:=Module[
{
	pointsInformation = Association[#->{}& /@ (Union @@ (TileVertices[OptionValue[step]] @@@ state))]
},
	Function[tile,
		AppendTo[pointsInformation[#], findEqualTile[OptionValue[step]][#, tile]]& /@ (TileVertices[OptionValue[step]] @@ tile)
			] /@ state;
	
	Function[
		inf,
		inf[[1]] -> Union @@
			QuietEcho @
				generator[OptionValue[step]][
					state,
					inf[[1]],
					inf[[2]]
		]
	] /@
	Normal[
		KeySelect[
			pointsInformation,
			Function[pt, MemberQ[pointsList,_?(#==pt&)]]
		]
	]
]


(* ::Subsection::Closed:: *)
(*Intersection + Theorem to select forced points*)


(* ::Code::Initialization::Plain:: *)
Options[growForcedPoint]={
	step -> {1, Sqrt[3]},
	BranchesNumberLimit -> Infinity,
	InvalidPointsDetect -> True
};
growForcedPoint[state_, polygon_, opt : OptionsPattern[]] := Module[
{
	branchesForAllPoints,
	intersectionTestFunction
},
	
	branchesForAllPoints= getPointsBranches[state, polygon[[1]], step -> OptionValue[step]];
	
	If[
		OptionValue[InvalidPointsDetect] == True,
		With[
		{
			invalidVertices = Cases[branchesForAllPoints, x_?(Length[#[[2]]] == 0 &) :> First[x]]
			},
			If[
				Length[invalidVertices] > 0,
				Print["Invalid Vertices:", invalidVertices];
				Return[{}
				]
			]
		]
	];

	intersectionTestFunction = Function[cdds,
			Map[
				With[
						{
							fragRes = PlanarPolygonFragmentation[polygon, PolygonListUnion[Tile[OptionValue[step]] @@@ #]]
						},
				
						If[
							Total[Length /@ fragRes] == 3,  # -> Select[Values[fragRes], Length[#]==1&][[1,1]], Nothing]
				]&,
				cdds,
			{1}
			]
		];

	branchesForAllPoints = Normal[
		intersectionTestFunction /@ Association[
			Values[
				KeySelect[GroupBy[branchesForAllPoints, Length[#[[2]]]&], # <= OptionValue[BranchesNumberLimit]&]
			]
		]
	];
	Echo[branchesForAllPoints,"After Intersection"];
	If[
		OptionValue[InvalidPointsDetect] == True,
		With[
		{
			impossibleVertices = Cases[branchesForAllPoints, x_?(Length[#[[2]]] == 0&) :> First[x]]
			},
			If[
				Length[impossibleVertices] > 0,
				Print["Impossible Vertices:", impossibleVertices];
				Return[{}
				]
			]
		]
	];
	
	branchesForAllPoints = KeySort[GroupBy[branchesForAllPoints, Length[#[[2]]]&]];
	
	If[!KeyExistsQ[branchesForAllPoints, 1], Return[state -> polygon]];
	
	With[
	{
		forcedNewTiles = Union[##,
			SameTest -> (canonicalTile[OptionValue[step]] @@ #1==(canonicalTile[OptionValue[step]] @@ #2)&)
		]& @@ (First @* First /@ (branchesForAllPoints[1][[All,2]]))
	},
		(*reliable version*)
		Join[state, forcedNewTiles] -> PolygonListUnion[Prepend[Tile[OptionValue[step]] @@@ forcedNewTiles, polygon]]
		
		(*faster version but unreliable*)
		(*Join[state, forcedNewTiles] -> Polygon[
				VertexList[
					Fold[
					
						provisionalGraphBoundaryCycle[GraphUnion[#1,#2]]&,
					
						DirectedEdge @@@ Partition[polygon[[1]], 2, 1, 1],
						
						tilingGraph[{#}, step -> OptionValue[step]]& /@ forcedNewTiles
						
						]
					]
				]
			]*)
	]

]


(* ::Subsection::Closed:: *)
(*Only Theorem to select forced points, then intersection test. If branch, branch many points*)


(* ::Code::Initialization::Plain:: *)
Options[getBranchesOrderedByForce] = {
MergeForced -> True,
 BranchCompromise -> True,
 step -> {1, Sqrt[3]},
 ChoosePoints -> False
 };
getBranchesOrderedByForce[state_, polygon_, opt : OptionsPattern[]] := getBranchesOrderedByForce[state, polygon, Infinity, opt]
getBranchesOrderedByForce[state_, polygon_, n_, opt : OptionsPattern[]] := Module[
{
	candidates = KeySort[
		GroupBy[
			getPointsBranches[state, 
				If[OptionValue[ChoosePoints] === False, polygon[[1]], OptionValue[ChoosePoints]], 
					step -> OptionValue[step]][[All, 2]],
					Length]
					],
	res,
	ind,
	intersectionTest,
	goBranch,
	goMerge
},
	If[KeyExistsQ[candidates, 0], Print["Exist Impossible Points"];Return[{}]];
	
	intersectionTest = Function[cdds, With[
		{
			fragRes = PlanarPolygonFragmentation[polygon, PolygonListUnion[Tile[OptionValue[step]] @@@ #]]
		},
		If[
			Total[Length /@ fragRes] == 3, Join[state, #] -> Select[Values[fragRes], Length[#]==1&][[1,1]], Nothing]
		]&/@(
			Apply[
					Union[##, SameTest -> (MatchQ[canonicalTile[OptionValue[step]] @@@ #1, {OrderlessPatternSequence @@ (canonicalTile[OptionValue[step]] @@@ #2)}]&)]&,
					cdds
				]
		)
	];
	goBranch := Scan[
			If[
				# > n, Return[{}],
				
				If[intersectionTest[candidates[#]] =!= {}, Return[intersectionTest[candidates[#]]]]
				
			]&,
			Keys[candidates]
		];
	goMerge := With[
			{
				testRes = intersectionTest[candidates[1]]
			},
			If[
				testRes === {},
				
				If[
					OptionValue[BranchCompromise],
					goBranch,
					Return[{}]
				],
				
				With[
					{
						newstate = Union[##, 
							SameTest -> (canonicalTile[OptionValue[step]] @@ #1 == canonicalTile[OptionValue[step]] @@ #2&)]& @@ 
							testRes[[All, 1]]
					},
				 
					{
					Rule[
						newstate
						,
						(*reliable version*)
						PolygonListUnion[Join[{polygon}, Tile[OptionValue[step]] @@@ DeleteCases[newstate, Alternatives @@ state]]]
						
						]
						}
					]
				]
			];
	
	If[
		OptionValue[MergeForced] === False,
		(*just branch*)
		goBranch,
		(*try to merge*)(*only cansidate 1 branch candidates, maybe there are other after intersection test*)
		If[
			KeyExistsQ[candidates, 1],
			goMerge,
			If[
				(*if concess to branch*)
				OptionValue[BranchCompromise],
				goBranch,
				{}
				]
			]
	]
]


(* ::Subsection::Closed:: *)
(*Try to grow forced points first, if there is no such points, then choose one point with two branches to grow*)


(* ::Code::Initialization::Plain:: *)
Options[growForcedThenBranch]={
	step -> {1, Sqrt[3]},
	BranchesNumberLimit -> 2,
	InvalidPointsDetect -> True,
	"BinCount" -> 10
};
growForcedThenBranch[state_ -> polygon_, opt : OptionsPattern[]] := Module[
{
	branchesForAllPoints,
	intersectionTestFunction
},
	
	If[Head[polygon] =!= Polygon, Return[{}]];
	
	branchesForAllPoints= getPointsBranches[state, polygon[[1]], step -> OptionValue[step]];
	
	If[
		OptionValue[InvalidPointsDetect] == True,
		With[
		{
			invalidVertices = Cases[branchesForAllPoints, x_?(Length[#[[2]]] == 0 &) :> First[x]]
			},
			If[
				Length[invalidVertices] > 0,
				Print["Invalid Vertices:", invalidVertices];
				Return[{}]
			]
		]
	];

	intersectionTestFunction = Function[cdds,
			Map[
				With[
						{
							fragRes = PlanarPolygonFragmentation[
								polygon, PolygonListUnion[Tile[OptionValue[step]] @@@ #, OptionValue["BinCount"]],
								"BinCount" -> OptionValue["BinCount"]
								]
						},
				
						If[
							Total[Length /@ fragRes] == 3,  # -> Select[Values[fragRes], Length[#]==1&][[1,1]], Nothing]
				]&,
				cdds,
			{1}
			]
		];

	branchesForAllPoints = Normal[
		intersectionTestFunction /@ Association[
			Values[
				KeySelect[GroupBy[branchesForAllPoints, Length[#[[2]]]&], # <= OptionValue[BranchesNumberLimit]&]
			]
		]
	];
	
	branchesForAllPoints = KeySort[GroupBy[branchesForAllPoints, Length[#[[2]]]&]];
	
	(*Echo[branchesForAllPoints,"After Intersection"];*)
	
	If[
		OptionValue[InvalidPointsDetect] == True && KeyExistsQ[branchesForAllPoints, 0],
		With[
		{
			impossibleVertices = branchesForAllPoints[0][[All, 1]]
			},
			If[
				Length[impossibleVertices] > 0,
				Print["Impossible Vertices:", impossibleVertices];
				Return[{}]
			]
		]
	];
	
	If[
		KeyExistsQ[branchesForAllPoints, 1]
		,
		With[
		{
		(*SortBy is to avoid some bug cause by a polygon with a "hole"*)
			forcedNewTiles = SortBy[Min[Norm[N[TileVertices[OptionValue[step]]@@#]]]&][
					Union[##,
						SameTest -> (canonicalTile[OptionValue[step]] @@ #1==(canonicalTile[OptionValue[step]] @@ #2)&)
					]& @@ (First @* First /@ (branchesForAllPoints[1][[All, 2]]))
				]
		},
			(*reliable version*)
			{Join[state, forcedNewTiles] -> PolygonListUnion[Prepend[Tile[OptionValue[step]] @@@ forcedNewTiles, polygon]]}
		]
		,
		(*find one point nearest to original point with least branches*)
		Join[state, #] -> PolygonListUnion[Prepend[Tile[OptionValue[step]] @@@ #, polygon]] & /@ SortBy[First[branchesForAllPoints], Norm @* N @* First][[1, 2, All, 1]]
	]
]


(* ::Section::Closed:: *)
(*Growth Graph*)


Options[growthGraph] = Join[
Options[getBranchesOrderedByForce],
Options[show],
Options[Graph],
{
BranchesNumberLimit -> Infinity,
VisualizeNode -> True
}
];

growthGraph[init_, poly_, generation_, opt : OptionsPattern[]] := With[
{
	g = NestGraph[
		Function[state,
			Apply[
					Sort[canonicalTile[OptionValue[step]] @@@ #1] -> canonicalPolygon[#2]&,
					QuietEcho @ getBranchesOrderedByForce[state[[1]], state[[2]], OptionValue[BranchesNumberLimit]
					, Sequence @@ FilterRules[{opt}, Options[getBranchesOrderedByForce]]],
					{1}
				]
		],
			init -> poly,
			generation
		]
},
	Graph[
		g,
		Sequence @@ FilterRules[{opt}, Options[Graph]],
		VertexShapeFunction -> If[
			TrueQ @ OptionValue[VisualizeNode],
			(Inset[
					show[#2[[1]], Sequence @@ FilterRules[{opt}, Options[show]]],
					#1, Center, 5*#3
					]&),
			Automatic
			]
		,
		EdgeShapeFunction -> ({Red,Arrowheads[0.01],Arrow[#1, 0.1]}&)
	]
]


(* ::Section::Closed:: *)
(*New grow function with new intersection test method for hat*)


(* ::Subsection::Closed:: *)
(*get inner vertices*)


hatInnerVertices[pos_,dir_,ref_,pt_] := Mean[hatVertices[pos,dir,ref,pt][[#]]]&/@{{2,8},{6,10}}


(* ::Subsection::Closed:: *)
(*visualization*)


Options[drawInfomration] = Join[
Options[Show],
Options[show],
{
	"highlightBoundaryPoints" -> True,
	"highlightBoundaryTiles" -> True,
	PointSize -> 0.02
}];


drawInfomration[tiling_Association, opt : OptionsPattern[]] := With[
{
	boundaryTiles = If[OptionValue["highlightBoundaryTiles"], DeleteDuplicates[Values[tiling["boundaryPoints"]][[All, 1, 2]]], {}]
},
	Show[{
		show[boundaryTiles, Complement[tiling["code"], boundaryTiles], Sequence @@ FilterRules[{opt}, Options[show]]],
		If[OptionValue["highlightBoundaryPoints"], Graphics[{PointSize[OptionValue[PointSize]], Red, Point[Keys[tiling["boundaryPoints"]]]}], Nothing]
	},
		Sequence @@ FilterRules[{opt}, Options[Show]]
	]
]


(* ::Subsection::Closed:: *)
(*get vertex information*)


getVerticesInf[code_, OptionsPattern[{step->{1, Sqrt[3]}}]] := Block[
		{pointsInformation = Association[]},
		Scan[
			Function[tile,
				MapIndexed[
					If[
						KeyExistsQ[pointsInformation, #1],
						AppendTo[pointsInformation[#1], First[#2] -> tile],
						AssociateTo[pointsInformation, #1 -> {First[#2] -> tile}]
						]&,
					(TileVertices[OptionValue[step]] @@ tile)
				]
			],
			code
		];
		pointsInformation
	];


(* ::Subsection::Closed:: *)
(*generate state association*)


tilingState[code_List, OptionsPattern[{step -> {1, Sqrt[3]}}]] := With[{ptinf = getVerticesInf[code, step -> OptionValue[step]]},
	<|
		"code" -> code,
		"boundaryPoints" -> Select[ptinf, Total[#[[All,1]] /. vertexAngles] < 1&]
	|>
]


(*tilingState[code_List, boundaryPoints_List] :=
<|
	"code" -> code,
	"boundaryPoints" -> boundaryPoints
|>;*)


(* ::Subsection::Closed:: *)
(*merge state association*)


stateMerge = Function[{state, newstate},
	Association[
		MapThread[
			#2 -> #1[state[#2], newstate[#2]]&,
			{
				{
					codeJoin,
					Select[Merge[{##}, Join @@ #&], Total[(#[[All, 1]] /. vertexAngles)] < 1&]&
				},
				{"code", "boundaryPoints"}
			}
		]
	]
];


(* ::Subsection::Closed:: *)
(*new grow function*)


Options[growHatTiling]={
	BranchesNumberLimit -> 4,
	(*choose candidate points with branches number limited to do intersetion test, the less this number is, the faster but less cases considered*)
	PrioritizeReflected -> True,
	(*Prioritize reflected hat tile, generating branches with more hat tiles is prioritized.*)
	PrioritizeLessBranches -> False,
	(*Only select branch point with least branch number*)
	ChoosePoints -> False
};
growHatTiling[state_, opt : OptionsPattern[]] := Module[
{
	branchesForAllPoints,
	intersectionTestFunction,
	boundaryVertices,
	boundaryHatsInnerVertices
},
	branchesForAllPoints = KeyValueMap[
		Function[
			{pt, value},
			pt -> Join @@ QuietEcho @ generator[{1, Sqrt[3]}][state["code"], pt, {pt, #[[2,2]], #[[2,3]], #[[1]]}& /@ value]
			],
		If[
			OptionValue[ChoosePoints] === False,
			state["boundaryPoints"],
			KeySelect[state["boundaryPoints"], MemberQ[OptionValue[ChoosePoints], #]&]
		]
	];
	
	With[
	{
		invalidVertices = Cases[branchesForAllPoints, x_?(Length[#[[2]]] == 0 &) :> First[x]]
		},
		If[
			Length[invalidVertices] > 0,
			Print["Invalid Vertices:", invalidVertices];
			Sow[invalidVertices,"Invalid Vertices"];
			Return[{}]
		]
	];
	
	boundaryVertices = Keys[state["boundaryPoints"]];
	
	boundaryHatsInnerVertices = Union @@ (hatInnerVertices @@@ DeleteDuplicates[Values[state["boundaryPoints"]][[All, 1, 2]]]);
	
	intersectionTestFunction = Block[
		{
			newInnerPoints = Join @@ (hatInnerVertices @@@ #),
			newBoundaryPoints
		},
		
		newBoundaryPoints = Select[getVerticesInf[#], Total[#[[All, 1]] /. vertexAngles] < 1&];
		
		If[
			Or[
				IntersectingQ[boundaryVertices, newInnerPoints],
				IntersectingQ[boundaryHatsInnerVertices, Keys[newBoundaryPoints]]
				],
				Nothing,
				<|
					"code" -> #,
					"boundaryPoints" -> newBoundaryPoints
				|>
			]		
		]&;
	
	branchesForAllPoints = Join @@ Values[KeySelect[GroupBy[branchesForAllPoints, Length[#[[2]]]&], # <= OptionValue[BranchesNumberLimit]&]];
		
	branchesForAllPoints =  #1 -> Map[intersectionTestFunction, #2, {1}] & @@@ branchesForAllPoints;
	
	branchesForAllPoints = KeySort[GroupBy[branchesForAllPoints, Length[#[[2]]]&]];
	
	If[branchesForAllPoints === <||>, Return[{}]];
	
	If[
		KeyExistsQ[branchesForAllPoints, 0],
		
		Print["Impossible Vertices:", branchesForAllPoints[0][[All, 1]]];
		Sow[branchesForAllPoints[0][[All, 1]], "Impossible Vertices"];
		Return[{}]
	];
	
	If[
		KeyExistsQ[branchesForAllPoints, 1],
		
		{stateMerge[
			state,
			tilingState[codeJoin @@ (First[#]["code"]& /@ branchesForAllPoints[1][[All, 2]]), step -> {1, Sqrt[3]}]
		]},
		(*ordering by distant to orginal point, except it has reflected branch*)
		stateMerge[state, #]& /@ 
			Last[
				First[
					TakeSmallestBy[
					(*
						Here we can use First[branchesForAllPoints] to minize the branches number,
						It is also useful to generate branches with more reflected tiles first.
					*)
						If[TrueQ[OptionValue[PrioritizeLessBranches]], First[branchesForAllPoints], Join @@ branchesForAllPoints],
						
						If[
							TrueQ[OptionValue[PrioritizeReflected]],
							
							With[
								{
									refNum = Count[Lookup[#[[2]], "code"][[All, All, 3]], True, {2}]
								},
								If[refNum != 0 , -refNum, Norm[N[First[#]]]]
							]&,
							
							Norm @* N @* First
						],
						1
					]
				]
			]
	]
]


(* ::Section::Closed:: *)
(*Tiling Graph*)


(* ::Subsection::Closed:: *)
(*build tiling graph*)


Options[tilingGraph] = {step->{1, Sqrt[3]}};

tilingGraph[code_, opt : OptionsPattern[]] := Union @@ (Function[tileCode,
	MapThread[
		DirectedEdge[#1[[1]], #1[[2]], #2]&,
		{
			If[
				tileCode[[3]] == False,
				Expand[TileEdges[OptionValue[step]] @@ tileCode],
				Reverse /@ (Expand[TileEdges[OptionValue[step]] @@ tileCode])
			],
			Range[14]
		}
	]
] /@ code)


(* ::Subsection::Closed:: *)
(*provisional boundary finder*)


provisionalGraphBoundaryCycle[g_] := With[
{
	boundary = Cases[EdgeList[g], DirectedEdge[x_, y_, z___] /; (VertexDegree[g, x] == 2 || VertexDegree[g, y] == 2)]
},
	First[FindCycle[boundary, EdgeCount[boundary]]]
];


(* ::Section::Closed:: *)
(*Vertex Configuration Find*)


(* ::Subsection::Closed:: *)
(*color rules*)


colorRules = Join[
	MapThread[Rule,
	{
		{
			{12,12,14},
			{4,12,14},
			{4,12,12},
			{4,4,12},
			{4,4,4},
			{2,6,6},
			{2,2,6},
			{2,2,2}
		},
		Hue/@Range[1/9,8/9,1/9]
	}
	],
	{{3,9,13} -> Black},
	{{7,9,13} -> Lighter@Black},
	{{7,11,13} -> Lighter@Lighter@Black}
]


(* ::Subsection::Closed:: *)
(*Finder Function*)


vertexConfigurationFind[
		vertexConf_List : Join@@(#[{1,Sqrt[3]}][[All,All,3]]&/@{oneThirdVertexTheoremLis(*,TshapeList*)})
	][state_Association]:=
		Association[
		Function[conf,
		conf -> Select[getVerticesInf[state["code"]],MatchQ[#[[All,1]],{OrderlessPatternSequence@@conf}]&]
	] /@ vertexConf
]


vertexConfigurationFind[
	vertexConf_List : Join@@(#[{1,Sqrt[3]}][[All,All,3]]&/@{oneThirdVertexTheoremLis(*,TshapeList*)})
	][code_List]:=
		Association[
		Function[conf,
		conf -> Select[getVerticesInf[code],MatchQ[#[[All,1]],{OrderlessPatternSequence@@conf}]&]
	] /@ vertexConf
]


(* ::Subsection::Closed:: *)
(*Visualization Function*)


Options[quickShow] = Union[Options[Show], Options[show]];
quickShowVertexConfiguration[state_Association, opt : OptionsPattern[]]:=Show[
	show[state["code"], Sequence @@ FilterRules[{opt}, Options[show]]],
		Graphics[
		{
			EdgeForm[{Thin, Black}],
			KeyValueMap[
				If[Length[#2]>0, {Sort[#1]/.colorRules,Disk[Keys[#2], 0.5]}, Nothing]&,
				vertexConfigurationFind[oneThirdVertexTheoremLis[{1,Sqrt[3]}][[All,All,3]]][state["code"]]
			]
		}
	],
	Sequence @@ FilterRules[{opt}, Options[Show]]
]


Options[quickShow] = Union[Options[Show], Options[show]];
quickShowVertexConfiguration[code_List, opt : OptionsPattern[]] := Show[
	show[code, Sequence @@ FilterRules[{opt}, Options[show]]],
		Graphics[
		{
			EdgeForm[{Thin, Black}],
			KeyValueMap[
				If[Length[#2]>0, {Sort[#1]/.colorRules,Disk[Keys[#2], 0.5]}, Nothing]&,
				vertexConfigurationFind[oneThirdVertexTheoremLis[{1,Sqrt[3]}][[All,All,3]]][code]
			]
		}
	],
	Sequence @@ FilterRules[{opt}, Options[Show]]
]


(* ::Section::Closed:: *)
(*Cluster Code Manipulate*)


transformCode[vec_,r_][code_]:={vec+RotationMatrix[r*Pi/6] . #1,Mod[#2+If[TrueQ[#3],-r,r],12],#3,#4}&@@@code;


(* ::Section::Closed:: *)
(*End*)


End[]
EndPackage[]
