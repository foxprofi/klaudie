-- =====================================================
-- TASK LIBRARY - HOUSEHOLD EXTENDED (90 tasks)
-- =====================================================
-- This seed adds remaining Household tasks to reach 120 total
-- Categories: cleaning, cooking, laundry, organization, maintenance, shopping

USE klaudie;

-- HOUSEHOLD - CLEANING (30 tasks)
INSERT INTO task_library (title, description, category, subcategory, difficulty, level_required, bdsm_intensity, duration_minutes, instructions) VALUES
-- Trivial cleaning
('Utřít pracovní plochu v kuchyni', 'Důkladně utřít všechny pracovní plochy v kuchyni', 'household', 'cleaning', 'trivial', 1, 'none', 10, 'Použít čistící prostředek a utěrku. Utřít všechny plochy včetně varné desky.'),
('Vynést odpadkový koš', 'Vynést odpadkový koš z kuchyně a vyměnit pytel', 'household', 'cleaning', 'trivial', 1, 'none', 5, 'Vynést plný pytel, koš vytřít zevnitř, vložit nový pytel.'),
('Uklidit jídelní stůl', 'Uklidit a utřít jídelní stůl po jídle', 'household', 'cleaning', 'trivial', 1, 'none', 10, 'Odstranit všechny předměty, utřít stůl vlhkým hadrem.'),
('Utřít zrcadlo v koupelně', 'Vyčistit zrcadlo v koupelně do lesku', 'household', 'cleaning', 'trivial', 1, 'none', 10, 'Použít prostředek na okna nebo octovou vodu. Utřít do lesku.'),
('Vysát předsíň', 'Vysát podlahu v předsíni a chodbě', 'household', 'cleaning', 'trivial', 1, 'none', 15, 'Použít vysavač, důkladně vysát všechny kouty.'),
('Utřít prach z televizoru', 'Utřít prach z televize a elektroniky', 'household', 'cleaning', 'trivial', 1, 'none', 10, 'Použít antistatický hadřík, jemně utřít displej.'),
-- Easy cleaning
('Vytřít podlahu v koupelně', 'Vytřít podlahu v koupelně dezinfekčním prostředkem', 'household', 'cleaning', 'easy', 1, 'none', 20, 'Nejprve zamést/vysát, pak vytřít s čistícím prostředkem.'),
('Vyčistit umyvadlo a vanu', 'Důkladně vyčistit umyvadlo a vanu', 'household', 'cleaning', 'easy', 1, 'none', 20, 'Použít vhodný čistící prostředek, vydrhnout vanu/umyvadlo, opláchnout.'),
('Uklidit a vysát ložnici', 'Uklidit a důkladně vysát celou ložnici', 'household', 'cleaning', 'easy', 1, 'none', 30, 'Uklidit věci na místo, vysát podlahu i pod postelí.'),
('Utřít prach ve všech místnostech', 'Utřít prach ze všech povrchů v bytě', 'household', 'cleaning', 'easy', 1, 'none', 30, 'Postupovat místnost po místnosti, utírat shora dolů.'),
('Vyčistit WC misu a okolí', 'Vyčistit WC misu, prkénko, okolí', 'household', 'cleaning', 'easy', 1, 'none', 20, 'Použít WC prostředek, kartáč, dezinfekci. Vyčistit i okolí.'),
('Vytřít podlahu v kuchyni', 'Vytřít celou podlahu v kuchyni', 'household', 'cleaning', 'easy', 1, 'none', 20, 'Nejprve zamést, pak vytřít s čistícím prostředkem.'),
-- Medium cleaning
('Vyčistit celou koupelnu', 'Kompletní úklid koupelny včetně obkladů', 'household', 'cleaning', 'medium', 2, 'none', 45, 'WC, umyvadlo, vana, obklady, zrcadlo, podlaha - vše vyčistit.'),
('Vysát a vytřít všechny podlahy', 'Vysát a vytřít podlahy ve všech místnostech', 'household', 'cleaning', 'medium', 2, 'none', 60, 'Nejprve vysát všude, pak vytřít všechny podlahy.'),
('Uklidit a vyčistit lednici', 'Vybrat lednici, vyčistit, uklidit zpět', 'household', 'cleaning', 'medium', 2, 'none', 45, 'Vybrat potraviny, vyčistit všechny poličky, zkontrolovat trvanlivost.'),
('Vyčistit sporák a troubu', 'Důkladně vyčistit sporák a vnitřek trouby', 'household', 'cleaning', 'medium', 2, 'none', 45, 'Odmastit sporák, vyčistit troubu čistícím prostředkem.'),
('Umýt okna v jedné místnosti', 'Umýt okna včetně rámů v jedné místnosti', 'household', 'cleaning', 'medium', 2, 'none', 40, 'Umýt skla i rámy, utřít parapety.'),
('Vyčistit koupelnové obklady', 'Vyčistit všechny obklady v koupelně', 'household', 'cleaning', 'medium', 2, 'none', 30, 'Použít vhodný prostředek, vyčistit spáry mezi dlaždicemi.'),
-- Hard cleaning
('Kompletní úklid celého bytu', 'Vysát, vytřít, utřít prach ve všech místnostech', 'household', 'cleaning', 'hard', 3, 'none', 120, 'Systematicky uklidit celý byt - vysát, vytřít, utřít prach všude.'),
('Umýt všechna okna v bytě', 'Umýt všechna okna včetně rámů a parapetů', 'household', 'cleaning', 'hard', 3, 'none', 90, 'Všechna okna vevnitř i zvnějšku, rámy, parapety.'),
('Generální úklid kuchyně', 'Kompletní vyčištění kuchyně včetně spotřebičů', 'household', 'cleaning', 'hard', 3, 'none', 120, 'Lednice, sporák, trouba, mikrovlnka, digestoř, obklady, skříňky.'),
('Vyčistit digestoř a filtry', 'Vyjmout a vyčistit filtry digestoře, odmastit', 'household', 'cleaning', 'hard', 3, 'none', 45, 'Vyjmout filtry, namočit v odmaštění, vydrhnout, vyčistit digestoř.'),
('Uklidit a vyčistit všechny skříně', 'Vybrat, vyčistit a uklidit všechny skříně v bytě', 'household', 'cleaning', 'hard', 3, 'none', 150, 'Postupně vybrat každou skříň, vyčistit, třídit, uklidit zpět.'),
('Vyčistit koupelnu vč. spár', 'Vyčistit celou koupelnu včetně vyčištění spár', 'household', 'cleaning', 'hard', 3, 'none', 90, 'Použít prostředky na plíseň a vodní kámen, vyčistit spáry.'),
-- Extreme cleaning
('Jarní úklid celého bytu', 'Kompletní generální úklid včetně těžko dostupných míst', 'household', 'cleaning', 'extreme', 4, 'none', 300, 'Úklid všeho včetně oken, za nábytkem, lustry, žaluzie, radiátory.'),
('Vyčistit sporák profesionálně', 'Rozmontovat a vyčistit sporák do detailu', 'household', 'cleaning', 'extreme', 4, 'none', 120, 'Rozmontovat plotýnky, vyčistit všechny díly, odmastit vše.'),
('Umýt stěny v jedné místnosti', 'Umýt všechny stěny v jedné místnosti', 'household', 'cleaning', 'extreme', 4, 'none', 180, 'Postupně umýt všechny stěny vlhkou houbou s čistícím prostředkem.'),
('Vyčistit závěsy a žaluzie', 'Vyprat/vyčistit všechny závěsy a žaluzie v bytě', 'household', 'cleaning', 'extreme', 4, 'none', 180, 'Sejmout, vyprat/vyčistit, vyvěsit/namontovat zpět.'),
('Vyčistit lustry a svítidla', 'Vyčistit všechny lustry a svítidla v bytě', 'household', 'cleaning', 'extreme', 4, 'none', 90, 'Sejmout skleněné díly, umýt, utřít do lesku, namontovat.'),
('Generální úklid balkonu/terasy', 'Kompletní vyčištění balkonu nebo terasy', 'household', 'cleaning', 'extreme', 4, 'none', 120, 'Vynést věci, zamést, vytřít, vyčistit zábradlí, okna, květináče.'),

