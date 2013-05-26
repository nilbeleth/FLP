import System.IO
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

flns :: FilePath -> FilePath -> IO()
flns fin fout = do
	hin <- openFile fin ReadMode
	hout <- openFile fout WriteMode
	cin <- hGetContents hin
	hPutStr hout $ unlines $ mknums 1 $ lines cin
	hClose hout
	hClose hin


mknums :: (Num a, Show a) => a -> [String] -> [String]
mknums _ [] = []
mknums n (l:ls) =
	putn n l : mknums (n+1) ls
	where
		putn n l = sx (show n) ++ (' ' : l)
		sx n =
			if length n >= 5 then n
			else reverse $ take 5 $ (reverse n ++ repeat ' ')