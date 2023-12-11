(* ::Package:: *)

BeginPackage["HappyCluster`"]


(* ::Section::Closed:: *)
(*Symbol Declaration*)


{
H2poly,
H1poly,
H8poly,
H7poly,
H7superPoly,
H8superPoly
}


{
metaTile
}


{
cluster,
clusterCode,
clusterVertices,
clusterInnerVertices,
clusterVertexAngles,
canonicalCluster
}


{
superCluster,
superClusterVertices,
superClusterCode
}


{
visualize,
ChooseColor,
clusterTilingState,
drawClusterInfomration
}


{
clusterVertexAngles,
oneThirdClusterVertex,
twoThirdClusterVertex,
oneHalfClusterVertex,
oneFourthClusterVertex,
threeFourthClusterVertex
}


{
oneThirdTheoremListCluster,
oneThirdAndTwoThirdTheoremListCluster
}


{
clusterPointsInformation,
generatorH8,
growH8Tiling,
branchNumLimit,
ChoosePoints
}


(* ::Section::Closed:: *)
(*Begin Private*)


Begin["Private`"]


(* ::Section::Closed:: *)
(*Tiling and Polygon Information*)


H2poly=Polygon[{{3, (-5) 3^Rational[1, 2]}, {Rational[9, 2], Rational[-11, 2] 3^Rational[1, 2]}, {6, (-5) 3^Rational[1, 2]}, {Rational[11, 2], Rational[-9, 2] 3^Rational[1, 2]}, {Rational[9, 2], Rational[-9, 2] 3^Rational[1, 2]}, {Rational[9, 2], Rational[-7, 2] 3^Rational[1, 2]}, {3, (-3) 3^Rational[1, 2]}, {Rational[7, 2], Rational[-5, 2] 3^Rational[1, 2]}, {3, (-2) 3^Rational[1, 2]}, {Rational[3, 2], Rational[-5, 2] 3^Rational[1, 2]}, {0, (-2) 3^Rational[1, 2]}, {Rational[-1, 2], Rational[-5, 2] 3^Rational[1, 2]}, {Rational[-3, 2], Rational[-5, 2] 3^Rational[1, 2]}, {Rational[-3, 2], Rational[-7, 2] 3^Rational[1, 2]}, {0, (-4) 3^Rational[1, 2]}, {Rational[-1, 2], Rational[-9, 2] 3^Rational[1, 2]}, {0, (-5) 3^Rational[1, 2]}, {Rational[1, 2], Rational[-11, 2] 3^Rational[1, 2]}, {Rational[3, 2], Rational[-11, 2] 3^Rational[1, 2]}, {Rational[5, 2], Rational[-11, 2] 3^Rational[1, 2]}}];
H1poly=Polygon[{{0, (-2) 3^Rational[1, 2]}, {Rational[3, 2], Rational[-5, 2] 3^Rational[1, 2]}, {3, (-2) 3^Rational[1, 2]}, {Rational[5, 2], Rational[-3, 2] 3^Rational[1, 2]}, {Rational[3, 2], Rational[-3, 2] 3^Rational[1, 2]}, {Rational[3, 2], Rational[-1, 2] 3^Rational[1, 2]}, {0, 0}, {Rational[-1, 2], Rational[-1, 2] 3^Rational[1, 2]}, {Rational[-3, 2], Rational[-1, 2] 3^Rational[1, 2]}, {Rational[-3, 2], Rational[-3, 2] 3^Rational[1, 2]}, {-3, (-2) 3^Rational[1, 2]}, {Rational[-5, 2], Rational[-5, 2] 3^Rational[1, 2]}, {Rational[-3, 2], Rational[-5, 2] 3^Rational[1, 2]}, {Rational[-1, 2], Rational[-5, 2] 3^Rational[1, 2]}}, {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14}];


H8poly=Polygon[{{3, (-7) Sqrt[3]}, {9/2, -(15 (Sqrt[3]/2))}, {6, (-7) Sqrt[3]}, {11/2, -(13 (Sqrt[3]/2))}, {9/2, -(13 (Sqrt[3]/2))}, {9/2, -(11 (Sqrt[3]/2))}, {6, (-5) Sqrt[3]}, {11/2, -(9 (Sqrt[3]/2))}, {6, (-4) Sqrt[3]}, {13/2, -(7 (Sqrt[3]/2))}, {6, (-3) Sqrt[3]}, {15/2, -(5 (Sqrt[3]/2))}, {15/2, -(3 (Sqrt[3]/2))}, {13/2, -(3 (Sqrt[3]/2))}, {6, -Sqrt[3]}, {11/2, -(Sqrt[3]/2)}, {9/2, -(Sqrt[3]/2)}, {9/2, Sqrt[3]/2}, {3, Sqrt[3]}, {5/2, Sqrt[3]/2}, {3, 0}, {3/2, -(Sqrt[3]/2)}, {0, 0}, {-(1/2), -(Sqrt[3]/2)}, {-(3/2), -(Sqrt[3]/2)}, {-(3/2), -(3 (Sqrt[3]/2))}, {-3, (-2) Sqrt[3]}, {-(5/2), -(5 (Sqrt[3]/2))}, {-3, (-3) Sqrt[3]}, {-(7/2), -(7 (Sqrt[3]/2))}, {-3, (-4) Sqrt[3]}, {-(9/2), -(9 (Sqrt[3]/2))}, {-(9/2), -(11 (Sqrt[3]/2))}, {-(7/2), -(11 (Sqrt[3]/2))}, {-3, (-6) Sqrt[3]}, {-(5/2), -(13 (Sqrt[3]/2))}, {-(3/2), -(13 (Sqrt[3]/2))}, {-(3/2), -(15 (Sqrt[3]/2))}, {0, (-8) Sqrt[3]}, {1/2, -(15 (Sqrt[3]/2))}, {3/2, -(15 (Sqrt[3]/2))}, {5/2, -(15 (Sqrt[3]/2))}}];
H7poly=Polygon[{{3, (-7) 3^Rational[1, 2]}, {Rational[9, 2], Rational[-15, 2] 3^Rational[1, 2]}, {6, (-7) 3^Rational[1, 2]}, {Rational[11, 2], Rational[-13, 2] 3^Rational[1, 2]}, {Rational[9, 2], Rational[-13, 2] 3^Rational[1, 2]}, {Rational[9, 2], Rational[-11, 2] 3^Rational[1, 2]}, {6, (-5) 3^Rational[1, 2]}, {Rational[11, 2], Rational[-9, 2] 3^Rational[1, 2]}, {6, (-4) 3^Rational[1, 2]}, {Rational[13, 2], Rational[-7, 2] 3^Rational[1, 2]}, {6, (-3) 3^Rational[1, 2]}, {Rational[15, 2], Rational[-5, 2] 3^Rational[1, 2]}, {Rational[15, 2], Rational[-3, 2] 3^Rational[1, 2]}, {Rational[13, 2], Rational[-3, 2] 3^Rational[1, 2]}, {6, -3^Rational[1, 2]}, {Rational[11, 2], Rational[-1, 2] 3^Rational[1, 2]}, {Rational[9, 2], Rational[-1, 2] 3^Rational[1, 2]}, {Rational[9, 2], Rational[1, 2] 3^Rational[1, 2]}, {3, 3^Rational[1, 2]}, {Rational[5, 2], Rational[1, 2] 3^Rational[1, 2]}, {3, 0}, {Rational[3, 2], Rational[-1, 2] 3^Rational[1, 2]}, {Rational[3, 2], Rational[-3, 2] 3^Rational[1, 2]}, {Rational[5, 2], Rational[-3, 2] 3^Rational[1, 2]}, {3, (-2) 3^Rational[1, 2]}, {Rational[3, 2], Rational[-5, 2] 3^Rational[1, 2]}, {0, (-2) 3^Rational[1, 2]}, {Rational[-1, 2], Rational[-5, 2] 3^Rational[1, 2]}, {Rational[-3, 2], Rational[-5, 2] 3^Rational[1, 2]}, {Rational[-5, 2], Rational[-5, 2] 3^Rational[1, 2]}, {-3, (-3) 3^Rational[1, 2]}, {Rational[-7, 2], Rational[-7, 2] 3^Rational[1, 2]}, {-3, (-4) 3^Rational[1, 2]}, {Rational[-9, 2], Rational[-9, 2] 3^Rational[1, 2]}, {Rational[-9, 2], Rational[-11, 2] 3^Rational[1, 2]}, {Rational[-7, 2], Rational[-11, 2] 3^Rational[1, 2]}, {-3, (-6) 3^Rational[1, 2]}, {Rational[-5, 2], Rational[-13, 2] 3^Rational[1, 2]}, {Rational[-3, 2], Rational[-13, 2] 3^Rational[1, 2]}, {Rational[-3, 2], Rational[-15, 2] 3^Rational[1, 2]}, {0, (-8) 3^Rational[1, 2]}, {Rational[1, 2], Rational[-15, 2] 3^Rational[1, 2]}, {Rational[3, 2], Rational[-15, 2] 3^Rational[1, 2]}, {Rational[5, 2], Rational[-15, 2] 3^Rational[1, 2]}}];