-- HOUSEHOLD - COOKING (20 tasks)
-- Trivial cooking
('Připravit snídani', 'Připravit jednoduchou snídani podle instrukcí', 'household', 'cooking', 'trivial', 1, 'none', 15, 'Podle preferencí - káva/čaj, toast, ovoce. Vše pěkně servírovat.'),
('Uvařit kávu/čaj', 'Připravit ranní kávu nebo čaj podle preferencí', 'household', 'cooking', 'trivial', 1, 'none', 10, 'Uvařit podle preferencí, servírovat v oblíbeném hrnku.'),
('Připravit svačinu', 'Připravit svačinu - ovoce, jogurt, sušenky', 'household', 'cooking', 'trivial', 1, 'none', 10, 'Nakrájet ovoce, připravit jogurt, pěkně naservírovat.'),
('Ohřát jídlo', 'Ohřát připravené jídlo v mikrovlnce', 'household', 'cooking', 'trivial', 1, 'none', 10, 'Ohřát jídlo, naservírovat na talíř.'),
-- Easy cooking
('Připravit lehký oběd', 'Uvařit jednoduché jídlo - např. těstoviny, polévku', 'household', 'cooking', 'easy', 1, 'none', 30, 'Podle receptu nebo instrukcí, dodržet bezpečnost v kuchyni.'),
('Uvařit polévku', 'Uvařit polévku podle receptu', 'household', 'cooking', 'easy', 1, 'none', 45, 'Nakrájet zeleninu, uvařit vývar, dokončit podle receptu.'),
('Připravit salát', 'Připravit čerstvý zeleninový salát', 'household', 'cooking', 'easy', 1, 'none', 20, 'Umýt, nakrájet zeleninu, připravit zálivku, namíchat.'),
('Uvařit těstoviny s omáčkou', 'Uvařit těstoviny a připravit jednoduchou omáčku', 'household', 'cooking', 'easy', 1, 'none', 30, 'Uvařit těstoviny al dente, připravit omáčku, servírovat.'),
-- Medium cooking
('Připravit tříchodové menu', 'Uvařit předkrm, hlavní chod a dezert', 'household', 'cooking', 'medium', 2, 'none', 90, 'Naplánovat časování, připravit všechny chody podle receptů.'),
('Upéct dort nebo buchtu', 'Upéct dort nebo buchtu podle receptu', 'household', 'cooking', 'medium', 2, 'none', 90, 'Připravit těsto, upéct, nechat vychladnout, ozdobit.'),
('Připravit slavnostní večeři', 'Uvařit speciální večeři pro dva', 'household', 'cooking', 'medium', 2, 'none', 120, 'Naplánovat menu, připravit kvalitní jídlo, pěkně servírovat.'),
('Zavařit nebo naložit zeleninu', 'Zavařit nebo naložit zeleninu do sklenic', 'household', 'cooking', 'medium', 2, 'none', 120, 'Sterilizovat sklenice, připravit láku, zavařit/naložit.'),
-- Hard cooking
('Uvařit nedělní oběd', 'Připravit tradiční nedělní oběd - polévka, hlavní chod, dezert', 'household', 'cooking', 'hard', 3, 'none', 180, 'Naplánovat časování všechchodů, uvařit kompletní menu.'),
('Upéct chléb nebo housky', 'Upéct domácí chléb nebo housky', 'household', 'cooking', 'hard', 3, 'none', 180, 'Připravit těsto, nechat vykynout, vytvarovat, upéct.'),
('Připravit sushi', 'Připravit domácí sushi podle receptu', 'household', 'cooking', 'hard', 3, 'none', 120, 'Uvařit rýži, připravit náplně, zabalit, nakrájet.'),
-- Extreme cooking
('Uspořádat celý večírek s jídlem', 'Připravit jídlo pro večírek pro více osob', 'household', 'cooking', 'extreme', 4, 'none', 300, 'Naplánovat menu, nakoupit, připravit různé pokrmy, naservírovat.'),
('Uvařit složité zahraniční jídlo', 'Uvařit složité jídlo z jiné kultury', 'household', 'cooking', 'extreme', 4, 'none', 180, 'Nastudovat recept, sehnat ingredience, připravit podle pravidel.'),
('Připravit vánoční večeři', 'Uvařit tradiční vánoční večeři', 'household', 'cooking', 'extreme', 4, 'none', 240, 'Připravit všechny tradiční pokrmy, koordinovat časování.'),
('Upéct svatební dort', 'Upéct a ozdobit vícepatrový dort', 'household', 'cooking', 'extreme', 5, 'none', 360, 'Připravit těsta, upéct patra, připravit krémy, složit, ozdobit.'),
('Naučit se nový styl vaření', 'Zvládnout základy nového stylu kuchyně (čínská, indická...)', 'household', 'cooking', 'extreme', 5, 'none', 480, 'Studovat techniky, sehnat suroviny, vyzkoušet 5 různých receptů.'),

