(* ::Package:: *)

BeginPackage["DepictTile`"]


(* ::Section::Closed:: *)
(*Symbol Declaration*)


{
	TileVertices,
	TileEdges,
	Tile
	}


{
	hatVertices,
	hatEdges,
	hat
}


{
	spectreVertices,
	spectreEdges,
	spectre
}


{
	turtleVertices,
	turtleEdges,
	turtle
}


{
	show,
	ChooseColor,
	step
}


{
	vertexAngles,
	oneFourthVertices,
	oneThirdVertices,
	oneHalfVertices,
	twoThirdVertices,
	threeFourthVertices
}


{
	canonicalTile,
	canonicalHat
}


(* ::Section::Closed:: *)
(*Begin Private*)


Begin["Private`"]


(* ::Section::Closed:: *)
(*General Tile*)


TileVertices[step_][or_,dir_,ref_,pt_] := With[{
basicVertices = AnglePath[{
		{step[[2]], -Pi/6+dir*Pi/6},
		{step[[2]], Pi/3},
		{step[[1]], Pi/2},
		{step[[1]], Pi/3},
		{step[[2]], -Pi/2},
		{step[[2]], Pi/3},
		{step[[1]], Pi/2},
		{step[[1]], -Pi/3},
		{step[[2]], Pi/2},
		{step[[2]], -Pi/3},
		{step[[1]], Pi/2},
		{step[[1]], Pi/3},
		{step[[1]], 0}
	}]
},
	Expand[(If[ref,{-#[[1]], #[[2]]}, #] & /@ ( basicVertices - Threaded[basicVertices[[pt]]] ) ) + Threaded[or]]
]


TileEdges[step_][or_,dir_,ref_,pt_] := Partition[TileVertices[step][or,dir,ref,pt], 2, 1, 1]


Tile[step_][or_,dir_,ref_,pt_] := Polygon[TileVertices[step][or,dir,ref,pt]]


(* ::Section::Closed:: *)
(*Hat Tile*)


(* ::Input::Initialization::Plain:: *)
vertexAngles=<|1->3/4,2->1/3,3->1/4,4->1/3,5->3/4,6->1/3,7->1/4,8->2/3,9->1/4,10->2/3,11->1/4,12->1/3,13->1/2,14->1/3|>;


(* ::Input::Initialization::Plain:: *)
hatVertices:=TileVertices[{1, Sqrt[3]}];
hatEdges:=TileEdges[{1, Sqrt[3]}];
hat:=Tile[{1, Sqrt[3]}];


(* ::Input::Initialization::Plain:: *)
oneFourthVertices=Keys[Select[vertexAngles,#==1/4&]];


(* ::Input::Initialization::Plain:: *)
oneThirdVertices=Keys[Select[vertexAngles,#==1/3&]];


(* ::Input::Initialization::Plain:: *)
oneHalfVertices=Keys[Select[vertexAngles,#==1/2&]];


(* ::Input::Initialization::Plain:: *)
twoThirdVertices=Keys[Select[vertexAngles,#==2/3&]];


(* ::Input::Initialization::Plain:: *)
threeFourthVertices=Keys[Select[vertexAngles,#==3/4&]];


(* ::Section::Closed:: *)
(*Turtle Tile*)


turtleVertices := TileVertices[{Sqrt[3], 1}];
turtleEdges := TileEdges[{Sqrt[3],1}];
turtle := Tile[{Sqrt[3], 1}];


(* ::Section::Closed:: *)
(*Spectre Tile*)


spectreVertices := TileVertices[{1, 1}];
spectreEdges := TileEdges[{1,1}];
spectre := Tile[{1, 1}];


(* ::Section::Closed:: *)
(*Visualization*)


(* ::Input::Initialization::Plain:: *)
pointColors=Most[Hue/@Range[0,1,1/(21)]];
coloredPoint[pos_,i_]:={pointColors[[i]],Point[pos]};


(* ::Input::Initialization::Plain:: *)
color[1]:=Lighter@Blue;
color[2]:=Darker@Black;
color[3]:=Lighter@Yellow;
color[4]:=Darker@Brown;


(* ::Input::Initialization::Plain:: *)
Options[show]=Join[{ChooseColor->False,EdgeForm->Black,step->{1, Sqrt[3]}},Options[Graphics]];

show[{}]:={};

show[tiles_List,opt:OptionsPattern[]]:=show[{},tiles,opt]/;opt =!= {}

show[newtiles_List,state_List,opt:OptionsPattern[]]:= Block[
{
	colorList=color/@Range[4],
	cc=OptionValue[ChooseColor],
	edgeForm=EdgeForm[OptionValue[EdgeForm]]
},
	
	If[cc=!=False,colorList[[;;Length[cc]]]=cc];

	Graphics[
		Join[
			state/.{
					{pos_,or_,False,v_}:>
						{Opacity[.5],edgeForm,colorList[[1]],Tile[OptionValue[step]][pos,or,False,v]},
					{pos_,or_,True,v_}:>
						{Opacity[.5],edgeForm,colorList[[2]],Tile[OptionValue[step]][pos,or,True,v]}
			},
			 newtiles/.{
					{pos_,or_,False,v_}:>
						{Opacity[.5],edgeForm,colorList[[3]],Tile[OptionValue[step]][pos,or,False,v]},
					{pos_,or_,True,v_}:>
						{Opacity[.5],edgeForm,colorList[[4]],Tile[OptionValue[step]][pos,or,True,v]}
			}
			],opt
	]
]




(* ::Section::Closed:: *)
(*Helper Functions*)


canonicalTile[step_][or_,dir_,ref_,pt_]:={Expand[TileVertices[step][or, dir, ref, pt][[1]]], dir, ref, 1}


canonicalHat[or_,dir_,ref_,pt_]:={hatVertices[or,dir,ref,pt][[1]], dir, ref, 1}


(* ::Section::Closed:: *)
(*End*)


End[]
EndPackage[]
