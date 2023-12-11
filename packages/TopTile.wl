(* ::Package:: *)

BeginPackage["TopTile`",{"DepictTile`"}]


(* ::Section::Closed:: *)
(*Symbol Declaration*)


{
	formatTile,
	locateTile,
	depictTile
}


{
	codePreprocess
}


{
	tilingTopologicalGraph,
	updateVertexCoordinates,
	buildClusterCodes
}


(* ::Section::Closed:: *)
(*Some tiles Information*)


h1Tile=<|"boundary" -> {{-(3/2), Sqrt[3]/2}, {0, 0}, {3/2, Sqrt[3]/2}, {1, Sqrt[3]}, {0, Sqrt[3]}, {0, 2 Sqrt[3]}, {-(3/2), 5 (Sqrt[3]/2)}, {-2, 2 Sqrt[3]}, {-3, 2 Sqrt[3]}, {-3, Sqrt[3]}, {-(9/2), Sqrt[3]/2}, {-4, 0}, {-3, 0}, {-2, 0}}, "vertices" -> {{0, 0}, {1, Sqrt[3]}, {0, 2 Sqrt[3]}, {-4, 0}, {-2, 0}}|>;
h2Tile=<|"boundary" -> {{-(3/2), 5 (Sqrt[3]/2)}, {-1, 3 Sqrt[3]}, {-(3/2), 7 (Sqrt[3]/2)}, {-3, 3 Sqrt[3]}, {-(9/2), 7 (Sqrt[3]/2)}, {-5, 3 Sqrt[3]}, {-6, 3 Sqrt[3]}, {-6, 2 Sqrt[3]}, {-(9/2), 3 (Sqrt[3]/2)}, {-5, Sqrt[3]}, {-(9/2), Sqrt[3]/2}, {-4, 0}, {-3, 0}, {-2, 0}, {-(3/2), Sqrt[3]/2}, {0, 0}, {3/2, Sqrt[3]/2}, {1, Sqrt[3]}, {0, Sqrt[3]}, {0, 2 Sqrt[3]}}, "vertices" -> {{0, 0}, {1, Sqrt[3]}, {0, 2 Sqrt[3]}, {-4, 0}, {-2, 0}}|>;
h8Tile=<|"boundary" -> {{-1, 3^Rational[1, 2]}, {Rational[1, 2], Rational[3, 2] 3^Rational[1, 2]}, {0, 2 3^Rational[1, 2]}, {Rational[1, 2], Rational[5, 2] 3^Rational[1, 2]}, {1, 3 3^Rational[1, 2]}, {Rational[1, 2], Rational[7, 2] 3^Rational[1, 2]}, {2, 4 3^Rational[1, 2]}, {2, 5 3^Rational[1, 2]}, {1, 5 3^Rational[1, 2]}, {Rational[1, 2], Rational[11, 2] 3^Rational[1, 2]}, {0, 6 3^Rational[1, 2]}, {-1, 6 3^Rational[1, 2]}, {-1, 7 3^Rational[1, 2]}, {Rational[-5, 2], Rational[15, 2] 3^Rational[1, 2]}, {-3, 7 3^Rational[1, 2]}, {Rational[-5, 2], Rational[13, 2] 3^Rational[1, 2]}, {-4, 6 3^Rational[1, 2]}, {Rational[-11, 2], Rational[13, 2] 3^Rational[1, 2]}, {-6, 6 3^Rational[1, 2]}, {-7, 6 3^Rational[1, 2]}, {-7, 5 3^Rational[1, 2]}, {Rational[-17, 2], Rational[9, 2] 3^Rational[1, 2]}, {-8, 4 3^Rational[1, 2]}, {Rational[-17, 2], Rational[7, 2] 3^Rational[1, 2]}, {-9, 3 3^Rational[1, 2]}, {Rational[-17, 2], Rational[5, 2] 3^Rational[1, 2]}, {-10, 2 3^Rational[1, 2]}, {-10, 3^Rational[1, 2]}, {-9, 3^Rational[1, 2]}, {Rational[-17, 2], Rational[1, 2] 3^Rational[1, 2]}, {-8, 0}, {-7, 0}, {-7, -3^Rational[1, 2]}, {Rational[-11, 2], Rational[-3, 2] 3^Rational[1, 2]}, {-5, -3^Rational[1, 2]}, {-4, -3^Rational[1, 2]}, {-3, -3^Rational[1, 2]}, {Rational[-5, 2], Rational[-1, 2] 3^Rational[1, 2]}, {-1, -3^Rational[1, 2]}, {Rational[1, 2], Rational[-1, 2] 3^Rational[1, 2]}, {0, 0}, {-1, 0}}, "vertices" -> {{0, 0}, {2, 4 3^Rational[1, 2]}, {-3, 7 3^Rational[1, 2]}, {-10, 2 3^Rational[1, 2]}, {-7, -3^Rational[1, 2]}}|>;
h7Tile=<|"boundary" -> {{Rational[-5, 2], Rational[9, 2] 3^Rational[1, 2]}, {-4, 4 3^Rational[1, 2]}, {Rational[-11, 2], Rational[9, 2] 3^Rational[1, 2]}, {-6, 4 3^Rational[1, 2]}, {-7, 4 3^Rational[1, 2]}, {-8, 4 3^Rational[1, 2]}, {Rational[-17, 2], Rational[7, 2] 3^Rational[1, 2]}, {-9, 3 3^Rational[1, 2]}, {Rational[-17, 2], Rational[5, 2] 3^Rational[1, 2]}, {-10, 2 3^Rational[1, 2]}, {-10, 3^Rational[1, 2]}, {-9, 3^Rational[1, 2]}, {Rational[-17, 2], Rational[1, 2] 3^Rational[1, 2]}, {-8, 0}, {-7, 0}, {-7, -3^Rational[1, 2]}, {Rational[-11, 2], Rational[-3, 2] 3^Rational[1, 2]}, {-5, -3^Rational[1, 2]}, {-4, -3^Rational[1, 2]}, {-3, -3^Rational[1, 2]}, {Rational[-5, 2], Rational[-1, 2] 3^Rational[1, 2]}, {-1, -3^Rational[1, 2]}, {Rational[1, 2], Rational[-1, 2] 3^Rational[1, 2]}, {0, 0}, {-1, 0}, {-1, 3^Rational[1, 2]}, {Rational[1, 2], Rational[3, 2] 3^Rational[1, 2]}, {0, 2 3^Rational[1, 2]}, {Rational[1, 2], Rational[5, 2] 3^Rational[1, 2]}, {1, 3 3^Rational[1, 2]}, {Rational[1, 2], Rational[7, 2] 3^Rational[1, 2]}, {2, 4 3^Rational[1, 2]}, {2, 5 3^Rational[1, 2]}, {1, 5 3^Rational[1, 2]}, {Rational[1, 2], Rational[11, 2] 3^Rational[1, 2]}, {0, 6 3^Rational[1, 2]}, {-1, 6 3^Rational[1, 2]}, {-1, 7 3^Rational[1, 2]}, {Rational[-5, 2], Rational[15, 2] 3^Rational[1, 2]}, {-3, 7 3^Rational[1, 2]}, {Rational[-5, 2], Rational[13, 2] 3^Rational[1, 2]}, {-4, 6 3^Rational[1, 2]}, {-4, 5 3^Rational[1, 2]}, {-3, 5 3^Rational[1, 2]}}, "vertices" -> {{0, 0}, {2, 4 3^Rational[1, 2]}, {-3, 7 3^Rational[1, 2]}, {-10, 2 3^Rational[1, 2]}, {-7, -3^Rational[1, 2]}}|>;


