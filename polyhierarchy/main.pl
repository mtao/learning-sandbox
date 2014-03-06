:- use_module(library(lists)).


%If Vx is in RX and this is the discrete case 
validate(discrete(L),V) :- member(V,L).
validate(root,_).

%

parentsValid([],_).
%parentsValid([RX],Props) :- intParentsValid(RX,Props,[],_).
parentsValid([N|Rem],Props) :- N = node(_,_,Props), N, parentsValid(Rem,Props).

node(Valid,Roots,Properties) :- validate(Valid,V), member(V,Properties),parentsValid(Roots,Properties).



carType(node(discrete([type('Ford'),type('Lambo')]), [], A),A).
carYear(node(discrete([year(1999),year(2000),year(2001)]), [], B),B).

carElectricType(node(discrete([electric('Yes'),electric('No')]),[B,C],A),A) :- carType(B,_), carYear(C,_).
%, member(type('Ford'),A), member(year(1999),A).

nodeOneManyEdges(_,[], []).
nodeOneManyEdges(A,[X|Xs], [edge(A,V)|CRet]) :- X = node(V,_,_),nodeOneManyEdges(A,Xs,CRet).

nodeChildEdges([],[]).
nodeChildEdges([X|Xs],Ret) :- nodeToEdgeList(X,ChildEdges), nodeChildEdges(Xs,NRet), append(ChildEdges,NRet,Ret).

nodeToEdgeList(node(A,Xs,_), EL) :- display(A),nodeOneManyEdges(A,Xs,MyEdges), display('\n'),display(MyEdges), nodeChildEdges(Xs,ChildEdges), append(ChildEdges,MyEdges,EL).

nodeToEdges(G,EL) :- nodeChildEdges(G,EL).

nodeLeq(GA, GB) :- nodeChildEdges(GA,ELA), nodeChildEdges(GB,ELB), subset(ELA,ELB).


carNode(A,B) :- carElectricType(A,B),!.
carNode(A,B) :- carType(A,B),!.
carNode(A,B) :- carYear(A,B),!.
%carRoot( X ) :- myCar(A,Name), carType(B,A), carYear(C,A), node(root,[B,C],A), display(Name),display(A).

%carQuery(L) :- carNode(N,L),N.%, !, myCar(A,Name), subset(L,A), display(X), display(Name).
carQuery(L) :- carNode(X,L), X,  myCar(A,Name), subset(L,A), display(X), display(Name).
%carRoot(A ) :- myCar(A), node(root,[B,C],A), carType(B), carYear(C).


myCar(
[
type('Ford')
,year(2000)
],'Ford 2000').

myCar(
[
type('Ford')
,year(2001)
], 'Ford 2001').
myCar(
[
type('Lambo')
,year(2001)
], 'Lambo 2001').
myCar(
[
type('Ford')
,year(1999)
,electric('Yes')
], 'Electric Ford 1999').

%invertNodeInstanceInternal(Nodes,Children, NI) :- invertNodeInstanceLayer(Nodes,Res), N = nodeInstance(Val,Children), invertNodeInstanceInternalAccum([],
%invertNodeInstance(RNI, NI) :- invertNodeInstanceInternal(RNI,[],NI).

%nodeOneManyEdges(A,[], []).
%nodeOneManyEdges(A,[X|Xs], [edge(A,X)|CRet]) :- nodeOneManyEdges(A,Xs,CRet).
%nodeInstancesToEdgeList(nodeInstance(A,Xs), EL) :- nodeOneManyEdges(A,Xs,MyEdges), nodeChildEdges(Xs,childEdges), append(ChildEdges,MyEdges,EL).
%
%nodeChileEdges([],_).
%nodeChildEdges([X|Xs],Ret) :- nodeInstancesToEdgeList(X,ChildEdges), nodeChildEdges(Xs,NRet), append(ChildEdges,NRet,Ret).
%
%invertEdgeList([],[]).
%invertEdgeList([edge(A,B)|Xs],[edge(B,A)|Rest]) :- invertEdgeList(Xs,Rest).
%
%edgeListFindRootEdges([],[],[]).
%edgeListFindRootEdges([X|Xs],[X|R],E) :- X = edge(root,_), edgeListFindRootEdges(Xs,R,E).
%edgeListFindRootEdges([X|Xs],R,[X|E]) :- edgeListFindRootEdges(Xs,R,E).
%
%getFirstItem([],[]).
%getFirstItem([edge(A,_)|Xs],[A|R]) :- getFirstItem(Xs,R).
%
%getSecondMatchItem([],[],[]).
%getSecondMatchItem(M,[edge(M,A)|Xs],[A|R],S) :- getSecondMatchItem(Xs,R,S).
%getSecondMatchItem(_,[X|Xs],R,[X|S]) :- getSecondMatchItem(Xs,R,S).
%
%%Go through all of the nodes and get the new current node instances, leafs, edges
%% PAram1 gets exhausted, remEdgeList,curNS get overwritten, Leafs gets accumulated on the way back up, and RemEdges and NS are fed from the bottom
%topExistingNodeInstanceLayer([],REL,NS,LF,REL,NS).
%topExistingNodeInstanceLayer([Node|Ns], RemEdgeList, CurNS, Leafs, RemEdges, NS) :- getSecondMatchItem(Node,RemEdgeList,NNewLeafs, NRemEdges), append(CurLeafs,NewLeafs,Leafs),
%                                                                                        topExistingNodeInstanceLayer(Ns,NRemEdges,NewNS,NewLeafs,RemEdges,NS).
%
%% While there's still elements to sweep through from root to leaves to generate predicates
%createNextNodeInstanceLayer([],_,NS,NS).
%createNextNodeInstanceLayer(REL, Rem,CurNS, NS) :- getFirstItem(REL,Keys), list_to_set(Keys,RES), topExistingNodeInstanceLayer(RES,REL,CurNS,NewLeafs,RemEdges,NewNS), createNextNodeInstanceLayer(NewLeafs,RemEdges,NewNS,NS).
%
%edgeListToNodeInstances(EL,NS) :- edgeListFindRootEdges(EL,RootEdges,NonRootEdges), creatNextNodeInstanceLayer(RootEdges,NonRootEdges,[],NS).

%query([L|Ls]) :- 