H7superPoly=Polygon[{{6, (-12) 3^Rational[1, 2]}, {Rational[15, 2], Rational[-25, 2] 3^Rational[1, 2]}, {9, (-12) 3^Rational[1, 2]}, {Rational[17, 2], Rational[-23, 2] 3^Rational[1, 2]}, {Rational[15, 2], Rational[-23, 2] 3^Rational[1, 2]}, {Rational[15, 2], Rational[-21, 2] 3^Rational[1, 2]}, {9, (-10) 3^Rational[1, 2]}, {Rational[17, 2], Rational[-19, 2] 3^Rational[1, 2]}, {9, (-9) 3^Rational[1, 2]}, {Rational[19, 2], Rational[-17, 2] 3^Rational[1, 2]}, {9, (-8) 3^Rational[1, 2]}, {Rational[21, 2], Rational[-15, 2] 3^Rational[1, 2]}, {Rational[21, 2], Rational[-13, 2] 3^Rational[1, 2]}, {Rational[19, 2], Rational[-13, 2] 3^Rational[1, 2]}, {9, (-6) 3^Rational[1, 2]}, {Rational[17, 2], Rational[-11, 2] 3^Rational[1, 2]}, {Rational[15, 2], Rational[-11, 2] 3^Rational[1, 2]}, {Rational[15, 2], Rational[-9, 2] 3^Rational[1, 2]}, {6, (-4) 3^Rational[1, 2]}, {Rational[11, 2], Rational[-9, 2] 3^Rational[1, 2]}, {Rational[9, 2], Rational[-9, 2] 3^Rational[1, 2]}, {Rational[9, 2], Rational[-7, 2] 3^Rational[1, 2]}, {6, (-3) 3^Rational[1, 2]}, {Rational[11, 2], Rational[-5, 2] 3^Rational[1, 2]}, {6, (-2) 3^Rational[1, 2]}, {Rational[13, 2], Rational[-3, 2] 3^Rational[1, 2]}, {6, -3^Rational[1, 2]}, {Rational[15, 2], Rational[-1, 2] 3^Rational[1, 2]}, {9, -3^Rational[1, 2]}, {Rational[19, 2], Rational[-1, 2] 3^Rational[1, 2]}, {Rational[21, 2], Rational[-1, 2] 3^Rational[1, 2]}, {Rational[23, 2], Rational[-1, 2] 3^Rational[1, 2]}, {12, 0}, {Rational[27, 2], Rational[-1, 2] 3^Rational[1, 2]}, {15, 0}, {Rational[29, 2], Rational[1, 2] 3^Rational[1, 2]}, {15, 3^Rational[1, 2]}, {Rational[31, 2], Rational[3, 2] 3^Rational[1, 2]}, {15, 2 3^Rational[1, 2]}, {Rational[33, 2], Rational[5, 2] 3^Rational[1, 2]}, {Rational[33, 2], Rational[7, 2] 3^Rational[1, 2]}, {Rational[31, 2], Rational[7, 2] 3^Rational[1, 2]}, {15, 3 3^Rational[1, 2]}, {Rational[27, 2], Rational[7, 2] 3^Rational[1, 2]}, {Rational[27, 2], Rational[9, 2] 3^Rational[1, 2]}, {Rational[25, 2], Rational[9, 2] 3^Rational[1, 2]}, {12, 5 3^Rational[1, 2]}, {Rational[23, 2], Rational[11, 2] 3^Rational[1, 2]}, {Rational[21, 2], Rational[11, 2] 3^Rational[1, 2]}, {Rational[21, 2], Rational[13, 2] 3^Rational[1, 2]}, {12, 7 3^Rational[1, 2]}, {Rational[23, 2], Rational[15, 2] 3^Rational[1, 2]}, {12, 8 3^Rational[1, 2]}, {Rational[25, 2], Rational[17, 2] 3^Rational[1, 2]}, {12, 9 3^Rational[1, 2]}, {Rational[27, 2], Rational[19, 2] 3^Rational[1, 2]}, {Rational[27, 2], Rational[21, 2] 3^Rational[1, 2]}, {Rational[25, 2], Rational[21, 2] 3^Rational[1, 2]}, {12, 11 3^Rational[1, 2]}, {Rational[23, 2], Rational[23, 2] 3^Rational[1, 2]}, {Rational[21, 2], Rational[23, 2] 3^Rational[1, 2]}, {Rational[21, 2], Rational[25, 2] 3^Rational[1, 2]}, {9, 13 3^Rational[1, 2]}, {Rational[17, 2], Rational[25, 2] 3^Rational[1, 2]}, {9, 12 3^Rational[1, 2]}, {Rational[15, 2], Rational[23, 2] 3^Rational[1, 2]}, {6, 12 3^Rational[1, 2]}, {Rational[11, 2], Rational[23, 2] 3^Rational[1, 2]}, {Rational[9, 2], Rational[23, 2] 3^Rational[1, 2]}, {Rational[7, 2], Rational[23, 2] 3^Rational[1, 2]}, {3, 11 3^Rational[1, 2]}, {Rational[3, 2], Rational[23, 2] 3^Rational[1, 2]}, {0, 11 3^Rational[1, 2]}, {Rational[1, 2], Rational[21, 2] 3^Rational[1, 2]}, {0, 10 3^Rational[1, 2]}, {Rational[-1, 2], Rational[19, 2] 3^Rational[1, 2]}, {0, 9 3^Rational[1, 2]}, {Rational[-3, 2], Rational[17, 2] 3^Rational[1, 2]}, {Rational[-3, 2], Rational[15, 2] 3^Rational[1, 2]}, {Rational[-1, 2], Rational[15, 2] 3^Rational[1, 2]}, {0, 8 3^Rational[1, 2]}, {Rational[3, 2], Rational[15, 2] 3^Rational[1, 2]}, {Rational[3, 2], Rational[13, 2] 3^Rational[1, 2]}, {Rational[5, 2], Rational[13, 2] 3^Rational[1, 2]}, {3, 6 3^Rational[1, 2]}, {Rational[7, 2], Rational[11, 2] 3^Rational[1, 2]}, {Rational[9, 2], Rational[11, 2] 3^Rational[1, 2]}, {Rational[9, 2], Rational[9, 2] 3^Rational[1, 2]}, {3, 4 3^Rational[1, 2]}, {Rational[7, 2], Rational[7, 2] 3^Rational[1, 2]}, {3, 3 3^Rational[1, 2]}, {Rational[5, 2], Rational[5, 2] 3^Rational[1, 2]}, {3, 2 3^Rational[1, 2]}, {Rational[3, 2], Rational[3, 2] 3^Rational[1, 2]}, {Rational[3, 2], Rational[1, 2] 3^Rational[1, 2]}, {Rational[5, 2], Rational[1, 2] 3^Rational[1, 2]}, {3, 0}, {Rational[3, 2], Rational[-1, 2] 3^Rational[1, 2]}, {0, 0}, {Rational[-1, 2], Rational[-1, 2] 3^Rational[1, 2]}, {Rational[-3, 2], Rational[-1, 2] 3^Rational[1, 2]}, {Rational[-5, 2], Rational[-1, 2] 3^Rational[1, 2]}, {-3, -3^Rational[1, 2]}, {Rational[-9, 2], Rational[-1, 2] 3^Rational[1, 2]}, {Rational[-9, 2], Rational[1, 2] 3^Rational[1, 2]}, {Rational[-11, 2], Rational[1, 2] 3^Rational[1, 2]}, {-6, 3^Rational[1, 2]}, {Rational[-13, 2], Rational[3, 2] 3^Rational[1, 2]}, {Rational[-15, 2], Rational[3, 2] 3^Rational[1, 2]}, {Rational[-15, 2], Rational[5, 2] 3^Rational[1, 2]}, {-9, 3 3^Rational[1, 2]}, {Rational[-19, 2], Rational[5, 2] 3^Rational[1, 2]}, {Rational[-21, 2], Rational[5, 2] 3^Rational[1, 2]}, {Rational[-23, 2], Rational[5, 2] 3^Rational[1, 2]}, {-12, 2 3^Rational[1, 2]}, {Rational[-27, 2], Rational[5, 2] 3^Rational[1, 2]}, {-15, 2 3^Rational[1, 2]}, {Rational[-29, 2], Rational[3, 2] 3^Rational[1, 2]}, {-15, 3^Rational[1, 2]}, {Rational[-31, 2], Rational[1, 2] 3^Rational[1, 2]}, {-15, 0}, {Rational[-33, 2], Rational[-1, 2] 3^Rational[1, 2]}, {Rational[-33, 2], Rational[-3, 2] 3^Rational[1, 2]}, {Rational[-31, 2], Rational[-3, 2] 3^Rational[1, 2]}, {-15, -3^Rational[1, 2]}, {Rational[-27, 2], Rational[-3, 2] 3^Rational[1, 2]}, {Rational[-27, 2], Rational[-5, 2] 3^Rational[1, 2]}, {Rational[-25, 2], Rational[-5, 2] 3^Rational[1, 2]}, {-12, (-3) 3^Rational[1, 2]}, {Rational[-23, 2], Rational[-7, 2] 3^Rational[1, 2]}, {Rational[-21, 2], Rational[-7, 2] 3^Rational[1, 2]}, {Rational[-21, 2], Rational[-9, 2] 3^Rational[1, 2]}, {-12, (-5) 3^Rational[1, 2]}, {Rational[-23, 2], Rational[-11, 2] 3^Rational[1, 2]}, {-12, (-6) 3^Rational[1, 2]}, {Rational[-25, 2], Rational[-13, 2] 3^Rational[1, 2]}, {-12, (-7) 3^Rational[1, 2]}, {Rational[-27, 2], Rational[-15, 2] 3^Rational[1, 2]}, {Rational[-27, 2], Rational[-17, 2] 3^Rational[1, 2]}, {Rational[-25, 2], Rational[-17, 2] 3^Rational[1, 2]}, {-12, (-9) 3^Rational[1, 2]}, {Rational[-23, 2], Rational[-19, 2] 3^Rational[1, 2]}, {Rational[-21, 2], Rational[-19, 2] 3^Rational[1, 2]}, {Rational[-21, 2], Rational[-21, 2] 3^Rational[1, 2]}, {-9, (-11) 3^Rational[1, 2]}, {Rational[-17, 2], Rational[-21, 2] 3^Rational[1, 2]}, {-9, (-10) 3^Rational[1, 2]}, {Rational[-15, 2], Rational[-19, 2] 3^Rational[1, 2]}, {-6, (-10) 3^Rational[1, 2]}, {Rational[-11, 2], Rational[-19, 2] 3^Rational[1, 2]}, {Rational[-9, 2], Rational[-19, 2] 3^Rational[1, 2]}, {Rational[-7, 2], Rational[-19, 2] 3^Rational[1, 2]}, {-3, (-9) 3^Rational[1, 2]}, {Rational[-3, 2], Rational[-19, 2] 3^Rational[1, 2]}, {Rational[-3, 2], Rational[-21, 2] 3^Rational[1, 2]}, {Rational[-1, 2], Rational[-21, 2] 3^Rational[1, 2]}, {0, (-11) 3^Rational[1, 2]}, {Rational[1, 2], Rational[-23, 2] 3^Rational[1, 2]}, {Rational[3, 2], Rational[-23, 2] 3^Rational[1, 2]}, {Rational[3, 2], Rational[-25, 2] 3^Rational[1, 2]}, {3, (-13) 3^Rational[1, 2]}, {Rational[7, 2], Rational[-25, 2] 3^Rational[1, 2]}, {Rational[9, 2], Rational[-25, 2] 3^Rational[1, 2]}, {Rational[11, 2], Rational[-25, 2] 3^Rational[1, 2]}}];
H8superPoly=Polygon[{{9, (-19) 3^Rational[1, 2]}, {Rational[21, 2], Rational[-39, 2] 3^Rational[1, 2]}, {12, (-19) 3^Rational[1, 2]}, {Rational[23, 2], Rational[-37, 2] 3^Rational[1, 2]}, {Rational[21, 2], Rational[-37, 2] 3^Rational[1, 2]}, {Rational[21, 2], Rational[-35, 2] 3^Rational[1, 2]}, {12, (-17) 3^Rational[1, 2]}, {Rational[23, 2], Rational[-33, 2] 3^Rational[1, 2]}, {12, (-16) 3^Rational[1, 2]}, {Rational[25, 2], Rational[-31, 2] 3^Rational[1, 2]}, {12, (-15) 3^Rational[1, 2]}, {Rational[27, 2], Rational[-29, 2] 3^Rational[1, 2]}, {Rational[27, 2], Rational[-27, 2] 3^Rational[1, 2]}, {Rational[25, 2], Rational[-27, 2] 3^Rational[1, 2]}, {12, (-13) 3^Rational[1, 2]}, {Rational[23, 2], Rational[-25, 2] 3^Rational[1, 2]}, {Rational[21, 2], Rational[-25, 2] 3^Rational[1, 2]}, {Rational[21, 2], Rational[-23, 2] 3^Rational[1, 2]}, {9, (-11) 3^Rational[1, 2]}, {Rational[17, 2], Rational[-23, 2] 3^Rational[1, 2]}, {Rational[15, 2], Rational[-23, 2] 3^Rational[1, 2]}, {Rational[15, 2], Rational[-21, 2] 3^Rational[1, 2]}, {9, (-10) 3^Rational[1, 2]}, {Rational[17, 2], Rational[-19, 2] 3^Rational[1, 2]}, {9, (-9) 3^Rational[1, 2]}, {Rational[19, 2], Rational[-17, 2] 3^Rational[1, 2]}, {9, (-8) 3^Rational[1, 2]}, {Rational[21, 2], Rational[-15, 2] 3^Rational[1, 2]}, {12, (-8) 3^Rational[1, 2]}, {Rational[25, 2], Rational[-15, 2] 3^Rational[1, 2]}, {Rational[27, 2], Rational[-15, 2] 3^Rational[1, 2]}, {Rational[29, 2], Rational[-15, 2] 3^Rational[1, 2]}, {15, (-7) 3^Rational[1, 2]}, {Rational[33, 2], Rational[-15, 2] 3^Rational[1, 2]}, {18, (-7) 3^Rational[1, 2]}, {Rational[35, 2], Rational[-13, 2] 3^Rational[1, 2]}, {18, (-6) 3^Rational[1, 2]}, {Rational[37, 2], Rational[-11, 2] 3^Rational[1, 2]}, {18, (-5) 3^Rational[1, 2]}, {Rational[39, 2], Rational[-9, 2] 3^Rational[1, 2]}, {Rational[39, 2], Rational[-7, 2] 3^Rational[1, 2]}, {Rational[37, 2], Rational[-7, 2] 3^Rational[1, 2]}, {18, (-4) 3^Rational[1, 2]}, {Rational[33, 2], Rational[-7, 2] 3^Rational[1, 2]}, {Rational[33, 2], Rational[-5, 2] 3^Rational[1, 2]}, {Rational[31, 2], Rational[-5, 2] 3^Rational[1, 2]}, {15, (-2) 3^Rational[1, 2]}, {Rational[29, 2], Rational[-3, 2] 3^Rational[1, 2]}, {Rational[27, 2], Rational[-3, 2] 3^Rational[1, 2]}, {Rational[27, 2], Rational[-1, 2] 3^Rational[1, 2]}, {15, 0}, {Rational[29, 2], Rational[1, 2] 3^Rational[1, 2]}, {15, 3^Rational[1, 2]}, {Rational[31, 2], Rational[3, 2] 3^Rational[1, 2]}, {15, 2 3^Rational[1, 2]}, {Rational[33, 2], Rational[5, 2] 3^Rational[1, 2]}, {Rational[33, 2], Rational[7, 2] 3^Rational[1, 2]}, {Rational[31, 2], Rational[7, 2] 3^Rational[1, 2]}, {15, 4 3^Rational[1, 2]}, {Rational[29, 2], Rational[9, 2] 3^Rational[1, 2]}, {Rational[27, 2], Rational[9, 2] 3^Rational[1, 2]}, {Rational[27, 2], Rational[11, 2] 3^Rational[1, 2]}, {12, 6 3^Rational[1, 2]}, {Rational[23, 2], Rational[11, 2] 3^Rational[1, 2]}, {12, 5 3^Rational[1, 2]}, {Rational[21, 2], Rational[9, 2] 3^Rational[1, 2]}, {9, 5 3^Rational[1, 2]}, {Rational[17, 2], Rational[9, 2] 3^Rational[1, 2]}, {Rational[15, 2], Rational[9, 2] 3^Rational[1, 2]}, {Rational[13, 2], Rational[9, 2] 3^Rational[1, 2]}, {6, 4 3^Rational[1, 2]}, {Rational[9, 2], Rational[9, 2] 3^Rational[1, 2]}, {3, 4 3^Rational[1, 2]}, {Rational[7, 2], Rational[7, 2] 3^Rational[1, 2]}, {3, 3 3^Rational[1, 2]}, {Rational[5, 2], Rational[5, 2] 3^Rational[1, 2]}, {3, 2 3^Rational[1, 2]}, {Rational[3, 2], Rational[3, 2] 3^Rational[1, 2]}, {Rational[3, 2], Rational[1, 2] 3^Rational[1, 2]}, {Rational[5, 2], Rational[1, 2] 3^Rational[1, 2]}, {3, 0}, {Rational[3, 2], Rational[-1, 2] 3^Rational[1, 2]}, {0, 0}, {Rational[-1, 2], Rational[-1, 2] 3^Rational[1, 2]}, {Rational[-3, 2], Rational[-1, 2] 3^Rational[1, 2]}, {Rational[-3, 2], Rational[-3, 2] 3^Rational[1, 2]}, {-3, (-2) 3^Rational[1, 2]}, {Rational[-5, 2], Rational[-5, 2] 3^Rational[1, 2]}, {-3, (-3) 3^Rational[1, 2]}, {Rational[-7, 2], Rational[-7, 2] 3^Rational[1, 2]}, {-3, (-4) 3^Rational[1, 2]}, {Rational[-9, 2], Rational[-9, 2] 3^Rational[1, 2]}, {-6, (-4) 3^Rational[1, 2]}, {Rational[-13, 2], Rational[-9, 2] 3^Rational[1, 2]}, {Rational[-15, 2], Rational[-9, 2] 3^Rational[1, 2]}, {Rational[-17, 2], Rational[-9, 2] 3^Rational[1, 2]}, {-9, (-5) 3^Rational[1, 2]}, {Rational[-21, 2], Rational[-9, 2] 3^Rational[1, 2]}, {-12, (-5) 3^Rational[1, 2]}, {Rational[-23, 2], Rational[-11, 2] 3^Rational[1, 2]}, {-12, (-6) 3^Rational[1, 2]}, {Rational[-25, 2], Rational[-13, 2] 3^Rational[1, 2]}, {-12, (-7) 3^Rational[1, 2]}, {Rational[-27, 2], Rational[-15, 2] 3^Rational[1, 2]}, {Rational[-27, 2], Rational[-17, 2] 3^Rational[1, 2]}, {Rational[-25, 2], Rational[-17, 2] 3^Rational[1, 2]}, {-12, (-8) 3^Rational[1, 2]}, {Rational[-21, 2], Rational[-17, 2] 3^Rational[1, 2]}, {Rational[-21, 2], Rational[-19, 2] 3^Rational[1, 2]}, {Rational[-19, 2], Rational[-19, 2] 3^Rational[1, 2]}, {-9, (-10) 3^Rational[1, 2]}, {Rational[-17, 2], Rational[-21, 2] 3^Rational[1, 2]}, {Rational[-15, 2], Rational[-21, 2] 3^Rational[1, 2]}, {Rational[-15, 2], Rational[-23, 2] 3^Rational[1, 2]}, {-9, (-12) 3^Rational[1, 2]}, {Rational[-17, 2], Rational[-25, 2] 3^Rational[1, 2]}, {-9, (-13) 3^Rational[1, 2]}, {Rational[-19, 2], Rational[-27, 2] 3^Rational[1, 2]}, {-9, (-14) 3^Rational[1, 2]}, {Rational[-21, 2], Rational[-29, 2] 3^Rational[1, 2]}, {Rational[-21, 2], Rational[-31, 2] 3^Rational[1, 2]}, {Rational[-19, 2], Rational[-31, 2] 3^Rational[1, 2]}, {-9, (-16) 3^Rational[1, 2]}, {Rational[-17, 2], Rational[-33, 2] 3^Rational[1, 2]}, {Rational[-15, 2], Rational[-33, 2] 3^Rational[1, 2]}, {Rational[-15, 2], Rational[-35, 2] 3^Rational[1, 2]}, {-6, (-18) 3^Rational[1, 2]}, {Rational[-11, 2], Rational[-35, 2] 3^Rational[1, 2]}, {-6, (-17) 3^Rational[1, 2]}, {Rational[-9, 2], Rational[-33, 2] 3^Rational[1, 2]}, {-3, (-17) 3^Rational[1, 2]}, {Rational[-5, 2], Rational[-33, 2] 3^Rational[1, 2]}, {Rational[-3, 2], Rational[-33, 2] 3^Rational[1, 2]}, {Rational[-1, 2], Rational[-33, 2] 3^Rational[1, 2]}, {0, (-16) 3^Rational[1, 2]}, {Rational[3, 2], Rational[-33, 2] 3^Rational[1, 2]}, {Rational[3, 2], Rational[-35, 2] 3^Rational[1, 2]}, {Rational[5, 2], Rational[-35, 2] 3^Rational[1, 2]}, {3, (-18) 3^Rational[1, 2]}, {Rational[7, 2], Rational[-37, 2] 3^Rational[1, 2]}, {Rational[9, 2], Rational[-37, 2] 3^Rational[1, 2]}, {Rational[9, 2], Rational[-39, 2] 3^Rational[1, 2]}, {6, (-20) 3^Rational[1, 2]}, {Rational[13, 2], Rational[-39, 2] 3^Rational[1, 2]}, {Rational[15, 2], Rational[-39, 2] 3^Rational[1, 2]}, {Rational[17, 2], Rational[-39, 2] 3^Rational[1, 2]}}];