h8Supertile = <|"boundary" -> {{-8, (-4) Sqrt[3]}, {-(13/2), -(9 (Sqrt[3]/2))}, {-6, (-4) Sqrt[3]}, {-5, (-4) Sqrt[3]}, {-4, (-4) Sqrt[3]}, {-(7/2), -(7 (Sqrt[3]/2))}, {-2, (-4) Sqrt[3]}, {-(1/2), -(7 (Sqrt[3]/2))}, {-1, (-3) Sqrt[3]}, {-(1/2), -(5 (Sqrt[3]/2))}, {0, (-2) Sqrt[3]}, {-(1/2), -(3 (Sqrt[3]/2))}, {1, -Sqrt[3]}, {1, 0}, {0, 0}, {-(1/2), -(Sqrt[3]/2)}, {-2, 0}, {-2, Sqrt[3]}, {-3, Sqrt[3]}, {-(7/2), 3 (Sqrt[3]/2)}, {-4, 2 Sqrt[3]}, {-5, 2 Sqrt[3]}, {-5, 3 Sqrt[3]}, {-(7/2), 7 (Sqrt[3]/2)}, {-4, 4 Sqrt[3]}, {-(7/2), 9 (Sqrt[3]/2)}, {-3, 5 Sqrt[3]}, {-(7/2), 11 (Sqrt[3]/2)}, {-2, 6 Sqrt[3]}, {-2, 7 Sqrt[3]}, {-3, 7 Sqrt[3]}, {-(7/2), 15 (Sqrt[3]/2)}, {-4, 8 Sqrt[3]}, {-5, 8 Sqrt[3]}, {-5, 9 Sqrt[3]}, {-(13/2), 19 (Sqrt[3]/2)}, {-7, 9 Sqrt[3]}, {-(13/2), 17 (Sqrt[3]/2)}, {-8, 8 Sqrt[3]}, {-(19/2), 17 (Sqrt[3]/2)}, {-10, 8 Sqrt[3]}, {-11, 8 Sqrt[3]}, {-12, 8 Sqrt[3]}, {-(25/2), 15 (Sqrt[3]/2)}, {-14, 8 Sqrt[3]}, {-(31/2), 15 (Sqrt[3]/2)}, {-15, 7 Sqrt[3]}, {-(31/2), 13 (Sqrt[3]/2)}, {-16, 6 Sqrt[3]}, {-(31/2), 11 (Sqrt[3]/2)}, {-17, 5 Sqrt[3]}, {-17, 4 Sqrt[3]}, {-16, 4 Sqrt[3]}, {-(31/2), 7 (Sqrt[3]/2)}, {-17, 3 Sqrt[3]}, {-(37/2), 7 (Sqrt[3]/2)}, {-19, 3 Sqrt[3]}, {-20, 3 Sqrt[3]}, {-20, 2 Sqrt[3]}, {-(43/2), 3 (Sqrt[3]/2)}, {-21, Sqrt[3]}, {-(43/2), Sqrt[3]/2}, {-22, 0}, {-(43/2), -(Sqrt[3]/2)}, {-23, -Sqrt[3]}, {-(49/2), -(Sqrt[3]/2)}, {-25, -Sqrt[3]}, {-26, -Sqrt[3]}, {-27, -Sqrt[3]}, {-(55/2), -(3 (Sqrt[3]/2))}, {-29, -Sqrt[3]}, {-(61/2), -(3 (Sqrt[3]/2))}, {-30, (-2) Sqrt[3]}, {-(61/2), -(5 (Sqrt[3]/2))}, {-31, (-3) Sqrt[3]}, {-(61/2), -(7 (Sqrt[3]/2))}, {-32, (-4) Sqrt[3]}, {-32, (-5) Sqrt[3]}, {-31, (-5) Sqrt[3]}, {-(61/2), -(9 (Sqrt[3]/2))}, {-29, (-5) Sqrt[3]}, {-29, (-6) Sqrt[3]}, {-28, (-6) Sqrt[3]}, {-(55/2), -(13 (Sqrt[3]/2))}, {-27, (-7) Sqrt[3]}, {-26, (-7) Sqrt[3]}, {-26, (-8) Sqrt[3]}, {-(55/2), -(17 (Sqrt[3]/2))}, {-27, (-9) Sqrt[3]}, {-(55/2), -(19 (Sqrt[3]/2))}, {-28, (-10) Sqrt[3]}, {-(55/2), -(21 (Sqrt[3]/2))}, {-29, (-11) Sqrt[3]}, {-29, (-12) Sqrt[3]}, {-28, (-12) Sqrt[3]}, {-(55/2), -(25 (Sqrt[3]/2))}, {-27, (-13) Sqrt[3]}, {-26, (-13) Sqrt[3]}, {-26, (-14) Sqrt[3]}, {-(49/2), -(29 (Sqrt[3]/2))}, {-24, (-14) Sqrt[3]}, {-(49/2), -(27 (Sqrt[3]/2))}, {-23, (-13) Sqrt[3]}, {-(43/2), -(27 (Sqrt[3]/2))}, {-21, (-13) Sqrt[3]}, {-20, (-13) Sqrt[3]}, {-19, (-13) Sqrt[3]}, {-(37/2), -(25 (Sqrt[3]/2))}, {-17, (-13) Sqrt[3]}, {-17, (-14) Sqrt[3]}, {-16, (-14) Sqrt[3]}, {-(31/2), -(29 (Sqrt[3]/2))}, {-15, (-15) Sqrt[3]}, {-14, (-15) Sqrt[3]}, {-14, (-16) Sqrt[3]}, {-(25/2), -(33 (Sqrt[3]/2))}, {-12, (-16) Sqrt[3]}, {-11, (-16) Sqrt[3]}, {-10, (-16) Sqrt[3]}, {-(19/2), -(31 (Sqrt[3]/2))}, {-8, (-16) Sqrt[3]}, {-(13/2), -(31 (Sqrt[3]/2))}, {-7, (-15) Sqrt[3]}, {-8, (-15) Sqrt[3]}, {-8, (-14) Sqrt[3]}, {-(13/2), -(27 (Sqrt[3]/2))}, {-7, (-13) Sqrt[3]}, {-(13/2), -(25 (Sqrt[3]/2))}, {-6, (-12) Sqrt[3]}, {-(13/2), -(23 (Sqrt[3]/2))}, {-5, (-11) Sqrt[3]}, {-5, (-10) Sqrt[3]}, {-6, (-10) Sqrt[3]}, {-(13/2), -(19 (Sqrt[3]/2))}, {-7, (-9) Sqrt[3]}, {-8, (-9) Sqrt[3]}, {-8, (-8) Sqrt[3]}, {-(19/2), -(15 (Sqrt[3]/2))}, {-10, (-8) Sqrt[3]}, {-11, (-8) Sqrt[3]}, {-11, (-7) Sqrt[3]}, {-(19/2), -(13 (Sqrt[3]/2))}, {-10, (-6) Sqrt[3]}, {-(19/2), -(11 (Sqrt[3]/2))}, {-9, (-5) Sqrt[3]}, {-(19/2), -(9 (Sqrt[3]/2))}}, "vertices" -> {{-5,-11 Sqrt[3]},{0,0},{-14,8 Sqrt[3]},{-31,-5 Sqrt[3]},{-24,-14 Sqrt[3]}}|>;
h7Supertile = <|"boundary" -> {{-8, (-4) Sqrt[3]}, {-(13/2), -(9 (Sqrt[3]/2))}, {-6, (-4) Sqrt[3]}, {-5, (-4) Sqrt[3]}, {-4, (-4) Sqrt[3]}, {-(7/2), -(7 (Sqrt[3]/2))}, {-2, (-4) Sqrt[3]}, {-(1/2), -(7 (Sqrt[3]/2))}, {-1, (-3) Sqrt[3]}, {-(1/2), -(5 (Sqrt[3]/2))}, {0, (-2) Sqrt[3]}, {-(1/2), -(3 (Sqrt[3]/2))}, {1, -Sqrt[3]}, {1, 0}, {0, 0}, {-(1/2), -(Sqrt[3]/2)}, {-2, 0}, {-2, Sqrt[3]}, {-3, Sqrt[3]}, {-(7/2), 3 (Sqrt[3]/2)}, {-4, 2 Sqrt[3]}, {-5, 2 Sqrt[3]}, {-5, 3 Sqrt[3]}, {-(7/2), 7 (Sqrt[3]/2)}, {-4, 4 Sqrt[3]}, {-(7/2), 9 (Sqrt[3]/2)}, {-3, 5 Sqrt[3]}, {-(7/2), 11 (Sqrt[3]/2)}, {-2, 6 Sqrt[3]}, {-2, 7 Sqrt[3]}, {-3, 7 Sqrt[3]}, {-(7/2), 15 (Sqrt[3]/2)}, {-4, 8 Sqrt[3]}, {-5, 8 Sqrt[3]}, {-5, 9 Sqrt[3]}, {-(13/2), 19 (Sqrt[3]/2)}, {-7, 9 Sqrt[3]}, {-(13/2), 17 (Sqrt[3]/2)}, {-8, 8 Sqrt[3]}, {-(19/2), 17 (Sqrt[3]/2)}, {-10, 8 Sqrt[3]}, {-11, 8 Sqrt[3]}, {-12, 8 Sqrt[3]}, {-(25/2), 15 (Sqrt[3]/2)}, {-14, 8 Sqrt[3]}, {-(31/2), 15 (Sqrt[3]/2)}, {-15, 7 Sqrt[3]}, {-(31/2), 13 (Sqrt[3]/2)}, {-16, 6 Sqrt[3]}, {-(31/2), 11 (Sqrt[3]/2)}, {-17, 5 Sqrt[3]}, {-17, 4 Sqrt[3]}, {-16, 4 Sqrt[3]}, {-(31/2), 9 (Sqrt[3]/2)}, {-14, 4 Sqrt[3]}, {-14, 3 Sqrt[3]}, {-13, 3 Sqrt[3]}, {-(25/2), 5 (Sqrt[3]/2)}, {-12, 2 Sqrt[3]}, {-11, 2 Sqrt[3]}, {-11, Sqrt[3]}, {-(25/2), Sqrt[3]/2}, {-12, 0}, {-(25/2), -(Sqrt[3]/2)}, {-13, -Sqrt[3]}, {-(25/2), -(3 (Sqrt[3]/2))}, {-14, (-2) Sqrt[3]}, {-14, (-3) Sqrt[3]}, {-13, (-3) Sqrt[3]}, {-(25/2), -(7 (Sqrt[3]/2))}, {-14, (-4) Sqrt[3]}, {-(31/2), -(7 (Sqrt[3]/2))}, {-16, (-4) Sqrt[3]}, {-17, (-4) Sqrt[3]}, {-18, (-4) Sqrt[3]}, {-(37/2), -(9 (Sqrt[3]/2))}, {-20, (-4) Sqrt[3]}, {-20, (-3) Sqrt[3]}, {-21, (-3) Sqrt[3]}, {-(43/2), -(5 (Sqrt[3]/2))}, {-22, (-2) Sqrt[3]}, {-23, (-2) Sqrt[3]}, {-23, -Sqrt[3]}, {-(49/2), -(Sqrt[3]/2)}, {-25, -Sqrt[3]}, {-26, -Sqrt[3]}, {-27, -Sqrt[3]}, {-(55/2), -(3 (Sqrt[3]/2))}, {-29, -Sqrt[3]}, {-(61/2), -(3 (Sqrt[3]/2))}, {-30, (-2) Sqrt[3]}, {-(61/2), -(5 (Sqrt[3]/2))}, {-31, (-3) Sqrt[3]}, {-(61/2), -(7 (Sqrt[3]/2))}, {-32, (-4) Sqrt[3]}, {-32, (-5) Sqrt[3]}, {-31, (-5) Sqrt[3]}, {-(61/2), -(9 (Sqrt[3]/2))}, {-29, (-5) Sqrt[3]}, {-29, (-6) Sqrt[3]}, {-28, (-6) Sqrt[3]}, {-(55/2), -(13 (Sqrt[3]/2))}, {-27, (-7) Sqrt[3]}, {-26, (-7) Sqrt[3]}, {-26, (-8) Sqrt[3]}, {-(55/2), -(17 (Sqrt[3]/2))}, {-27, (-9) Sqrt[3]}, {-(55/2), -(19 (Sqrt[3]/2))}, {-28, (-10) Sqrt[3]}, {-(55/2), -(21 (Sqrt[3]/2))}, {-29, (-11) Sqrt[3]}, {-29, (-12) Sqrt[3]}, {-28, (-12) Sqrt[3]}, {-(55/2), -(25 (Sqrt[3]/2))}, {-27, (-13) Sqrt[3]}, {-26, (-13) Sqrt[3]}, {-26, (-14) Sqrt[3]}, {-(49/2), -(29 (Sqrt[3]/2))}, {-24, (-14) Sqrt[3]}, {-(49/2), -(27 (Sqrt[3]/2))}, {-23, (-13) Sqrt[3]}, {-(43/2), -(27 (Sqrt[3]/2))}, {-21, (-13) Sqrt[3]}, {-20, (-13) Sqrt[3]}, {-19, (-13) Sqrt[3]}, {-(37/2), -(25 (Sqrt[3]/2))}, {-17, (-13) Sqrt[3]}, {-17, (-14) Sqrt[3]}, {-16, (-14) Sqrt[3]}, {-(31/2), -(29 (Sqrt[3]/2))}, {-15, (-15) Sqrt[3]}, {-14, (-15) Sqrt[3]}, {-14, (-16) Sqrt[3]}, {-(25/2), -(33 (Sqrt[3]/2))}, {-12, (-16) Sqrt[3]}, {-11, (-16) Sqrt[3]}, {-10, (-16) Sqrt[3]}, {-(19/2), -(31 (Sqrt[3]/2))}, {-8, (-16) Sqrt[3]}, {-(13/2), -(31 (Sqrt[3]/2))}, {-7, (-15) Sqrt[3]}, {-8, (-15) Sqrt[3]}, {-8, (-14) Sqrt[3]}, {-(13/2), -(27 (Sqrt[3]/2))}, {-7, (-13) Sqrt[3]}, {-(13/2), -(25 (Sqrt[3]/2))}, {-6, (-12) Sqrt[3]}, {-(13/2), -(23 (Sqrt[3]/2))}, {-5, (-11) Sqrt[3]}, {-5, (-10) Sqrt[3]}, {-6, (-10) Sqrt[3]}, {-(13/2), -(19 (Sqrt[3]/2))}, {-7, (-9) Sqrt[3]}, {-8, (-9) Sqrt[3]}, {-8, (-8) Sqrt[3]}, {-(19/2), -(15 (Sqrt[3]/2))}, {-10, (-8) Sqrt[3]}, {-11, (-8) Sqrt[3]}, {-11, (-7) Sqrt[3]}, {-(19/2), -(13 (Sqrt[3]/2))}, {-10, (-6) Sqrt[3]}, {-(19/2), -(11 (Sqrt[3]/2))}, {-9, (-5) Sqrt[3]}, {-(19/2), -(9 (Sqrt[3]/2))}}, "vertices" -> {{-5,-11 Sqrt[3]},{0,0},{-14,8 Sqrt[3]},{-31,-5 Sqrt[3]},{-24,-14 Sqrt[3]}}|>;