-- HOUSEHOLD - LAUNDRY (15 tasks)
-- Trivial laundry
('Vyprat jedno prádlo', 'Vyprat jednu várku prádla v pračce', 'household', 'laundry', 'trivial', 1, 'none', 15, 'Vytřídit prádlo, nastavit program, nasypat prášek, spustit.'),
('Pověsit prádlo', 'Pověsit vypraných prádlo na šňůru', 'household', 'laundry', 'trivial', 1, 'none', 15, 'Vytřepat prádlo, pověsit na šňůru nebo sušák.'),
('Složit suché prádlo', 'Složit suché prádlo a uložit do skříně', 'household', 'laundry', 'trivial', 1, 'none', 20, 'Složit prádlo podle druhů, uložit do skříně.'),
-- Easy laundry
('Vyprat a usušit prádlo', 'Kompletní proces - vyprat, pověsit, složit', 'household', 'laundry', 'easy', 1, 'none', 30, 'Vyprat, pověsit, po uschnutí složit a uložit.'),
('Vyžehlit košile', 'Vyžehlit 5 košil podle pravidel', 'household', 'laundry', 'easy', 1, 'none', 45, 'Rozehřát žehličku, žehlit košile důkladně podle pravidel.'),
('Vyžehlit ložní prádlo', 'Vyžehlit povlečení a prostěradla', 'household', 'laundry', 'easy', 1, 'none', 30, 'Žehlit ložní prádlo, pěkně složit.'),
-- Medium laundry
('Vyprat záclony', 'Vyprat a pověsit záclony', 'household', 'laundry', 'medium', 2, 'none', 60, 'Sejmout záclony, vyprat šetrně, pověsit/vyžehlit, zavěsit zpět.'),
('Kompletní péče o prádlo', 'Vytřídit, vyprat, usušit a složit všechno prádlo', 'household', 'laundry', 'medium', 2, 'none', 90, 'Kompletní péče o veškeré nahromadněné prádlo.'),
('Vyžehlit celé prádlo', 'Vyžehlit všechno prádlo co potřebuje žehlení', 'household', 'laundry', 'medium', 2, 'none', 60, 'Vyžehlit košile, halenky, kalhoty, ložní prádlo.'),
-- Hard laundry
('Vyprat ručně jemné prádlo', 'Vyprat ručně jemné/spodní prádlo', 'household', 'laundry', 'hard', 3, 'none', 45, 'Připravit vlažnou vodu, vyprat ručně jemný prášek, vyždímat, usušit.'),
('Vyčistit obuv', 'Vyčistit a vyleštit všechnu obuv', 'household', 'laundry', 'hard', 3, 'none', 60, 'Vyčistit každý pár bot, naleštit, ošetřit.'),
('Čištění koberců', 'Vyčistit koberec/koberce v bytě', 'household', 'laundry', 'hard', 3, 'none', 90, 'Vysát koberce, ošetřit čistícím prostředkem, vykartáčovat.'),
-- Extreme laundry
('Vyprat a vyžehlit vše', 'Kompletní péče o všechno prádlo v domácnosti', 'household', 'laundry', 'extreme', 4, 'none', 180, 'Vytřídit, vyprat, usušit, vyžehlit, složit a uložit veškeré prádlo.'),
('Vyčistit zimní bundy', 'Vyčistit zimní oblečení před uskladněním', 'household', 'laundry', 'extreme', 4, 'none', 120, 'Vyčistit/vyprat zimní oblečení, usušit, složit do krabic.'),
('Generální péče o šatník', 'Zkontrolovat, vytřídit, vyprat a uklidit celý šatník', 'household', 'laundry', 'extreme', 4, 'none', 240, 'Vybrat skříň, vytřídit, vyprat co potřebuje, žehlit, uklidit zpět.'),