(* ::Section::Closed:: *)
(*Tiles Generators*)


(* ::Subsection::Closed:: *)
(*meta tile*)


standardH2Vertices={{0, 0}, {Rational[3, 2], Rational[-1, 2] 3^Rational[1, 2]}, {3, 0}, {Rational[5, 2], Rational[1, 2] 3^Rational[1, 2]}, {Rational[3, 2], Rational[1, 2] 3^Rational[1, 2]}, {Rational[3, 2], Rational[3, 2] 3^Rational[1, 2]}, {0, 2 3^Rational[1, 2]}, {Rational[1, 2], Rational[5, 2] 3^Rational[1, 2]}, {0, 3 3^Rational[1, 2]}, {Rational[-3, 2], Rational[5, 2] 3^Rational[1, 2]}, {-3, 3 3^Rational[1, 2]}, {Rational[-7, 2], Rational[5, 2] 3^Rational[1, 2]}, {Rational[-9, 2], Rational[5, 2] 3^Rational[1, 2]}, {Rational[-9, 2], Rational[3, 2] 3^Rational[1, 2]}, {-3, 3^Rational[1, 2]}, {Rational[-7, 2], Rational[1, 2] 3^Rational[1, 2]}, {-3, 0}, {Rational[-5, 2], Rational[-1, 2] 3^Rational[1, 2]}, {Rational[-3, 2], Rational[-1, 2] 3^Rational[1, 2]}, {Rational[-1, 2], Rational[-1, 2] 3^Rational[1, 2]}};
standardH1Vertices={{0, 0}, {Rational[3, 2], Rational[-1, 2] 3^Rational[1, 2]}, {3, 0}, {Rational[5, 2], Rational[1, 2] 3^Rational[1, 2]}, {Rational[3, 2], Rational[1, 2] 3^Rational[1, 2]}, {Rational[3, 2], Rational[3, 2] 3^Rational[1, 2]}, {0, 2 3^Rational[1, 2]}, {Rational[-1, 2], Rational[3, 2] 3^Rational[1, 2]}, {Rational[-3, 2], Rational[3, 2] 3^Rational[1, 2]}, {Rational[-3, 2], Rational[1, 2] 3^Rational[1, 2]}, {-3, 0}, {Rational[-5, 2], Rational[-1, 2] 3^Rational[1, 2]}, {Rational[-3, 2], Rational[-1, 2] 3^Rational[1, 2]}, {Rational[-1, 2], Rational[-1, 2] 3^Rational[1, 2]}};


metaTile[pos_,dir_:0,pt_,choice_:True]:=With[{
	vertices=If[
		TrueQ[choice],
			standardH1Vertices . Transpose@RotationMatrix[dir*Pi/6],
			standardH2Vertices . Transpose@RotationMatrix[dir*Pi/6]
			]
	},
	Polygon[vertices+Threaded[pos-vertices[[pt]]]]
]


(* ::Subsection::Closed:: *)
(*H7/H8 cluster*)