hexagonTile = <|"boundary" -> CirclePoints[6], "vertices" -> CirclePoints[6][[{1,2,3,5,6}]]|>


(* ::Section::Closed:: *)
(*Begin Private*)


Begin["Private`"]


(* ::Section::Closed:: *)
(*format data structure association*)


formatTile[polygon_Polygon,vertices_List]:=<|"boundary"->First[polygon],"vertices"->vertices|>;


formatTile[boundary_List,vertices_List]:=<|"boundary"->boundary,"vertices"->vertices|>;


(* ::Section::Closed:: *)
(*Locate Tile*)


locateTile[tile_Association][pos_List,dir_Integer,pt_Integer]:=With[{
	transformFunction=TranslationTransform[pos]@*RotationTransform[dir*Pi/6]@*TranslationTransform[-tile["vertices"][[pt]]]
},
	transformFunction/@tile
]


(* ::Section::Closed:: *)
(*Visualize tile*)


Options[depictTile]={"ShowPoints" -> True, "ChooseColor" -> Lighter@Blue, "PointSize"->.3, "EdgeForm" -> Black}
depictTile[tile_Association, opt:OptionsPattern[]] := Graphics[{
	Opacity[.5], EdgeForm[OptionValue["EdgeForm"]], OptionValue["ChooseColor"], Polygon[tile["boundary"]],
	If[
	TrueQ[OptionValue["ShowPoints"]],
	Sequence@@{
		ColorNegate[OptionValue["ChooseColor"]],
		Disk[tile["vertices"], OptionValue["PointSize"]]
		},
		Nothing]
}]


