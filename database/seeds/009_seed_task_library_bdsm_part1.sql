-- =====================================================
-- TASK LIBRARY - BDSM PART 1 (60 tasks)
-- =====================================================
-- Bondage, Impact Play, Service tasks
-- Total BDSM target: 240 tasks

USE klaudie;

-- BDSM - BONDAGE (25 tasks)
INSERT INTO task_library (title, description, category, subcategory, difficulty, level_required, bdsm_intensity, duration_minutes, preferences_required, instructions) VALUES
-- Soft bondage
('Bondage ruce 10 minut', 'Nechat se svázat za zápěstí na 10 minut', 'bdsm', 'bondage', 'trivial', 1, 'soft', 10, '["bondage"]', 'Nabídnout zápěstí ke svázání, zůstat v klidu, dodržet bezpečnostní signál.'),
('Bondage ruce za zády 15 minut', 'Svázané ruce za zády po dobu 15 minut', 'bdsm', 'bondage', 'easy', 1, 'soft', 15, '["bondage"]', 'Ruce svázané za zády, udržet pozici, nepokoušet se uvolnit.'),
('Bondage kotníky 15 minut', 'Nechat si svázat kotníky na 15 minut', 'bdsm', 'bondage', 'easy', 1, 'soft', 15, '["bondage"]', 'Svázané kotníky, ležet nebo sedět v klidu.'),
('Bondage u židle 20 minut', 'Být přivázaný k židli 20 minut', 'bdsm', 'bondage', 'easy', 1, 'soft', 20, '["bondage"]', 'Sedět na židli, nechat se přivázat, zůstat v klidu.'),
('Bondage tape ruce 20 minut', 'Ruce ovázané páskou po dobu 20 minut', 'bdsm', 'bondage', 'easy', 2, 'soft', 20, '["bondage"]', 'Použít bondage tape, svázat zápěstí, udržet pozici.'),
('Spreader bar 15 minut', 'Použití spreader bar na kotníky 15 minut', 'bdsm', 'bondage', 'easy', 2, 'medium', 15, '["bondage"]', 'Spreader bar mezi kotníky, udržet pozici ležící nebo stojící.'),
('Bondage box tie 20 minut', 'Box tie lano bondage 20 minut', 'bdsm', 'bondage', 'medium', 2, 'medium', 20, '["bondage"]', 'Klasický box tie, ruce za zády, kontrolovat cirkulaci.'),
-- Medium bondage
('Hogtie pozice 15 minut', 'Hogtie bondage pozice 15 minut', 'bdsm', 'bondage', 'medium', 2, 'medium', 15, '["bondage"]', 'Svázaný v hogtie pozici (ruce a nohy za zády), ležet na břiše.'),
('Bondage ke sloupku 30 minut', 'Přivázaný k pevnému bodu 30 minut', 'bdsm', 'bondage', 'medium', 2, 'medium', 30, '["bondage"]', 'Přivázaný ke sloupku/rámu, stát nebo klečet nehybně.'),
('Shibari základní vzor', 'Nechat provést základní shibari tie', 'bdsm', 'bondage', 'medium', 2, 'medium', 45, '["bondage"]', 'Shibari lano vzor na hrudníku, udržet pozici během vázání.'),
('Rope harness 30 minut', 'Nosit rope harness po dobu 30 minut', 'bdsm', 'bondage', 'medium', 2, 'medium', 30, '["bondage"]', 'Lanový harness na těle, nosit a vykonávat jednoduché úkoly.'),
('Bondage s pokrčenými koleny', 'Svázaný s pokrčenými koleny 20 minut', 'bdsm', 'bondage', 'medium', 3, 'medium', 20, '["bondage"]', 'Kolena svázaná k hrudníku, ruce za zády, ležet na boku.'),
('Bondage suspension prep', 'Přípravný bondage pro suspension', 'bdsm', 'bondage', 'medium', 3, 'medium', 30, '["bondage"]', 'Aplikovat harness vhodný pro částečné zavěšení.'),
('Self-bondage cvičení', 'Procvičit techniky self-bondage', 'bdsm', 'bondage', 'medium', 2, 'medium', 30, '["bondage"]', 'Cvičit bezpečný self-bondage s možností rychlého uvolnění.'),
-- Intense bondage
('Full body bondage 45 minut', 'Kompletní tělo svázané 45 minut', 'bdsm', 'bondage', 'hard', 3, 'intense', 45, '["bondage"]', 'Celé tělo svázané lany nebo pásy, nehybně ležet.'),
('Bondage mummifikace částečná', 'Částečná mummifikace fólií 30 minut', 'bdsm', 'bondage', 'hard', 3, 'intense', 30, '["bondage"]', 'Zabalení části těla do fólie, kontrolovat dýchání.'),
('Straitjacket 45 minut', 'Svěrací kazajka 45 minut', 'bdsm', 'bondage', 'hard', 3, 'intense', 45, '["bondage"]', 'V svěrací kazajce, udržet klid, dýchat pomalu.'),
('Shibari komplex vzor', 'Komplexní shibari vázání celého těla', 'bdsm', 'bondage', 'hard', 3, 'intense', 60, '["bondage"]', 'Pokročilý shibari vzor, vydržet během dlouhého vázání.'),
('Bondage spreadeagle 60 minut', 'Spreadeagle bondage 60 minut', 'bdsm', 'bondage', 'hard', 4, 'intense', 60, '["bondage"]', 'Svázaný roztažený (X pozice) k rámu postele, nehybně.'),
('Predicament bondage', 'Predicament bondage situace', 'bdsm', 'bondage', 'hard', 4, 'intense', 30, '["bondage"]', 'Bondage kde každá pozice je nepohodlná - zvolit menší zlo.'),
-- Extreme bondage
('Partial suspension 20 minut', 'Částečné zavěšení na lanech 20 minut', 'bdsm', 'bondage', 'extreme', 4, 'intense', 20, '["bondage"]', 'Částečné zavěšení (nohy na zemi), kontrolovat bezpečnost.'),
('Bondage vakuový pytel 20 minut', 'Vakuový pytel bondage 20 minut', 'bdsm', 'bondage', 'extreme', 4, 'intense', 20, '["bondage"]', 'V vakuovém pytli, kontrolovat dýchání neustále.'),
('Full suspension krátká', 'Kompletní suspension krátce', 'bdsm', 'bondage', 'extreme', 5, 'intense', 10, '["bondage"]', 'Plné zavěšení na lanech, maximálně 10 minut, neustálý dohled.'),
('Mummifikace kompletní 30 minut', 'Kompletní mummifikace těla 30 minut', 'bdsm', 'bondage', 'extreme', 5, 'intense', 30, '["bondage"]', 'Celé tělo zabalené, pouze dýchací otvor, neustálý dohled.'),
('Bondage stress pozice 45 minut', 'Stresová bondage pozice 45 minut', 'bdsm', 'bondage', 'extreme', 5, 'intense', 45, '["bondage"]', 'Fyzicky náročná vázaná pozice, vyžaduje vytrvalost.'),