(* ::Subsubsection::Closed:: *)
(*cluster tile polygon*)


standardH8Vertices={{0, 0}, {Rational[3, 2], Rational[-1, 2] 3^Rational[1, 2]}, {3, 0}, {Rational[5, 2], Rational[1, 2] 3^Rational[1, 2]}, {Rational[3, 2], Rational[1, 2] 3^Rational[1, 2]}, {Rational[3, 2], Rational[3, 2] 3^Rational[1, 2]}, {3, 2 3^Rational[1, 2]}, {Rational[5, 2], Rational[5, 2] 3^Rational[1, 2]}, {3, 3 3^Rational[1, 2]}, {Rational[7, 2], Rational[7, 2] 3^Rational[1, 2]}, {3, 4 3^Rational[1, 2]}, {Rational[9, 2], Rational[9, 2] 3^Rational[1, 2]}, {Rational[9, 2], Rational[11, 2] 3^Rational[1, 2]}, {Rational[7, 2], Rational[11, 2] 3^Rational[1, 2]}, {3, 6 3^Rational[1, 2]}, {Rational[5, 2], Rational[13, 2] 3^Rational[1, 2]}, {Rational[3, 2], Rational[13, 2] 3^Rational[1, 2]}, {Rational[3, 2], Rational[15, 2] 3^Rational[1, 2]}, {0, 8 3^Rational[1, 2]}, {Rational[-1, 2], Rational[15, 2] 3^Rational[1, 2]}, {0, 7 3^Rational[1, 2]}, {Rational[-3, 2], Rational[13, 2] 3^Rational[1, 2]}, {-3, 7 3^Rational[1, 2]}, {Rational[-7, 2], Rational[13, 2] 3^Rational[1, 2]}, {Rational[-9, 2], Rational[13, 2] 3^Rational[1, 2]}, {Rational[-9, 2], Rational[11, 2] 3^Rational[1, 2]}, {-6, 5 3^Rational[1, 2]}, {Rational[-11, 2], Rational[9, 2] 3^Rational[1, 2]}, {-6, 4 3^Rational[1, 2]}, {Rational[-13, 2], Rational[7, 2] 3^Rational[1, 2]}, {-6, 3 3^Rational[1, 2]}, {Rational[-15, 2], Rational[5, 2] 3^Rational[1, 2]}, {Rational[-15, 2], Rational[3, 2] 3^Rational[1, 2]}, {Rational[-13, 2], Rational[3, 2] 3^Rational[1, 2]}, {-6, 3^Rational[1, 2]}, {Rational[-11, 2], Rational[1, 2] 3^Rational[1, 2]}, {Rational[-9, 2], Rational[1, 2] 3^Rational[1, 2]}, {Rational[-9, 2], Rational[-1, 2] 3^Rational[1, 2]}, {-3, -3^Rational[1, 2]}, {Rational[-5, 2], Rational[-1, 2] 3^Rational[1, 2]}, {Rational[-3, 2], Rational[-1, 2] 3^Rational[1, 2]}, {Rational[-1, 2], Rational[-1, 2] 3^Rational[1, 2]}};


standardH7Vertices={{0, 0}, {Rational[3, 2], Rational[-1, 2] 3^Rational[1, 2]}, {3, 0}, {Rational[5, 2], Rational[1, 2] 3^Rational[1, 2]}, {Rational[3, 2], Rational[1, 2] 3^Rational[1, 2]}, {Rational[3, 2], Rational[3, 2] 3^Rational[1, 2]}, {3, 2 3^Rational[1, 2]}, {Rational[5, 2], Rational[5, 2] 3^Rational[1, 2]}, {3, 3 3^Rational[1, 2]}, {Rational[7, 2], Rational[7, 2] 3^Rational[1, 2]}, {3, 4 3^Rational[1, 2]}, {Rational[9, 2], Rational[9, 2] 3^Rational[1, 2]}, {Rational[9, 2], Rational[11, 2] 3^Rational[1, 2]}, {Rational[7, 2], Rational[11, 2] 3^Rational[1, 2]}, {3, 6 3^Rational[1, 2]}, {Rational[5, 2], Rational[13, 2] 3^Rational[1, 2]}, {Rational[3, 2], Rational[13, 2] 3^Rational[1, 2]}, {Rational[3, 2], Rational[15, 2] 3^Rational[1, 2]}, {0, 8 3^Rational[1, 2]}, {Rational[-1, 2], Rational[15, 2] 3^Rational[1, 2]}, {0, 7 3^Rational[1, 2]}, {Rational[-3, 2], Rational[13, 2] 3^Rational[1, 2]}, {Rational[-3, 2], Rational[11, 2] 3^Rational[1, 2]}, {Rational[-1, 2], Rational[11, 2] 3^Rational[1, 2]}, {0, 5 3^Rational[1, 2]}, {Rational[-3, 2], Rational[9, 2] 3^Rational[1, 2]}, {-3, 5 3^Rational[1, 2]}, {Rational[-7, 2], Rational[9, 2] 3^Rational[1, 2]}, {Rational[-9, 2], Rational[9, 2] 3^Rational[1, 2]}, {Rational[-11, 2], Rational[9, 2] 3^Rational[1, 2]}, {-6, 4 3^Rational[1, 2]}, {Rational[-13, 2], Rational[7, 2] 3^Rational[1, 2]}, {-6, 3 3^Rational[1, 2]}, {Rational[-15, 2], Rational[5, 2] 3^Rational[1, 2]}, {Rational[-15, 2], Rational[3, 2] 3^Rational[1, 2]}, {Rational[-13, 2], Rational[3, 2] 3^Rational[1, 2]}, {-6, 3^Rational[1, 2]}, {Rational[-11, 2], Rational[1, 2] 3^Rational[1, 2]}, {Rational[-9, 2], Rational[1, 2] 3^Rational[1, 2]}, {Rational[-9, 2], Rational[-1, 2] 3^Rational[1, 2]}, {-3, -3^Rational[1, 2]}, {Rational[-5, 2], Rational[-1, 2] 3^Rational[1, 2]}, {Rational[-3, 2], Rational[-1, 2] 3^Rational[1, 2]}, {Rational[-1, 2], Rational[-1, 2] 3^Rational[1, 2]}};


cluster[pos_,dir_:0,pt_,choice_:False]:=With[{
	vertices=If[
		TrueQ[choice],
			standardH8Vertices . Transpose[RotationMatrix[dir*Pi/6]],
			standardH7Vertices . Transpose[RotationMatrix[dir*Pi/6]]
			]
	},
	Polygon[vertices+Threaded[pos-vertices[[pt]]]]
]


(* ::Subsubsection::Closed:: *)
(*cluster code*)