-- HOUSEHOLD - ORGANIZATION (15 tasks)
-- Trivial organization
('Uklidit pracovní stůl', 'Uklidit a uspořádat pracovní stůl', 'household', 'organization', 'trivial', 1, 'none', 15, 'Uklidit nepotřebné věci, uspořádat potřebné.'),
('Vytřídit poštu a dokumenty', 'Projít poštu, vytřídit důležité, vyhodit spam', 'household', 'organization', 'trivial', 1, 'none', 15, 'Otevřít poštu, vytřídit důležité, vyhodit nepotřebné.'),
('Uklidit botník', 'Uspořádat boty v botníku', 'household', 'organization', 'trivial', 1, 'none', 15, 'Uklidit boty na místo, uspořádat podle druhů.'),
-- Easy organization
('Uspořádat jednu skříň', 'Vybrat, vytřídit a uspořádat jednu skříň', 'household', 'organization', 'easy', 1, 'none', 45, 'Vybrat skříň, vytřídit věci, uklidit zpět uspořádaně.'),
('Uspořádat kosmetiku/drogerii', 'Uspořádat kosmetiku a drogerii v koupelně', 'household', 'organization', 'easy', 1, 'none', 30, 'Vytřídit prošlé věci, uspořádat podle kategorií.'),
('Uspořádat knihovnu', 'Uspořádat knihy v knihovně', 'household', 'organization', 'easy', 1, 'none', 30, 'Utřít prach, uspořádat knihy podle kategorií nebo abecedy.'),
-- Medium organization
('Vytřídit šatník', 'Projít šatník a vytřídit oblečení co už nenosíš', 'household', 'organization', 'medium', 2, 'none', 90, 'Vytřídit věci na darování, vyhození, opravy. Uklidit zpět.'),
('Uspořádat spižírnu', 'Uspořádat potraviny ve spížce/skříni', 'household', 'organization', 'medium', 2, 'none', 45, 'Vytáhnout vše, zkontrolovat trvanlivost, uspořádat logicky.'),
('Digitální archiv dokumentů', 'Uspořádat a zálohovat digitální dokumenty', 'household', 'organization', 'medium', 2, 'none', 60, 'Projít soubory, uspořádat do složek, zálohovat důležité.'),
-- Hard organization
('Generální úklid skříní', 'Vybrat, vytřídit a uklidit všechny skříně v bytě', 'household', 'organization', 'hard', 3, 'none', 180, 'Postupně každou skříň vybrat, vytřídit, vyčistit, uklidit zpět.'),
('Uspořádat sklep/půdu', 'Uklidit a uspořádat sklep nebo půdní prostor', 'household', 'organization', 'hard', 3, 'none', 180, 'Vybrat vše, vytřídit, vyhodit/darovat nepotřebné, uspořádat.'),
('Digitalizovat staré fotky', 'Naskenovat/vyfotit staré fotografie', 'household', 'organization', 'hard', 3, 'none', 120, 'Připravit fotky, naskenovat/vyfotit, uspořádat do digitálních alb.'),
-- Extreme organization
('Minimalistický úklid bytu', 'Projít celý byt a zbavit se nepotřebných věcí', 'household', 'organization', 'extreme', 4, 'none', 360, 'Systematicky projít každou místnost, vytřídit podle metody.'),
('Reorganizace celého bytu', 'Přeuspořádat věci v bytě pro lepší funkčnost', 'household', 'organization', 'extreme', 4, 'none', 480, 'Naplánovat nové uspořádání, přemístit věci, uspořádat.'),
('Kompletní archivace dokumentů', 'Uspořádat všechny dokumenty fyzicky i digitálně', 'household', 'organization', 'extreme', 5, 'none', 240, 'Projít všechny dokumenty, naskenovat důležité, uspořádat systém.'),

