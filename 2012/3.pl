%% 1) Nalezněte nejkratší cestu mezi dvěma body na šachovnici, která může mít i obdélníkové rozměry, s predikátem zakazujícím vstup na pole (obecně)


%% 2) Nadefinovat predikáty pro práci s BVS, pokud je zadaný klíč, vyhledává hodnotu, 
%%    pokud hodnota, vyhledává klíče, pokud hodnota i klíč, predikát uspěje jen pokud
%%    je hodnota s klíčem ve stromu.

search(Key, Value, node(NKey, NValue, Left, Right)) :-
	var(Key), nonvar(Value), 
	( 
		Value == NValue, 
		Key = NKey,!
	;
		search(Key,Value,Left);
		search(Key,Value,Right)
	),!.
search(Key, Value, node(NKey, NValue, Left, Right)) :-
	nonvar(Key), var(Value),
	(
		Key == NKey,
		Value = NValue,!
	;
		(
			Key < NKey,
			search(Key,Value,Left)
		;
			search(Key,Value,Right)
		)
	),!.
% pridavanie naprosto nefuguje pretoze netusim co po mne vlastne chcu
search(Key, Value, node(NKey, NValue, Left, Right)) :- 
	nonvar(Key), nonvar(Value),
	(
		Key < NKey,
		( Left == leaf, Left = node(Key,Value,leaf,leaf) ; search(Key, Value, Left))
	;
		( Right == leaf, Right = node(Key,Value,leaf,leaf) ; search(Key, Value, Left))
	).



%% 3) V holém Prologu nadefinujte predikát XOR, který spočte symetrický rozdíl dvou množin

xor(AS,BS,R) :- diff(AS,BS,AB), diff(BS,AS,BA), union(AB,BA,R),!.

union([],BS,BS).
union([A|AS],BS,[A|R]) :- \+ mem(BS, A), union(AS,BS,R),!.
union([A|AS],BS,R) :- mem(BS,A), union(AS,BS,R),!.

diff([],_,[]).
diff([A|AS],BS,[A|R]) :- \+ mem(BS,A), diff(AS,BS,R),!.
diff([A|AS],BS,R) :- mem(BS,A),diff(AS,BS,R).

mem([H|_],H) :- !.
mem([_|T],X) :- mem(T,X).



%% 4) Pomocí 2 klauzulí rozdělte seznam na 2 dle úspěchu předaného predikátu, kdy v prvním
%%    seznamu budou prvky, pro které predikát platí, a v druhém ty, pro které neplatí

classify([],_,[],[]).
classify([L|LS],P,T,F) :- classify(LS,P,TT,FF), G=..[P,L], (call(G) -> T = [L|TT], F = FF ; T = TT, F = [L|FF]).

odd(X) :- X mod 2 =:= 1.

whatever(X) :- X > 2.