-- BDSM - IMPACT PLAY (20 tasks)
-- Soft impact
('5 ran rukou přes oblečení', '5 lehkých ran rukou přes oblečení', 'bdsm', 'impact', 'trivial', 1, 'soft', 5, '["impact_play"]', 'Přes oblečení, střední intenzita, počítat nahlas.'),
('10 ran pádlem lehké', '10 lehkých ran pádlem', 'bdsm', 'impact', 'easy', 1, 'soft', 10, '["impact_play"]', 'Lehké dřevěné pádlo, přes spodní prádlo, počítat a děkovat.'),
('15 ran rukou na holé', '15 ran rukou na holou kůži', 'bdsm', 'impact', 'easy', 1, 'soft', 10, '["impact_play"]', 'Na holé hýždě, střední síla, počítat a děkovat.'),
('10 ran prstýnkem', '10 ran pravítkem na dlaně', 'bdsm', 'impact', 'easy', 1, 'soft', 10, '["impact_play"]', 'Pravítko na dlaně, lehčí intenzita, počítat.'),
('20 ran floggerem lehkým', '20 ran lehkým floggerem', 'bdsm', 'impact', 'easy', 2, 'soft', 15, '["impact_play"]', 'Měkký flogger, záda nebo hýždě, rytmicky.'),
-- Medium impact
('25 ran pádlem střední', '25 ran pádlem střední intenzity', 'bdsm', 'impact', 'medium', 2, 'medium', 15, '["impact_play"]', 'Dřevěné pádlo, střední síla, počítat a děkovat po každé.'),
('30 ran floggerem těžším', '30 ran těžším floggerem', 'bdsm', 'impact', 'medium', 2, 'medium', 20, '["impact_play"]', 'Těžší flogger, záda, rytmicky, vydržet bez safeword.'),
('20 ran holí lehkou', '20 ran lehkou holí/třtinou', 'bdsm', 'impact', 'medium', 2, 'medium', 15, '["impact_play"]', 'Lehká trh

tina, hýždě nebo stehna, počítat.'),
('15 ran cropem', '15 ran riding crop', 'bdsm', 'impact', 'medium', 2, 'medium', 10, '["impact_play"]', 'Riding crop, hýždě nebo stehna, ostrá bodová bolest.'),
('50 ran rukou intenzivní', '50 ran rukou s plnou silou', 'bdsm', 'impact', 'medium', 3, 'medium', 20, '["impact_play"]', 'Plná síla rukou, počítat každou, děkovat.'),
('Flogging session 15 minut', 'Flogging session 15 minut continuous', 'bdsm', 'impact', 'medium', 3, 'medium', 15, '["impact_play"]', 'Nepřetržitý flogging, různé intenzity, vydržet.'),
-- Intense impact
('40 ran pádlem těžké', '40 ran těžkým pádlem', 'bdsm', 'impact', 'hard', 3, 'intense', 25, '["impact_play"]', 'Těžké dřevěné nebo kožené pádlo, plná síla.'),
('30 ran holí střední', '30 ran holí střední tloušťky', 'bdsm', 'impact', 'hard', 3, 'intense', 20, '["impact_play"]', 'Trhtina nebo ratan, silné údery, zanechá stopy.'),
('25 ran bičíkem jednooč', '25 ran jednoduchým bičíkem', 'bdsm', 'impact', 'hard', 3, 'intense', 20, '["impact_play"]', 'Jednooč bič, záda nebo hýždě, ostrá bolest.'),
('Impact combination 30 minut', 'Kombinace různých impact nástrojů 30 minut', 'bdsm', 'impact', 'hard', 4, 'intense', 30, '["impact_play"]', 'Ruka, pádlo, flogger, cane - postupné zvyšování.'),
('50 ran holí tenkou', '50 ran tenkou holí', 'bdsm', 'impact', 'hard', 4, 'intense', 30, '["impact_play"]', 'Tenká trhtina, velmi ostré údery, počítat vše.'),
('Bastinado 20 ran', '20 ran na chodidla', 'bdsm', 'impact', 'hard', 4, 'intense', 15, '["impact_play"]', 'Údery na chodidla, vysoce bolestivé, počítat.'),
-- Extreme impact
('100 ran kombinace', '100 ran různými nástroji', 'bdsm', 'impact', 'extreme', 4, 'intense', 45, '["impact_play"]', 'Postupně 100 ran, různé nástroje, počítat všechny.'),
('Impact marathon 60 minut', 'Impact session 60 minut', 'bdsm', 'impact', 'extreme', 5, 'intense', 60, '["impact_play"]', 'Dlouhá impact session, různé intenzity a nástroje.'),
('Caning punishment 50 ran', '50 ran trestací holí', 'bdsm', 'impact', 'extreme', 5, 'intense', 40, '["impact_play"]', 'Těžká trhtina, 50 ran, plná síla, zanechá výrazné stopy.'),

-- BDSM - SERVICE & WORSHIP (15 tasks)
-- Soft service
('Foot worship 15 minut', 'Uctívání nohou 15 minut', 'bdsm', 'service', 'easy', 1, 'soft', 15, '["foot_worship"]', 'Mazlit se s nohama, líbat, masírovat s úctou.'),
('Shoe cleaning rituál', 'Rituální čištění bot jazýkem', 'bdsm', 'service', 'easy', 1, 'soft', 20, '["foot_worship", "humiliation"]', 'Vyčistit boty Dominy jazýkem, ukázat oddanost.'),
('Hand worship', 'Uctívání rukou 10 minut', 'bdsm', 'service', 'trivial', 1, 'soft', 10, '["service"]', 'Líbat ruce Dominy s úctou, mazlit se.'),
('Body worship clothed', 'Uctívání těla přes oblečení 20 minut', 'bdsm', 'service', 'easy', 2, 'soft', 20, '["service"]', 'Uctívat tělo Dominy přes oblečení, líbat, mazlit se.'),
('Foot massage služba', 'Profesionální masáž chodidel 30 minut', 'bdsm', 'service', 'easy', 1, 'soft', 30, '["foot_worship"]', 'Důkladná masáž chodidel s olejem, soustředěná služba.'),
-- Medium service
('Tělo worship 30 minut', 'Kompletní uctívání těla 30 minut', 'bdsm', 'service', 'medium', 2, 'medium', 30, '["service"]', 'Uctívat celé tělo Dominy, líbat, mazlit se.'),
('Oral service Domině', 'Poskytnout orální službu Domině', 'bdsm', 'service', 'medium', 2, 'medium', 30, '["oral_service"]', 'Orální potěšení podle instrukcí Dominy.'),
('Leg worship intenzivní', 'Intenzivní uctívání nohou 45 minut', 'bdsm', 'service', 'medium', 2, 'medium', 45, '["foot_worship"]', 'Detailní uctívání každého palce nohou a noh.'),
('Service jako nábytek', 'Sloužit jako lidský nábytek 45 minut', 'bdsm', 'service', 'medium', 2, 'medium', 45, '["service", "objectification"]', 'Být nehybným nábytkem pro Dominu.'),
-- Intense service
('Toilet service viewing', 'Být přítomen během používání toalety', 'bdsm', 'service', 'hard', 3, 'intense', 15, '["toilet_play"]', 'Být přítomen a pomáhat podle potřeby.'),
('Full body worship 60 minut', 'Kompletní uctívání celého těla 60 minut', 'bdsm', 'service', 'hard', 3, 'intense', 60, '["service"]', 'Detailní uctívání každé části těla.'),
('Forced orgasm service', 'Přinést Domině vícenásobné orgasmy', 'bdsm', 'service', 'hard', 3, 'intense', 60, '["oral_service"]', 'Nepřetržitá stimulace dokud Domina neřekne stop.'),
-- Extreme service
('Extended oral service', 'Orální služba 90 minut', 'bdsm', 'service', 'extreme', 4, 'intense', 90, '["oral_service"]', 'Dlouhá orální session podle instrukcí.'),
('Golden shower recipient', 'Přijmout golden shower', 'bdsm', 'service', 'extreme', 4, 'intense', 20, '["watersports"]', 'Přijmout a děkovat za zlatý déšť.'),
('Toilet slave service', 'Sloužit jako toilet slave', 'bdsm', 'service', 'extreme', 5, 'intense', 30, '["toilet_play"]', 'Pokročilá toilet worship služba.');