clusterCode[pos_,dir_,pt_,True]:=With[{H8vertices = standardH8Vertices},
{
		pos + RotationMatrix[dir Pi/6] . (#1-H8vertices[[pt]]),
		Mod[If[TrueQ[#3], -dir, dir] + #2,12],
		#3,#4
	}&@@@{{{0, 5 3^Rational[1, 2]}, 0, False, 3}, {{Rational[-3, 2], Rational[11, 2] 3^Rational[1, 2]}, 4, False, 7}, {{0, 5 3^Rational[1, 2]}, 10, True, 11}, {{-3, 2 3^Rational[1, 2]}, 8, False, 7}, {{0, 4 3^Rational[1, 2]}, 2, False, 9}, {{-3, 2 3^Rational[1, 2]}, 0, False, 11}, {{-3, 2 3^Rational[1, 2]}, 10, False, 9}, {{Rational[-3, 2], Rational[3, 2] 3^Rational[1, 2]}, 0, False, 9}}];


clusterCode[pos_,dir_,pt_,False]:=With[{H7vertices = standardH7Vertices},
{
		pos + RotationMatrix[dir Pi/6] . (#1-H7vertices[[pt]]),
		Mod[If[TrueQ[#3], -dir, dir] + #2, 12],
	#3,#4
	}&@@@{{{Rational[-3, 2], Rational[11, 2] 3^Rational[1, 2]}, 4, False, 7}, {{0, 5 3^Rational[1, 2]}, 10, True, 11}, {{-3, 2 3^Rational[1, 2]}, 8, False, 7}, {{0, 4 3^Rational[1, 2]}, 2, False, 9}, {{-3, 2 3^Rational[1, 2]}, 0, False, 11}, {{-3, 2 3^Rational[1, 2]}, 10, False, 9}, {{Rational[-3, 2], Rational[3, 2] 3^Rational[1, 2]}, 0, False, 9}}];


(* ::Subsubsection::Closed:: *)
(*cluster vertices*)


clusterVertices[pos_,dir_:0,pt_,choice_:False]:=With[{
	vertices=If[
		TrueQ[choice],
			standardH8Vertices . Transpose[RotationMatrix[dir*Pi/6]],
			standardH7Vertices . Transpose[RotationMatrix[dir*Pi/6]]
		]
	},
	vertices+Threaded[pos-vertices[[pt]]]
]


clusterInnerVertices[pos_, dir_:0, pt_, False] := {{-6, 2 Sqrt[3]}, {-(11/2), 5 Sqrt[3]/2}, {-(9/2), 3 Sqrt[3]/2}, {-(9/2), 5 Sqrt[3]/2}, {-(9/2), 7 Sqrt[3]/2}, {-(7/2), Sqrt[3]/2}, {-(7/2), 5 Sqrt[3]/2}, {-3, 0}, {-3, Sqrt[3]}, {-3, 2 Sqrt[3]}, {-3, 3 Sqrt[3]}, {-3, 4 Sqrt[3]}, {-(5/2), 3 Sqrt[3]/2}, {-(5/2), 7 Sqrt[3]/2}, {-(3/2), Sqrt[3]/2}, {-(3/2), 3 Sqrt[3]/2}, {-(3/2), 5 Sqrt[3]/2}, {-(3/2), 7 Sqrt[3]/2}, {-(1/2), 3 Sqrt[3]/2}, {-(1/2), 7 Sqrt[3]/2}, {0, Sqrt[3]}, {0, 2 Sqrt[3]}, {0, 3 Sqrt[3]}, {0, 4 Sqrt[3]}, {0, 6 Sqrt[3]}, {1/2, Sqrt[3]/2}, {1/2, 5 Sqrt[3]/2}, {1/2, 9 Sqrt[3]/2}, {1/2, 13 Sqrt[3]/2}, {3/2, 5 Sqrt[3]/2}, {3/2, 7 Sqrt[3]/2}, {3/2, 9 Sqrt[3]/2}, {3/2, 11 Sqrt[3]/2}, {5/2, 9 Sqrt[3]/2}, {3, 5 Sqrt[3]}} . Transpose[RotationMatrix[dir*Pi/6]] + Threaded[clusterVertices[pos,dir,pt,False][[1]]]


clusterInnerVertices[pos_, dir_:0, pt_, True] := {{-6, 2 Sqrt[3]}, {-(11/2), 5 Sqrt[3]/2}, {-(9/2), 3 Sqrt[3]/2}, {-(9/2), 5 Sqrt[3]/2}, {-(9/2), 7 Sqrt[3]/2}, {-(9/2), 9 Sqrt[3]/2}, {-(7/2), Sqrt[3]/2}, {-(7/2), 5 Sqrt[3]/2}, {-(7/2), 9 Sqrt[3]/2}, {-3, 0}, {-3, Sqrt[3]}, {-3, 2 Sqrt[3]}, {-3, 3 Sqrt[3]}, {-3, 4 Sqrt[3]}, {-3, 5 Sqrt[3]}, {-3, 6 Sqrt[3]}, {-(5/2), 3 Sqrt[3]/2}, {-(5/2), 7 Sqrt[3]/2}, {-(5/2), 11 Sqrt[3]/2}, {-(3/2), Sqrt[3]/2}, {-(3/2), 3 Sqrt[3]/2}, {-(3/2), 5 Sqrt[3]/2}, {-(3/2), 7 Sqrt[3]/2}, {-(3/2), 9 Sqrt[3]/2}, {-(3/2), 11 Sqrt[3]/2}, {-(1/2), 3 Sqrt[3]/2}, {-(1/2), 7 Sqrt[3]/2}, {-(1/2), 11 Sqrt[3]/2}, {0, Sqrt[3]}, {0, 2 Sqrt[3]}, {0, 3 Sqrt[3]}, {0, 4 Sqrt[3]}, {0, 5 Sqrt[3]}, {0, 6 Sqrt[3]}, {1/2, Sqrt[3]/2}, {1/2, 5 Sqrt[3]/2}, {1/2, 9 Sqrt[3]/2}, {1/2, 13 Sqrt[3]/2}, {3/2, 5 Sqrt[3]/2}, {3/2, 7 Sqrt[3]/2}, {3/2, 9 Sqrt[3]/2}, {3/2, 11 Sqrt[3]/2}, {5/2, 9 Sqrt[3]/2}, {3, 5 Sqrt[3]}} . Transpose[RotationMatrix[dir*Pi/6]] + Threaded[clusterVertices[pos,dir,pt,True][[1]]]


angleVertices[angle_][poly_]:=First/@Position[PolygonAngle[poly],_?(#==2Pi*angle&),{1}]


canonicalCluster[code_]:={First[clusterVertices[##]], #2, 1, #4}& @@ code;


(* ::Subsection::Closed:: *)
(*1-super-cluster*)


standardH7SuperVertices={{0, 0}, {Rational[3, 2], Rational[-1, 2] 3^Rational[1, 2]}, {3, 0}, {Rational[5, 2], Rational[1, 2] 3^Rational[1, 2]}, {Rational[3, 2], Rational[1, 2] 3^Rational[1, 2]}, {Rational[3, 2], Rational[3, 2] 3^Rational[1, 2]}, {3, 2 3^Rational[1, 2]}, {Rational[5, 2], Rational[5, 2] 3^Rational[1, 2]}, {3, 3 3^Rational[1, 2]}, {Rational[7, 2], Rational[7, 2] 3^Rational[1, 2]}, {3, 4 3^Rational[1, 2]}, {Rational[9, 2], Rational[9, 2] 3^Rational[1, 2]}, {Rational[9, 2], Rational[11, 2] 3^Rational[1, 2]}, {Rational[7, 2], Rational[11, 2] 3^Rational[1, 2]}, {3, 6 3^Rational[1, 2]}, {Rational[5, 2], Rational[13, 2] 3^Rational[1, 2]}, {Rational[3, 2], Rational[13, 2] 3^Rational[1, 2]}, {Rational[3, 2], Rational[15, 2] 3^Rational[1, 2]}, {0, 8 3^Rational[1, 2]}, {Rational[-1, 2], Rational[15, 2] 3^Rational[1, 2]}, {Rational[-3, 2], Rational[15, 2] 3^Rational[1, 2]}, {Rational[-3, 2], Rational[17, 2] 3^Rational[1, 2]}, {0, 9 3^Rational[1, 2]}, {Rational[-1, 2], Rational[19, 2] 3^Rational[1, 2]}, {0, 10 3^Rational[1, 2]}, {Rational[1, 2], Rational[21, 2] 3^Rational[1, 2]}, {0, 11 3^Rational[1, 2]}, {Rational[3, 2], Rational[23, 2] 3^Rational[1, 2]}, {3, 11 3^Rational[1, 2]}, {Rational[7, 2], Rational[23, 2] 3^Rational[1, 2]}, {Rational[9, 2], Rational[23, 2] 3^Rational[1, 2]}, {Rational[11, 2], Rational[23, 2] 3^Rational[1, 2]}, {6, 12 3^Rational[1, 2]}, {Rational[15, 2], Rational[23, 2] 3^Rational[1, 2]}, {9, 12 3^Rational[1, 2]}, {Rational[17, 2], Rational[25, 2] 3^Rational[1, 2]}, {9, 13 3^Rational[1, 2]}, {Rational[19, 2], Rational[27, 2] 3^Rational[1, 2]}, {9, 14 3^Rational[1, 2]}, {Rational[21, 2], Rational[29, 2] 3^Rational[1, 2]}, {Rational[21, 2], Rational[31, 2] 3^Rational[1, 2]}, {Rational[19, 2], Rational[31, 2] 3^Rational[1, 2]}, {9, 15 3^Rational[1, 2]}, {Rational[15, 2], Rational[31, 2] 3^Rational[1, 2]}, {Rational[15, 2], Rational[33, 2] 3^Rational[1, 2]}, {Rational[13, 2], Rational[33, 2] 3^Rational[1, 2]}, {6, 17 3^Rational[1, 2]}, {Rational[11, 2], Rational[35, 2] 3^Rational[1, 2]}, {Rational[9, 2], Rational[35, 2] 3^Rational[1, 2]}, {Rational[9, 2], Rational[37, 2] 3^Rational[1, 2]}, {6, 19 3^Rational[1, 2]}, {Rational[11, 2], Rational[39, 2] 3^Rational[1, 2]}, {6, 20 3^Rational[1, 2]}, {Rational[13, 2], Rational[41, 2] 3^Rational[1, 2]}, {6, 21 3^Rational[1, 2]}, {Rational[15, 2], Rational[43, 2] 3^Rational[1, 2]}, {Rational[15, 2], Rational[45, 2] 3^Rational[1, 2]}, {Rational[13, 2], Rational[45, 2] 3^Rational[1, 2]}, {6, 23 3^Rational[1, 2]}, {Rational[11, 2], Rational[47, 2] 3^Rational[1, 2]}, {Rational[9, 2], Rational[47, 2] 3^Rational[1, 2]}, {Rational[9, 2], Rational[49, 2] 3^Rational[1, 2]}, {3, 25 3^Rational[1, 2]}, {Rational[5, 2], Rational[49, 2] 3^Rational[1, 2]}, {3, 24 3^Rational[1, 2]}, {Rational[3, 2], Rational[47, 2] 3^Rational[1, 2]}, {0, 24 3^Rational[1, 2]}, {Rational[-1, 2], Rational[47, 2] 3^Rational[1, 2]}, {Rational[-3, 2], Rational[47, 2] 3^Rational[1, 2]}, {Rational[-5, 2], Rational[47, 2] 3^Rational[1, 2]}, {-3, 23 3^Rational[1, 2]}, {Rational[-9, 2], Rational[47, 2] 3^Rational[1, 2]}, {-6, 23 3^Rational[1, 2]}, {Rational[-11, 2], Rational[45, 2] 3^Rational[1, 2]}, {-6, 22 3^Rational[1, 2]}, {Rational[-13, 2], Rational[43, 2] 3^Rational[1, 2]}, {-6, 21 3^Rational[1, 2]}, {Rational[-15, 2], Rational[41, 2] 3^Rational[1, 2]}, {Rational[-15, 2], Rational[39, 2] 3^Rational[1, 2]}, {Rational[-13, 2], Rational[39, 2] 3^Rational[1, 2]}, {-6, 20 3^Rational[1, 2]}, {Rational[-9, 2], Rational[39, 2] 3^Rational[1, 2]}, {Rational[-9, 2], Rational[37, 2] 3^Rational[1, 2]}, {Rational[-7, 2], Rational[37, 2] 3^Rational[1, 2]}, {-3, 18 3^Rational[1, 2]}, {Rational[-5, 2], Rational[35, 2] 3^Rational[1, 2]}, {Rational[-3, 2], Rational[35, 2] 3^Rational[1, 2]}, {Rational[-3, 2], Rational[33, 2] 3^Rational[1, 2]}, {-3, 16 3^Rational[1, 2]}, {Rational[-5, 2], Rational[31, 2] 3^Rational[1, 2]}, {-3, 15 3^Rational[1, 2]}, {Rational[-7, 2], Rational[29, 2] 3^Rational[1, 2]}, {-3, 14 3^Rational[1, 2]}, {Rational[-9, 2], Rational[27, 2] 3^Rational[1, 2]}, {Rational[-9, 2], Rational[25, 2] 3^Rational[1, 2]}, {Rational[-7, 2], Rational[25, 2] 3^Rational[1, 2]}, {-3, 12 3^Rational[1, 2]}, {Rational[-9, 2], Rational[23, 2] 3^Rational[1, 2]}, {-6, 12 3^Rational[1, 2]}, {Rational[-13, 2], Rational[23, 2] 3^Rational[1, 2]}, {Rational[-15, 2], Rational[23, 2] 3^Rational[1, 2]}, {Rational[-17, 2], Rational[23, 2] 3^Rational[1, 2]}, {-9, 11 3^Rational[1, 2]}, {Rational[-21, 2], Rational[23, 2] 3^Rational[1, 2]}, {Rational[-21, 2], Rational[25, 2] 3^Rational[1, 2]}, {Rational[-23, 2], Rational[25, 2] 3^Rational[1, 2]}, {-12, 13 3^Rational[1, 2]}, {Rational[-25, 2], Rational[27, 2] 3^Rational[1, 2]}, {Rational[-27, 2], Rational[27, 2] 3^Rational[1, 2]}, {Rational[-27, 2], Rational[29, 2] 3^Rational[1, 2]}, {-15, 15 3^Rational[1, 2]}, {Rational[-31, 2], Rational[29, 2] 3^Rational[1, 2]}, {Rational[-33, 2], Rational[29, 2] 3^Rational[1, 2]}, {Rational[-35, 2], Rational[29, 2] 3^Rational[1, 2]}, {-18, 14 3^Rational[1, 2]}, {Rational[-39, 2], Rational[29, 2] 3^Rational[1, 2]}, {-21, 14 3^Rational[1, 2]}, {Rational[-41, 2], Rational[27, 2] 3^Rational[1, 2]}, {-21, 13 3^Rational[1, 2]}, {Rational[-43, 2], Rational[25, 2] 3^Rational[1, 2]}, {-21, 12 3^Rational[1, 2]}, {Rational[-45, 2], Rational[23, 2] 3^Rational[1, 2]}, {Rational[-45, 2], Rational[21, 2] 3^Rational[1, 2]}, {Rational[-43, 2], Rational[21, 2] 3^Rational[1, 2]}, {-21, 11 3^Rational[1, 2]}, {Rational[-39, 2], Rational[21, 2] 3^Rational[1, 2]}, {Rational[-39, 2], Rational[19, 2] 3^Rational[1, 2]}, {Rational[-37, 2], Rational[19, 2] 3^Rational[1, 2]}, {-18, 9 3^Rational[1, 2]}, {Rational[-35, 2], Rational[17, 2] 3^Rational[1, 2]}, {Rational[-33, 2], Rational[17, 2] 3^Rational[1, 2]}, {Rational[-33, 2], Rational[15, 2] 3^Rational[1, 2]}, {-18, 7 3^Rational[1, 2]}, {Rational[-35, 2], Rational[13, 2] 3^Rational[1, 2]}, {-18, 6 3^Rational[1, 2]}, {Rational[-37, 2], Rational[11, 2] 3^Rational[1, 2]}, {-18, 5 3^Rational[1, 2]}, {Rational[-39, 2], Rational[9, 2] 3^Rational[1, 2]}, {Rational[-39, 2], Rational[7, 2] 3^Rational[1, 2]}, {Rational[-37, 2], Rational[7, 2] 3^Rational[1, 2]}, {-18, 3 3^Rational[1, 2]}, {Rational[-35, 2], Rational[5, 2] 3^Rational[1, 2]}, {Rational[-33, 2], Rational[5, 2] 3^Rational[1, 2]}, {Rational[-33, 2], Rational[3, 2] 3^Rational[1, 2]}, {-15, 3^Rational[1, 2]}, {Rational[-29, 2], Rational[3, 2] 3^Rational[1, 2]}, {-15, 2 3^Rational[1, 2]}, {Rational[-27, 2], Rational[5, 2] 3^Rational[1, 2]}, {-12, 2 3^Rational[1, 2]}, {Rational[-23, 2], Rational[5, 2] 3^Rational[1, 2]}, {Rational[-21, 2], Rational[5, 2] 3^Rational[1, 2]}, {Rational[-19, 2], Rational[5, 2] 3^Rational[1, 2]}, {-9, 3 3^Rational[1, 2]}, {Rational[-15, 2], Rational[5, 2] 3^Rational[1, 2]}, {Rational[-15, 2], Rational[3, 2] 3^Rational[1, 2]}, {Rational[-13, 2], Rational[3, 2] 3^Rational[1, 2]}, {-6, 3^Rational[1, 2]}, {Rational[-11, 2], Rational[1, 2] 3^Rational[1, 2]}, {Rational[-9, 2], Rational[1, 2] 3^Rational[1, 2]}, {Rational[-9, 2], Rational[-1, 2] 3^Rational[1, 2]}, {-3, -3^Rational[1, 2]}, {Rational[-5, 2], Rational[-1, 2] 3^Rational[1, 2]}, {Rational[-3, 2], Rational[-1, 2] 3^Rational[1, 2]}, {Rational[-1, 2], Rational[-1, 2] 3^Rational[1, 2]}};


standardH8SuperVertices={{0, 0}, {Rational[3, 2], Rational[-1, 2] 3^Rational[1, 2]}, {3, 0}, {Rational[5, 2], Rational[1, 2] 3^Rational[1, 2]}, {Rational[3, 2], Rational[1, 2] 3^Rational[1, 2]}, {Rational[3, 2], Rational[3, 2] 3^Rational[1, 2]}, {3, 2 3^Rational[1, 2]}, {Rational[5, 2], Rational[5, 2] 3^Rational[1, 2]}, {3, 3 3^Rational[1, 2]}, {Rational[7, 2], Rational[7, 2] 3^Rational[1, 2]}, {3, 4 3^Rational[1, 2]}, {Rational[9, 2], Rational[9, 2] 3^Rational[1, 2]}, {Rational[9, 2], Rational[11, 2] 3^Rational[1, 2]}, {Rational[7, 2], Rational[11, 2] 3^Rational[1, 2]}, {3, 6 3^Rational[1, 2]}, {Rational[5, 2], Rational[13, 2] 3^Rational[1, 2]}, {Rational[3, 2], Rational[13, 2] 3^Rational[1, 2]}, {Rational[3, 2], Rational[15, 2] 3^Rational[1, 2]}, {0, 8 3^Rational[1, 2]}, {Rational[-1, 2], Rational[15, 2] 3^Rational[1, 2]}, {Rational[-3, 2], Rational[15, 2] 3^Rational[1, 2]}, {Rational[-3, 2], Rational[17, 2] 3^Rational[1, 2]}, {0, 9 3^Rational[1, 2]}, {Rational[-1, 2], Rational[19, 2] 3^Rational[1, 2]}, {0, 10 3^Rational[1, 2]}, {Rational[1, 2], Rational[21, 2] 3^Rational[1, 2]}, {0, 11 3^Rational[1, 2]}, {Rational[3, 2], Rational[23, 2] 3^Rational[1, 2]}, {3, 11 3^Rational[1, 2]}, {Rational[7, 2], Rational[23, 2] 3^Rational[1, 2]}, {Rational[9, 2], Rational[23, 2] 3^Rational[1, 2]}, {Rational[11, 2], Rational[23, 2] 3^Rational[1, 2]}, {6, 12 3^Rational[1, 2]}, {Rational[15, 2], Rational[23, 2] 3^Rational[1, 2]}, {9, 12 3^Rational[1, 2]}, {Rational[17, 2], Rational[25, 2] 3^Rational[1, 2]}, {9, 13 3^Rational[1, 2]}, {Rational[19, 2], Rational[27, 2] 3^Rational[1, 2]}, {9, 14 3^Rational[1, 2]}, {Rational[21, 2], Rational[29, 2] 3^Rational[1, 2]}, {Rational[21, 2], Rational[31, 2] 3^Rational[1, 2]}, {Rational[19, 2], Rational[31, 2] 3^Rational[1, 2]}, {9, 15 3^Rational[1, 2]}, {Rational[15, 2], Rational[31, 2] 3^Rational[1, 2]}, {Rational[15, 2], Rational[33, 2] 3^Rational[1, 2]}, {Rational[13, 2], Rational[33, 2] 3^Rational[1, 2]}, {6, 17 3^Rational[1, 2]}, {Rational[11, 2], Rational[35, 2] 3^Rational[1, 2]}, {Rational[9, 2], Rational[35, 2] 3^Rational[1, 2]}, {Rational[9, 2], Rational[37, 2] 3^Rational[1, 2]}, {6, 19 3^Rational[1, 2]}, {Rational[11, 2], Rational[39, 2] 3^Rational[1, 2]}, {6, 20 3^Rational[1, 2]}, {Rational[13, 2], Rational[41, 2] 3^Rational[1, 2]}, {6, 21 3^Rational[1, 2]}, {Rational[15, 2], Rational[43, 2] 3^Rational[1, 2]}, {Rational[15, 2], Rational[45, 2] 3^Rational[1, 2]}, {Rational[13, 2], Rational[45, 2] 3^Rational[1, 2]}, {6, 23 3^Rational[1, 2]}, {Rational[11, 2], Rational[47, 2] 3^Rational[1, 2]}, {Rational[9, 2], Rational[47, 2] 3^Rational[1, 2]}, {Rational[9, 2], Rational[49, 2] 3^Rational[1, 2]}, {3, 25 3^Rational[1, 2]}, {Rational[5, 2], Rational[49, 2] 3^Rational[1, 2]}, {3, 24 3^Rational[1, 2]}, {Rational[3, 2], Rational[47, 2] 3^Rational[1, 2]}, {0, 24 3^Rational[1, 2]}, {Rational[-1, 2], Rational[47, 2] 3^Rational[1, 2]}, {Rational[-3, 2], Rational[47, 2] 3^Rational[1, 2]}, {Rational[-5, 2], Rational[47, 2] 3^Rational[1, 2]}, {-3, 23 3^Rational[1, 2]}, {Rational[-9, 2], Rational[47, 2] 3^Rational[1, 2]}, {-6, 23 3^Rational[1, 2]}, {Rational[-11, 2], Rational[45, 2] 3^Rational[1, 2]}, {-6, 22 3^Rational[1, 2]}, {Rational[-13, 2], Rational[43, 2] 3^Rational[1, 2]}, {-6, 21 3^Rational[1, 2]}, {Rational[-15, 2], Rational[41, 2] 3^Rational[1, 2]}, {Rational[-15, 2], Rational[39, 2] 3^Rational[1, 2]}, {Rational[-13, 2], Rational[39, 2] 3^Rational[1, 2]}, {-6, 19 3^Rational[1, 2]}, {Rational[-15, 2], Rational[37, 2] 3^Rational[1, 2]}, {-9, 19 3^Rational[1, 2]}, {Rational[-19, 2], Rational[37, 2] 3^Rational[1, 2]}, {Rational[-21, 2], Rational[37, 2] 3^Rational[1, 2]}, {Rational[-21, 2], Rational[35, 2] 3^Rational[1, 2]}, {-12, 17 3^Rational[1, 2]}, {Rational[-23, 2], Rational[33, 2] 3^Rational[1, 2]}, {-12, 16 3^Rational[1, 2]}, {Rational[-25, 2], Rational[31, 2] 3^Rational[1, 2]}, {-12, 15 3^Rational[1, 2]}, {Rational[-27, 2], Rational[29, 2] 3^Rational[1, 2]}, {-15, 15 3^Rational[1, 2]}, {Rational[-31, 2], Rational[29, 2] 3^Rational[1, 2]}, {Rational[-33, 2], Rational[29, 2] 3^Rational[1, 2]}, {Rational[-35, 2], Rational[29, 2] 3^Rational[1, 2]}, {-18, 14 3^Rational[1, 2]}, {Rational[-39, 2], Rational[29, 2] 3^Rational[1, 2]}, {-21, 14 3^Rational[1, 2]}, {Rational[-41, 2], Rational[27, 2] 3^Rational[1, 2]}, {-21, 13 3^Rational[1, 2]}, {Rational[-43, 2], Rational[25, 2] 3^Rational[1, 2]}, {-21, 12 3^Rational[1, 2]}, {Rational[-45, 2], Rational[23, 2] 3^Rational[1, 2]}, {Rational[-45, 2], Rational[21, 2] 3^Rational[1, 2]}, {Rational[-43, 2], Rational[21, 2] 3^Rational[1, 2]}, {-21, 11 3^Rational[1, 2]}, {Rational[-39, 2], Rational[21, 2] 3^Rational[1, 2]}, {Rational[-39, 2], Rational[19, 2] 3^Rational[1, 2]}, {Rational[-37, 2], Rational[19, 2] 3^Rational[1, 2]}, {-18, 9 3^Rational[1, 2]}, {Rational[-35, 2], Rational[17, 2] 3^Rational[1, 2]}, {Rational[-33, 2], Rational[17, 2] 3^Rational[1, 2]}, {Rational[-33, 2], Rational[15, 2] 3^Rational[1, 2]}, {-18, 7 3^Rational[1, 2]}, {Rational[-35, 2], Rational[13, 2] 3^Rational[1, 2]}, {-18, 6 3^Rational[1, 2]}, {Rational[-37, 2], Rational[11, 2] 3^Rational[1, 2]}, {-18, 5 3^Rational[1, 2]}, {Rational[-39, 2], Rational[9, 2] 3^Rational[1, 2]}, {Rational[-39, 2], Rational[7, 2] 3^Rational[1, 2]}, {Rational[-37, 2], Rational[7, 2] 3^Rational[1, 2]}, {-18, 3 3^Rational[1, 2]}, {Rational[-35, 2], Rational[5, 2] 3^Rational[1, 2]}, {Rational[-33, 2], Rational[5, 2] 3^Rational[1, 2]}, {Rational[-33, 2], Rational[3, 2] 3^Rational[1, 2]}, {-15, 3^Rational[1, 2]}, {Rational[-29, 2], Rational[3, 2] 3^Rational[1, 2]}, {-15, 2 3^Rational[1, 2]}, {Rational[-27, 2], Rational[5, 2] 3^Rational[1, 2]}, {-12, 2 3^Rational[1, 2]}, {Rational[-23, 2], Rational[5, 2] 3^Rational[1, 2]}, {Rational[-21, 2], Rational[5, 2] 3^Rational[1, 2]}, {Rational[-19, 2], Rational[5, 2] 3^Rational[1, 2]}, {-9, 3 3^Rational[1, 2]}, {Rational[-15, 2], Rational[5, 2] 3^Rational[1, 2]}, {Rational[-15, 2], Rational[3, 2] 3^Rational[1, 2]}, {Rational[-13, 2], Rational[3, 2] 3^Rational[1, 2]}, {-6, 3^Rational[1, 2]}, {Rational[-11, 2], Rational[1, 2] 3^Rational[1, 2]}, {Rational[-9, 2], Rational[1, 2] 3^Rational[1, 2]}, {Rational[-9, 2], Rational[-1, 2] 3^Rational[1, 2]}, {-3, -3^Rational[1, 2]}, {Rational[-5, 2], Rational[-1, 2] 3^Rational[1, 2]}, {Rational[-3, 2], Rational[-1, 2] 3^Rational[1, 2]}, {Rational[-1, 2], Rational[-1, 2] 3^Rational[1, 2]}};


standardH7SuperCodes={{{Rational[-9, 2], Rational[37, 2] 3^Rational[1, 2]}, 4, False, 7}, {{-3, 20 3^Rational[1, 2]}, 8, False, 7}, {{-3, 21 3^Rational[1, 2]}, 6, False, 7}, {{-3, 21 3^Rational[1, 2]}, 6, True, 11}, {{Rational[-3, 2], Rational[43, 2] 3^Rational[1, 2]}, 4, False, 7}, {{Rational[3, 2], Rational[45, 2] 3^Rational[1, 2]}, 4, False, 7}, {{3, 22 3^Rational[1, 2]}, 2, False, 7}, {{3, 21 3^Rational[1, 2]}, 0, False, 7}, {{-3, 16 3^Rational[1, 2]}, 2, False, 7}, {{0, 16 3^Rational[1, 2]}, 6, False, 7}, {{Rational[3, 2], Rational[33, 2] 3^Rational[1, 2]}, 4, False, 7}, {{Rational[3, 2], Rational[33, 2] 3^Rational[1, 2]}, 8, True, 11}, {{3, 16 3^Rational[1, 2]}, 2, False, 7}, {{6, 15 3^Rational[1, 2]}, 2, False, 7}, {{6, 14 3^Rational[1, 2]}, 0, False, 7}, {{Rational[9, 2], Rational[27, 2] 3^Rational[1, 2]}, 10, False, 7}, {{Rational[-9, 2], Rational[25, 2] 3^Rational[1, 2]}, 4, False, 7}, {{-3, 12 3^Rational[1, 2]}, 2, False, 7}, {{-3, 12 3^Rational[1, 2]}, 10, True, 11}, {{-3, 11 3^Rational[1, 2]}, 0, False, 7}, {{-3, 9 3^Rational[1, 2]}, 0, False, 7}, {{Rational[-9, 2], Rational[17, 2] 3^Rational[1, 2]}, 10, False, 7}, {{-6, 9 3^Rational[1, 2]}, 8, False, 7}, {{-3, 7 3^Rational[1, 2]}, 0, False, 7}, {{Rational[-3, 2], Rational[11, 2] 3^Rational[1, 2]}, 4, False, 7}, {{0, 5 3^Rational[1, 2]}, 2, False, 7}, {{0, 5 3^Rational[1, 2]}, 10, True, 11}, {{0, 4 3^Rational[1, 2]}, 0, False, 7}, {{0, 2 3^Rational[1, 2]}, 0, False, 7}, {{Rational[-3, 2], Rational[3, 2] 3^Rational[1, 2]}, 10, False, 7}, {{-3, 2 3^Rational[1, 2]}, 8, False, 7}, {{Rational[-15, 2], Rational[15, 2] 3^Rational[1, 2]}, 10, False, 7}, {{-9, 6 3^Rational[1, 2]}, 2, False, 7}, {{-9, 5 3^Rational[1, 2]}, 0, False, 7}, {{-9, 5 3^Rational[1, 2]}, 0, True, 11}, {{Rational[-21, 2], Rational[9, 2] 3^Rational[1, 2]}, 10, False, 7}, {{Rational[-27, 2], Rational[7, 2] 3^Rational[1, 2]}, 10, False, 7}, {{-15, 4 3^Rational[1, 2]}, 8, False, 7}, {{-15, 5 3^Rational[1, 2]}, 6, False, 7}, {{-9, 10 3^Rational[1, 2]}, 8, False, 7}, {{-12, 10 3^Rational[1, 2]}, 0, False, 7}, {{Rational[-27, 2], Rational[19, 2] 3^Rational[1, 2]}, 10, False, 7}, {{Rational[-27, 2], Rational[19, 2] 3^Rational[1, 2]}, 2, True, 11}, {{-15, 10 3^Rational[1, 2]}, 8, False, 7}, {{-18, 11 3^Rational[1, 2]}, 8, False, 7}, {{-18, 12 3^Rational[1, 2]}, 6, False, 7}, {{Rational[-33, 2], Rational[25, 2] 3^Rational[1, 2]}, 4, False, 7}};


standardH8SuperCodes={{{-9, 19 3^Rational[1, 2]}, 0, False, 7}, {{Rational[-15, 2], Rational[35, 2] 3^Rational[1, 2]}, 4, False, 7}, {{-6, 17 3^Rational[1, 2]}, 2, False, 7}, {{-6, 17 3^Rational[1, 2]}, 10, True, 11}, {{-6, 16 3^Rational[1, 2]}, 0, False, 7}, {{-6, 14 3^Rational[1, 2]}, 0, False, 7}, {{Rational[-15, 2], Rational[27, 2] 3^Rational[1, 2]}, 10, False, 7}, {{-9, 14 3^Rational[1, 2]}, 8, False, 7}, {{Rational[-9, 2], Rational[37, 2] 3^Rational[1, 2]}, 4, False, 7}, {{-3, 20 3^Rational[1, 2]}, 8, False, 7}, {{-3, 21 3^Rational[1, 2]}, 6, False, 7}, {{-3, 21 3^Rational[1, 2]}, 6, True, 11}, {{Rational[-3, 2], Rational[43, 2] 3^Rational[1, 2]}, 4, False, 7}, {{Rational[3, 2], Rational[45, 2] 3^Rational[1, 2]}, 4, False, 7}, {{3, 22 3^Rational[1, 2]}, 2, False, 7}, {{3, 21 3^Rational[1, 2]}, 0, False, 7}, {{-3, 16 3^Rational[1, 2]}, 2, False, 7}, {{0, 16 3^Rational[1, 2]}, 6, False, 7}, {{Rational[3, 2], Rational[33, 2] 3^Rational[1, 2]}, 4, False, 7}, {{Rational[3, 2], Rational[33, 2] 3^Rational[1, 2]}, 8, True, 11}, {{3, 16 3^Rational[1, 2]}, 2, False, 7}, {{6, 15 3^Rational[1, 2]}, 2, False, 7}, {{6, 14 3^Rational[1, 2]}, 0, False, 7}, {{Rational[9, 2], Rational[27, 2] 3^Rational[1, 2]}, 10, False, 7}, {{Rational[-9, 2], Rational[25, 2] 3^Rational[1, 2]}, 4, False, 7}, {{-3, 12 3^Rational[1, 2]}, 2, False, 7}, {{-3, 12 3^Rational[1, 2]}, 10, True, 11}, {{-3, 11 3^Rational[1, 2]}, 0, False, 7}, {{-3, 9 3^Rational[1, 2]}, 0, False, 7}, {{Rational[-9, 2], Rational[17, 2] 3^Rational[1, 2]}, 10, False, 7}, {{-6, 9 3^Rational[1, 2]}, 8, False, 7}, {{-3, 7 3^Rational[1, 2]}, 0, False, 7}, {{Rational[-3, 2], Rational[11, 2] 3^Rational[1, 2]}, 4, False, 7}, {{0, 5 3^Rational[1, 2]}, 2, False, 7}, {{0, 5 3^Rational[1, 2]}, 10, True, 11}, {{0, 4 3^Rational[1, 2]}, 0, False, 7}, {{0, 2 3^Rational[1, 2]}, 0, False, 7}, {{Rational[-3, 2], Rational[3, 2] 3^Rational[1, 2]}, 10, False, 7}, {{-3, 2 3^Rational[1, 2]}, 8, False, 7}, {{Rational[-15, 2], Rational[15, 2] 3^Rational[1, 2]}, 10, False, 7}, {{-9, 6 3^Rational[1, 2]}, 2, False, 7}, {{-9, 5 3^Rational[1, 2]}, 0, False, 7}, {{-9, 5 3^Rational[1, 2]}, 0, True, 11}, {{Rational[-21, 2], Rational[9, 2] 3^Rational[1, 2]}, 10, False, 7}, {{Rational[-27, 2], Rational[7, 2] 3^Rational[1, 2]}, 10, False, 7}, {{-15, 4 3^Rational[1, 2]}, 8, False, 7}, {{-15, 5 3^Rational[1, 2]}, 6, False, 7}, {{-9, 10 3^Rational[1, 2]}, 8, False, 7}, {{-12, 10 3^Rational[1, 2]}, 0, False, 7}, {{Rational[-27, 2], Rational[19, 2] 3^Rational[1, 2]}, 10, False, 7}, {{Rational[-27, 2], Rational[19, 2] 3^Rational[1, 2]}, 2, True, 11}, {{-15, 10 3^Rational[1, 2]}, 8, False, 7}, {{-18, 11 3^Rational[1, 2]}, 8, False, 7}, {{-18, 12 3^Rational[1, 2]}, 6, False, 7}, {{Rational[-33, 2], Rational[25, 2] 3^Rational[1, 2]}, 4, False, 7}};


(* ::Subsubsection::Closed:: *)
(*super cluster tile polygon*)


superCluster[pos_,dir_:0,pt_,choice_:True]:=With[{
	vertices=If[
		TrueQ[choice],
			standardH8SuperVertices . Transpose[RotationMatrix[dir*Pi/6]],
			standardH7SuperVertices . Transpose[RotationMatrix[dir*Pi/6]]
			]
	},
	Polygon[vertices+Threaded[pos-vertices[[pt]]]]
]


(* ::Subsubsection::Closed:: *)
(*super cluster vertices*)


superClusterVertices[pos_, dir_:0,pt_, choice_:True]:= With[{
	vertices=If[
		TrueQ[choice],
			standardH8SuperVertices . Transpose[RotationMatrix[dir*Pi/6]],
			standardH7SuperVertices . Transpose[RotationMatrix[dir*Pi/6]]
			]
	},
	vertices+Threaded[pos-vertices[[pt]]]
]


(* ::Subsubsection::Closed:: *)
(*super cluster code*)


superClusterCode[pos_,dir_,pt_,True]:=With[{vertices = standardH8SuperVertices},
{
		pos + RotationMatrix[dir Pi/6] . (#1-vertices[[pt]]),
		Mod[If[TrueQ[#3], -dir, dir] + #2,12],
		#3,#4
	}& @@@ standardH8SuperCodes
]


superClusterCode[pos_,dir_,pt_,False]:=With[{vertices = standardH7SuperVertices},
{
		pos + RotationMatrix[dir Pi/6] . (#1-vertices[[pt]]),
		Mod[If[TrueQ[#3], -dir, dir] + #2, 12],
	#3,#4
	}& @@@ standardH7SuperCodes
]


(* ::Section::Closed:: *)
(*Build Cluster Tiling State*)


clusterTilingState[code_]:=<|"code"->code,
	"boundaryPoints" -> Select[
		clusterPointsInformation[code],
		Total[Lookup[clusterVertexAngles[Last[#2]], #1]& @@@ #] <1 &]
	|>;


(* ::Section::Closed:: *)
(*Visualize Cluster*)


Options[visualize]={ChooseColor -> {Lighter@Blue, Lighter@Red}};
visualize[code_List, opt : OptionsPattern[]]:=Graphics[
{
	OptionValue[ChooseColor][[1]],EdgeForm[Darker@OptionValue[ChooseColor][[1]]],Opacity[.5],
	cluster@@@Select[code,MemberQ[True]],
	OptionValue[ChooseColor][[2]],EdgeForm[Darker@OptionValue[ChooseColor][[2]]],Opacity[.5],
	cluster@@@Select[code,MemberQ[False]]
}];


(* ::Section::Closed:: *)
(*Draw Cluster Information*)


drawClusterInfomration[tiling_Association, opt : OptionsPattern[]] := Show[{
		visualize[tiling["code"], Sequence @@ FilterRules[{opt}, Options[visualize]]],
		Graphics[{Red, Disk[Keys[tiling["boundaryPoints"]], 0.3]}]
	},
		Sequence @@ FilterRules[{opt}, Options[Show]]
	]


(* ::Section::Closed:: *)
(*Vertex Angle Information*)


clusterVertexAngles[True]=Association[
1->3/4,2->1/3,3->1/4,4->1/3,5->3/4,6->2/3,7->1/4,8->2/3,
9->1/2,10->1/3,11->3/4,12->1/3,13->1/4,14->2/3,15->1/2,
16->1/3,17->3/4,18->1/3,19->1/4,20->1/3,21->3/4,22->2/3,
23->1/4,24->2/3,25->1/4,26->2/3,27->1/4,28->2/3,29->1/2,
30->1/3,31->3/4,32->1/3,33->1/4,34->2/3,35->1/2,36->1/3,
37->3/4,38->1/3,39->1/4,40->2/3,41->1/2,42->1/3];
clusterVertexAngles[False]=Association[
1->3/4,2->1/3,3->1/4,4->1/3,5->3/4,6->2/3,7->1/4,8->2/3,
9->1/2,10->1/3,11->3/4,12->1/3,13->1/4,14->2/3,15->1/2,
16->1/3,17->3/4,18->1/3,19->1/4,20->1/3,21->3/4,22->1/3,
23->1/4,24->2/3,25->3/4,26->2/3,27->1/4,28->2/3,29->1/2,
30->1/3,31->1/2,32->1/3,33->3/4,34->1/3,35->1/4,36->2/3,
37->1/2,38->1/3,39->3/4,40->1/3,41->1/4,42->2/3,43->1/2,44->1/3];


oneThirdClusterVertex[True]={2,4,10,12,16,18,20,30,32,36,38,42};
oneThirdClusterVertex[False]={2,4,10,12,16,18,20,22,30,32,34,38,40,44};


twoThirdClusterVertex[True]={6,8,14,22,24,26,28,34,40};
twoThirdClusterVertex[False]={6,8,14,24,26,28,36,42};


oneFourthClusterVertex[True]={3,7,13,19,23,25,27,33,39};
oneFourthClusterVertex[False]={3,7,13,19,23,27,35,41};


oneHalfClusterVertex[True]={9,15,29,35,41};
oneHalfClusterVertex[False]={9,15,29,31,37,43};


threeFourthClusterVertex[True]={1,5,11,17,21,31,37};
threeFourthClusterVertex[False]={1,5,11,17,21,25,33,39};


(* ::Section::Closed:: *)
(*Vertex configuration list*)


(* ::Subsection::Closed:: *)
(*1/3*)


oneThirdTheoremListCluster={
{{0,20,True},{4,20,True},{0,4,True}},
{{0,20,True},{4,20,True},{0,4,False}},
{{0,20,True},{8,4,True},{0,4,True}},
{{0,20,True},{8,4,True},{0,4,False}},
{{0,4,True},{4,4,True},{8,4,True}},
{{0,38,True},{6,32,True},{4,12,True}},
{{0,38,True},{6,32,True},{10,32,True}},
{{0,38,True},{6,32,True},{4,12,False}},
{{0,32,True},{10,12,True},{2,12,True}},
{{0,32,True},{10,12,True},{8,32,True}},
{{0,32,True},{10,12,False},{2,12,True}},
{{0,12,True},{4,12,True},{8,12,True}}
};


(* ::Subsection::Closed:: *)
(*1/3+2/3*)


oneThirdAndTwoThirdTheoremListCluster={
{{0,24,False},{0,4,True}},
{{0,24,True},{8,16,True}},
{{0,24,True},{10,10,True}},
{{0,24,True},{0,42,True}},
{{0,24,True},{0,44,False}},
{{0,24,True},{2,38,False}},
{{0,24,True},{4,32,False}},
{{0,28,False},{0,42,True}},
{{0,26,True},{10,18,True}},
{{0,26,True},{2,2,True}},
{{0,26,True},{4,38,True}},
{{0,26,True},{10,18,False}},
{{0,26,False},{0,2,True}},
{{0,6,True},{4,18,True}},
{{0,6,True},{8,2,True}},
{{0,6,True},{10,38,True}},
{{0,6,False},{4,18,True}},
{{0,6,False},{8,2,True}},
{{0,22,True},{8,18,True}},
{{0,22,True},{10,12,True}},
{{0,22,True},{0,2,True}},
{{0,22,True},{0,2,False}},
{{0,22,True},{2,40,False}},
{{0,22,True},{4,34,False}},
{{0,6,True},{0,22,False}},
{{0,40,True},{2,4,True}},
{{0,14,True},{2,20,True}},
{{0,8,True},{0,20,False}},
{{0,42,False},{10,20,True}},
{{0,36,False},{8,20,True}},
{{0,40,True},{0,30,False}},
{{0,40,True},{4,10,True}},
{{0,40,True},{10,30,True}},
{{0,40,True},{4,10,False}},
{{0,34,True},{2,10,True}},
{{0,34,True},{6,36,True}},
{{0,34,True},{8,30,True}},
{{0,14,True},{8,10,True}},
{{0,14,True},{2,30,True}},
{{0,14,True},{8,10,False}},
{{0,8,True},{4,16,True}},
{{0,8,True},{8,42,True}},
{{0,8,True},{10,36,True}},
{{0,14,False},{2,30,True}},
{{0,8,False},{4,16,True}},
{{0,8,False},{8,42,True}},
{{0,28,True},{10,16,True}},
{{0,28,True},{2,42,True}},
{{0,28,True},{4,36,True}},
{{0,28,True},{10,16,False}}
};


(* ::Section::Closed:: *)
(*Cluster 1/3 and 2/3 points information*)


clusterPointsInformation[code_] := Block[{
	inf=<||>
},
	Scan[
		Function[tileCode,
			MapThread[
				If[
					KeyExistsQ[inf,#1],
					AppendTo[inf[#1],#2->tileCode],
					AssociateTo[inf,#1->{#2->tileCode}]
				]&,
				{
					Part[
						First[cluster@@tileCode],
						Join[oneThirdClusterVertex[Last[tileCode]],twoThirdClusterVertex[Last[tileCode]]]
					],
					Join[oneThirdClusterVertex[Last[tileCode]],twoThirdClusterVertex[Last[tileCode]]]
				}
			]
		],
		code
	];
	inf
];


(* ::Section::Closed:: *)
(*Pattern Match Generator*)


generatorH8[boundaryPointsInf_]:=Block[{
	allPossibleConfigurations = Transpose[
		Function[r,
			Apply[
				{ Mod[#1+r,12], #2, #3}&,
				Join[oneThirdTheoremListCluster, oneThirdAndTwoThirdTheoremListCluster],
			{2}]
		] /@ Range[0,11]
	],
	pointsBranches
},
	pointsBranches = With[
	{
		canonicalInf=Map[{#[[2,2]],#[[1]],#[[2,4]]}&,boundaryPointsInf,{2}]
	},
		Association[
			KeyValueMap[
				Function[{pt,conf}, pt -> Map[Prepend[#,pt]&, conf, {2}]]
				,
				Association[
					KeyValueMap[
						Function[{pt,conf},
							pt -> DeleteDuplicatesBy[
							(If[
								SubsetQ[#,conf],
								Complement[#,conf],
								Nothing
							]& /@ (Join @@ allPossibleConfigurations)), Sort]
						],
						canonicalInf
					]
				]
			]
		]
	];
	pointsBranches
]


(* ::Section::Closed:: *)
(*Main Grow Function*)


Options[growH8Tiling] = {branchNumLimit -> Infinity, ChoosePoints -> False};
growH8Tiling[state_, opt:OptionsPattern[]]:=Block[
{
	pointsBranches = generatorH8[
		Select[
			If[
				OptionValue[ChoosePoints] =!= False,
				KeySelect[state["boundaryPoints"], MemberQ[OptionValue[ChoosePoints], #]&],
				state["boundaryPoints"]
			],
			Total[Lookup[clusterVertexAngles[Last[#2]], #1, {}]& @@@ #] <1 &]
		],
	intersectionTestFunction,
	boundaryTiles = DeleteDuplicates[Join @@ Values[state["boundaryPoints"]][[All,All,2]]],
	boundaryPoints,
	innerPoints
},
	
	If[Length[pointsBranches]===0,Return[{}]];
	
	With[
		{invalidVertices = Keys[Select[pointsBranches, Length[#]==0&]]},
		If[
			Length[invalidVertices] > 0,
			Sow[invalidVertices];
			Print["invalid Vertices:", invalidVertices];
			Return[{}]
		]
	];
	
	boundaryPoints = Union @@ (clusterVertices @@@ boundaryTiles);
	
	innerPoints = Join @@ (clusterInnerVertices @@@ boundaryTiles);
	
	intersectionTestFunction=Function[newCode,
		With[{
			newBoundaryPoints=Union@@(clusterVertices@@@newCode),
			newInnerPoints=Join@@(clusterInnerVertices@@@newCode)
		},
		If[
			IntersectingQ[boundaryPoints,newInnerPoints]||
			IntersectingQ[newBoundaryPoints,innerPoints]||
			IntersectingQ[newInnerPoints,innerPoints],
			Nothing,
			newCode
		]
		]
	];
	
	pointsBranches = GroupBy[
		Map[intersectionTestFunction, Select[pointsBranches, Length[#] <= OptionValue[branchNumLimit]& ], {2}],
	Length];
	
	If[
		KeyExistsQ[pointsBranches, 0],
			With[
			{impossibleVertices = Keys[pointsBranches[0]]},
			If[
				Length[impossibleVertices]>0,
				Sow[impossibleVertices];
				Print["impossible Vertices:",impossibleVertices];
				Return[{}]
			]
		]
	];
	
	If[
		KeyExistsQ[pointsBranches,1],
		
		{clusterTilingState[Join[state["code"], DeleteDuplicatesBy[canonicalCluster][Join@@(Join@@pointsBranches[1])]]]},
		
		clusterTilingState[Join[state["code"], #]]& /@ First[
				TakeSmallestBy[
					First[KeySort[pointsBranches]]
				,
				- Count[#[[All, All, 4]], False, {2}]&,
				1
				]
			]
	]
]


(* ::Section::Closed:: *)
(*End*)


End[]
EndPackage[]
