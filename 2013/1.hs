-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
--                                                            %%
-- 3) Definovat lambda vyraz, funkce která vrací 1 když jsou  %%
--    dva lambda výrazy shodné, 0 když jiné proměné (ne alfa  %%
--    konverze) a -1 když jsou různé                          %%
--                                                            %%
-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

data LE a
	= Var a
	| App (LE a) (LE a)
	| Abs a (LE a)
	deriving Show


cmpLE :: Eq a => LE a -> LE a -> Int
cmpLE (Var a) (Var b) = if a == b 
	then 1
	else 0
cmpLE (App e11 e12) (App e21 e22) =
	min (cmpLE e11 e21) (cmpLE e12 e22)
cmpLE (Abs a e1) (Abs b e2) =
	if a == b
	then cmpLE e1 e2
	else min 0 (cmpLE e1 e2)
cmpLE _ _ = -1


-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
--                                                            %%
-- 4) IO – načíst soubor, očíslovat řádky, zarovnání čísla    %%
--    na 5 doprava                                            %%
--                                                            %%
-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
