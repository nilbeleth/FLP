%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                 %%
%% 1) destroy - ze seznamu zanorenych seznamů udělá jeden seznam   %%
%%                                                                 %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

destrct([], []).
destrct([[]|X], Y) :- destrct(X,Y),!.
destrct([[H|T]|X],Y) :- destrct([H|[T|X]],Y),!.
destrct([H|T],[H|TT]) :- destrct(T,TT).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                 %%
%% 2) scitani cisel reprezentovancýh seznamy (např.                %%
%%    [9,8] + [1,3] = [1,1,1])                                     %%
%%                                                                 %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

addLists([],B,B).
addLists(A,[],A).
addLists(A,B,R) :- list2int(A,I1), list2int(B,I2), I is I1 + I2, int2list(I,R).


list2int(L, R) :- rev(L,LL), sumL(LL,R).

sumL([X],X) :- !.
sumL([H|T],R) :- sumL(T,X), R is H + 10*X.


int2list(0,0) :- !.
int2list(I,R) :- rev(RR, R), sumI(I,RR),!.

sumI(0, []) :- !.
sumI(I,[R|L]) :- R is I rem 10, II is I div 10, sumI(II,L).


rev([],Z,Z).
rev([H|T],Z,W) :- rev(T, [H|Z], W).
rev(A,R) :- rev(A,[],R).

%appendI([],I,[I]).
%appendI([H|T],I,[H|Z]) :- appendI(T,I,Z).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                 %%
%% 3) reprezentace bool. výrazů, vyhodnocení, predikát             %%
%%    evalLE(bool,table,result)                                    %%
%%                                                                 %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                 %%
%% 4) všechny cesty délky 20 – 22, predikát na ziskaní nové pozice danej
%%                                                                 %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%