(* ::Section::Closed:: *)
(*Code Preprocessor*)


(* ::Text:: *)
(*Transform traditional hat tile codes into 1/3 control points version.*)


codePreprocess = Function[codes,
With[{refs=Cases[codes,reftile_?(MemberQ[True]):>First[hatVertices@@reftile]]},
{
		(hatVertices[#[[1]],#[[2]],False,#[[4]]])[[2]],
		#[[2]],1,!#[[3]]
	}&/@
		Replace[
			DeleteCases[codes,_?(MemberQ[True])],
			tile_/;MemberQ[refs,(hatVertices@@tile)[[9]]]:>({tile[[1]],tile[[2]],True,tile[[4]]}),
			{1}
		]
	]
];


(* ::Section::Closed:: *)
(*Tiling topological graph constructor*)


tilingTopologicalGraph[
tileVertices_Association/;MatchQ[Keys[tileVertices],{True,False}|{False,True}]
][codes_]:=Module[
{
	verticesInf=<||>,
	edgesInf={},
	coordinatesToIndex=<||>,
	cnt=0(*vertex counter*)
},
	Scan[
	Function[
		code,
		With[
			{vs=locateTile[tileVertices[code[[4]]]][Sequence@@code[[;;3]]]["vertices"]},
			
			(*Index vertices*)
			MapIndexed[
				If[!KeyExistsQ[coordinatesToIndex,#1],
					AssociateTo[coordinatesToIndex,#1->(++cnt)]
				]&,
			vs];
			
			(*Add edges*)
			AppendTo[edgesInf,
				UndirectedEdge[
					coordinatesToIndex[vs[[#1]]],
					coordinatesToIndex[vs[[#2]]],
					{#1,#2,code[[{2,4}]]}]
				]&@@@Partition[Range[Length[vs]],2,1,1];(*Subsets[Range[5],{2}];*)
			
			(*Add vertex configuration information*)
			MapIndexed[
				If[
					KeyExistsQ[verticesInf,coordinatesToIndex[#1]],
					AppendTo[verticesInf[coordinatesToIndex[#1]],First[#2]->code[[{2,4}]]],
					AssociateTo[verticesInf,coordinatesToIndex[#1]->{First[#2]->code[[{2,4}]]}]
				]&,
			vs
			]
		]
	],
		codes
	];
	<|
		"vertex"->verticesInf,
		"edge"->edgesInf,
		"coordinates"->coordinatesToIndex
	|>
]


(* ::Section::Closed:: *)
(*Update vertices coordinates with tiles and graph information*)


(* ::Text:: *)
(*tileVertices is an Association with Key True and False for two types of tiles.*)


(* ::Text:: *)
(*edges are information from topological graph*)


updateVertexCoordinates[
tileVertices_Association/;MatchQ[Keys[tileVertices],{True,False}|{False,True}]
][edges_List]:=Module[{
	(*choose an oringal point arbitrarily*)
	IndexToCoordinates=<|1->{0,0}|>,
	(*create a queue for breadth first search to update vertex coordinates*)
	q=CreateDataStructure["Queue"]
},
	q["Push",1];
	While[!q["EmptyQ"],

		Block[{u=q["Pop"],vs},
		
		vs=IncidenceList[edges,u]/.{
			UndirectedEdge[u,v_,dir_]:>Rule[dir,v],
			UndirectedEdge[v_,u,dirInv_] :> Rule[dirInv[[{2,1,3}]],v]
			};

		Scan[
			If[
				(*if the vertex coordinates has not been calculated*)
				!KeyExistsQ[IndexToCoordinates, #[[2]]],
			
				(*update the coordinates*)
				AssociateTo[
					IndexToCoordinates,
						#[[2]]->Plus[
							IndexToCoordinates[u],
								Subtract @@ ( Part[
								tileVertices[#[[1,3,2]]],
								#[[1,{2,1}]]
							]) . Transpose[RotationMatrix[#[[1,3,1]] Pi/6]]
					]
				];
				(*push a new vertex*)
				q["Push",#[[2]]]
			]&,
				vs
			]
		]
	];
	IndexToCoordinates
]


(* ::Section::Closed:: *)
(*Build cluster codes from given kinds of tiles and top-graph*)


(* ::Text:: *)
(*Only control vertices information from tiles, and edges information from graph are really needed.*)


buildClusterCodes[
tile1_Association?(KeyExistsQ["vertices"]),tile2_Association?(KeyExistsQ["vertices"])
][edges_List]:=With[
	{
		coordinates=updateVertexCoordinates[<|False->tile1["vertices"],True->tile2["vertices"]|>][edges]
	},
		Sow[coordinates,"coordinates"];
		(*only need every first vertex of tile to build its code, not duplicate and lo*)
		Cases[
		edges,
		UndirectedEdge[u_,v_,{1,p2_,code_List}]:>{coordinates[u],code[[1]],1,code[[2]]}
	]
];
buildClusterCodes[
	tile1_Association?(KeyExistsQ["vertices"]),
	tile2_Association?(KeyExistsQ["vertices"])
][topGraph_Association?(KeyExistsQ["edge"])]:=buildClusterCodes[tile1,tile2][topGraph["edge"]]


(* ::Section::Closed:: *)
(*End*)


End[]


EndPackage[]