-- HOUSEHOLD - MAINTENANCE (5 tasks)
('Vyměnit žárovku', 'Vyměnit spálenou žárovku ve svítidle', 'household', 'maintenance', 'trivial', 1, 'none', 10, 'Vypnout jistič, vyšroubovat starou žárovku, našroubovat novou.'),
('Vyčistit filtr vysavače', 'Vyjmout a vyčistit filtr vysavače', 'household', 'maintenance', 'trivial', 1, 'none', 15, 'Vyjmout filtr, vyčistit/vyprat, nechat uschnout, vrátit zpět.'),
('Seřídit kohoutky', 'Utáhnout uvolněné kohoutky nebo vyměnit těsnění', 'household', 'maintenance', 'easy', 2, 'none', 30, 'Zkontrolovat těsnění, vyměnit pokud potřeba, utáhnout.'),
('Čištění odpadu', 'Vyčistit sifon a odpadní trubky', 'household', 'maintenance', 'medium', 2, 'none', 45, 'Vyčistit sifon u dřezu, vyčistit odpad octem a jedlou sodou.'),
('Seřízení oken a dveří', 'Seřídit panty a zamykání oken a dveří', 'household', 'maintenance', 'hard', 3, 'none', 60, 'Zkontrolovat panty, seřídit, namazat, zkontrolovat těsnění.'),

-- HOUSEHOLD - SHOPPING (5 tasks)
('Nakoupit potraviny', 'Nakoupit potraviny podle seznamu', 'household', 'shopping', 'trivial', 1, 'none', 60, 'Připravit seznam, nakoupit v obchodě, donést domů, uklidit.'),
('Nakoupit drogerii', 'Nakoupit drogistické zboží podle seznamu', 'household', 'shopping', 'trivial', 1, 'none', 30, 'Zkontrolovat co chybí, nakoupit, uklidit na místo.'),
('Týdenní nákup', 'Nakoupit potraviny na celý týden podle plánu', 'household', 'shopping', 'easy', 1, 'none', 90, 'Naplánovat jídla na týden, připravit seznam, nakoupit.'),
('Nákup oblečení', 'Nakoupit oblečení podle zadání', 'household', 'shopping', 'medium', 2, 'none', 120, 'Zajít do obchodů, vybrat podle požadavků, vyzkoušet, koupit.'),
('Organizovat větší nákup', 'Nakoupit a dovézt větší množství věcí (např. Ikea)', 'household', 'shopping', 'hard', 3, 'none', 240, 'Naplánovat nákup, zapůjčit vůz pokud potřeba, nakoupit, dovézt, složit.');
