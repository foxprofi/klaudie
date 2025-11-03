/**
 * @Author: Klaudie <klaudie@foxprofi.cz>
 *
 * Seed: Punishment Library (#052)
 * 100 trestů pro automatický systém - 5 kategorií, různé intensity
 */

-- ============================================================================
-- PHYSICAL DISCIPLINE (20 trestů) - is_physical_discipline = TRUE
-- ============================================================================

-- Light Intensity (7 trestů)
INSERT INTO punishment_library (title, description, category, subcategory, intensity, duration_minutes, preferences_required, is_physical_discipline, is_universal, instructions, safety_notes, severity_multiplier) VALUES
('10 ran dřevěným pádlem', 'Výchovný trest za selhání - 10 ran pádlem', 'physical', 'impact', 'light', 10, '["impact_play"]', TRUE, FALSE, 'Servant přes kolena (OTK pozice), 10 ran postupně, rovnoměrně na obě půlky zadku. Počítat nahlas.', 'Kontrolovat zabarvení kůže, pauza pokud modřiny. Warm-up nejprve lehčími plácnutími.', 1.0),
('15 plácnutí rukou', 'Spanking otevřenou dlaní', 'physical', 'spanking', 'light', 5, '["spanking"]', TRUE, FALSE, 'OTK pozice, 15 plácnutí otevřenou dlaní střídavě na obě půlky.', 'Warm-up nejprve lehčími plácnutími.', 1.0),
('20 ran páskem', 'Kožený pásek přes zadek', 'physical', 'impact', 'light', 8, '["impact_play"]', TRUE, FALSE, 'Servant v předklonu přes nábytek, 20 ran koženým páskem.', 'Kontrolovat sílu ran, vyhnout se oblasti ledvin.', 1.0),
('12 ran třtinou', 'Lehká třtina, střední intenzita', 'physical', 'caning', 'light', 10, '["caning", "impact_play"]', TRUE, FALSE, 'Servant v předklonu nebo přes kolena, 12 ran třtinou na zadek.', 'Třtina může zanechat modřiny, kontrolovat sílu. Nedávat rány na stejné místo.', 1.0),
('Koutování 15 minut', 'Stát v rohu s rukama na hlavě', 'physical', 'position', 'light', 15, '["position_training"]', TRUE, FALSE, 'Stát v rohu místnosti, ruce na hlavě, nohy u sebe, nos u zdi. Žádný pohyb.', 'Kontrolovat po 5 minutách, povolit krátkou pauzu pokud nutné.', 1.0),
('30 minut kleče na rýži', 'Klečení na zrní rýže', 'physical', 'endurance', 'light', 30, '["endurance", "pain_play"]', TRUE, FALSE, 'Na kolenou na zrní rýže, ruce na hlavě nebo vzadu. Žádný pohyb.', 'Kontrolovat kůži, povolit přestávku pokud krvácení. Max 30 min.', 1.0),
('20 dřepů s trestem', 'Dřepy s mantrou', 'physical', 'fitness', 'light', 10, '["physical_discipline"]', TRUE, FALSE, 'Při každém dřepu říct "Selhala jsem a zasloužím si trest". 20 dřepů celkem.', 'Správná forma dřepů, jinak riziko zranění kolen.', 1.0);

-- Medium Intensity (7 trestů)
INSERT INTO punishment_library (title, description, category, subcategory, intensity, duration_minutes, preferences_required, is_physical_discipline, is_universal, instructions, safety_notes, severity_multiplier) VALUES
('25 ran jezdeckým bičem', 'Riding crop na záda a zadek', 'physical', 'impact', 'medium', 15, '["impact_play", "whipping"]', TRUE, FALSE, 'Servant v předklonu, 25 ran riding crop střídavě na záda a zadek.', 'Vyhnout se oblasti ledvin a páteře. Kontrolovat sílu ran.', 1.0),
('30 ran floggerem', 'Kožený flogger na záda', 'physical', 'flogging', 'medium', 20, '["flogging", "impact_play"]', TRUE, FALSE, 'Servant v předklonu nebo u zdi, 30 ran koženým floggerem na záda.', 'Warm-up nejprve lehčími ranami. Vyhnout se hlavě, krku, ledvinám.', 1.0),
('50 ran pádlem', 'Dřevěné pádlo, celý zadek', 'physical', 'impact', 'medium', 20, '["impact_play", "paddling"]', TRUE, FALSE, 'Servant přes kolena, 50 ran dřevěným pádlem na celý zadek. Počítat nahlas.', 'Kontrolovat zabarvení, pauza pokud modřiny. Mohou přetrvávat několik dní.', 1.0),
('20 ran třtinou', 'Středně tvrdá třtina', 'physical', 'caning', 'medium', 15, '["caning", "impact_play"]', TRUE, FALSE, 'Servant v předklonu, 20 ran třtinou střední síly na zadek.', 'Třtina zanechá modřiny. Nedávat rány na stejné místo. Aftercare.', 1.0),
('1 hodina koutování s knihami', 'Držet knihy nad hlavou v rohu', 'physical', 'endurance', 'medium', 60, '["endurance", "position_training"]', TRUE, FALSE, 'Stát v rohu, držet knihy nebo závaží nad hlavou. Každé upuštění = +10 minut.', 'Kontrolovat únavu svalů, povolit krátkou pauzu každých 15 minut.', 1.0),
('100 dřepů s disciplínou', 'Při každém dřepu mantra', 'physical', 'fitness', 'medium', 30, '["physical_discipline"]', TRUE, FALSE, 'Při každém dřepu říct "Budu poslušnější". 100 dřepů celkem, může být rozděleno.', 'Správná forma, kontrolovat kolena.', 1.0),
('Kleče na hrachu 30 min', 'Klečení na hrášku', 'physical', 'endurance', 'medium', 30, '["endurance", "pain_play"]', TRUE, FALSE, 'Na kolenou na suchém hrášku, ruce na hlavě. Žádný pohyb.', 'Kontrolovat kůži, povolit přestávku pokud krvácení. Max 30 min.', 1.0);

-- Severe Intensity (6 trestů)
INSERT INTO punishment_library (title, description, category, subcategory, intensity, duration_minutes, preferences_required, is_physical_discipline, is_universal, instructions, safety_notes, severity_multiplier) VALUES
('50 ran třtinou', 'Tvrdá třtina, celé tělo', 'physical', 'caning', 'severe', 30, '["caning", "impact_play", "severe_pain"]', TRUE, FALSE, 'Servant v předklonu, 50 ran třtinou na zadek, stehna, lýtka. Počítat nahlas.', 'Zanechá modřiny na několik dní. Aftercare důležité. Kontrolovat hard limits.', 1.0),
('100 ran floggerem', 'Záda, hýždě, stehna', 'physical', 'flogging', 'severe', 40, '["flogging", "impact_play", "severe_pain"]', TRUE, FALSE, 'Servant u zdi nebo v předklonu, 100 ran floggerem postupně na celé tělo.', 'Warm-up důležitý. Vyhnout se hlavě, krku, ledvinám, páteři. Aftercare.', 1.0),
('40 ran jednohvězdým bičem', 'Single tail whip na záda', 'physical', 'whipping', 'severe', 30, '["whipping", "severe_pain"]', TRUE, FALSE, 'Servant u zdi, 40 ran single tail whip na záda a zadek.', 'Pouze zkušená domina! Riziko říznutí kůže. Aftercare, dezinfekce.', 1.0),
('75 ran pádlem', 'Tvrdé dřevo, opakované série', 'physical', 'impact', 'severe', 35, '["impact_play", "paddling", "severe_pain"]', TRUE, FALSE, 'Servant přes kolena, 75 ran tvrdým dřevěným pádlem v sériích po 25.', 'Zanechá modřiny na týden. Kontrolovat sílu, aftercare.', 1.0),
('2 hodiny koutování s váhami', 'Knihy nebo závaží nad hlavou', 'physical', 'endurance', 'severe', 120, '["endurance", "severe_discipline"]', TRUE, FALSE, 'Stát v rohu 2 hodiny s knihami/závaží nad hlavou. Upuštění = restart.', 'Kontrolovat únavu, povolit krátkou pauzu každých 20 minut. Hydratace.', 1.0),
('200 dřepů s motivací', 'Při každém dřepu mantra', 'physical', 'fitness', 'severe', 60, '["physical_discipline", "endurance"]', TRUE, FALSE, '"Poslušnost je má povinnost" při každém dřepu. 200 celkem.', 'Správná forma, kontrolovat kolena. Může být rozděleno do série.', 1.0);

-- ============================================================================
-- MENTAL PUNISHMENTS (20 trestů) - Psychologická disciplína
-- ============================================================================

-- Light (7 trestů)
INSERT INTO punishment_library (title, description, category, subcategory, intensity, duration_minutes, preferences_required, is_physical_discipline, is_universal, instructions, safety_notes, severity_multiplier) VALUES
('Esej o selhání (500 slov)', 'Napsat 500 slov o konkrétním selhání', 'mental', 'writing', 'light', 60, '["writing_tasks"]', FALSE, FALSE, 'Napsat 500 slov o tom, co udělala špatně a co se naučí. Odevzdat domině.', NULL, 1.0),
('Opakování mantr (100x)', 'Opakovat mantru 100x', 'mental', 'mantra', 'light', 30, '["verbal_protocol"]', FALSE, FALSE, 'Opakovat 100x "Jsem zde, abych sloužila". Můžepíseně nebo nahlas.', NULL, 1.0),
('Selfie s cedulí', 'Foto s "Selhala jsem"', 'mental', 'humiliation', 'light', 10, '["humiliation", "photo_tasks"]', FALSE, FALSE, 'Vyfotit se s cedulí "Selhala jsem" a poslat domině.', 'Kontrolovat, že foto nezůstane veřejné.', 1.0),
('Denní deník pochybení (týden)', 'Zapisovat každé drobné selhání', 'mental', 'writing', 'light', 420, '["writing_tasks"]', FALSE, FALSE, 'Každý den týden zapisovat všechna drobná selhání a pochybení.', NULL, 1.0),
('Nahlas přečíst seznam selhání', 'Přečíst před dominou 5 minut', 'mental', 'verbal_humiliation', 'light', 5, '["verbal_humiliation"]', FALSE, FALSE, 'Nahlas před dominou přečíst seznam svých selhání za poslední týden.', NULL, 1.0),
('Děkovný dopis domině', 'Napsat dopis vděčnosti', 'mental', 'writing', 'light', 30, '["writing_tasks", "worship"]', FALSE, FALSE, 'Napsat dopis vděčnosti domině za to, že ji disciplinuje a vede.', NULL, 1.0),
('Meditace na selhání (30 min)', 'Tichá meditace o pochybení', 'mental', 'meditation', 'light', 30, '["meditation"]', FALSE, FALSE, 'Klečící pozice, 30 minut tichá meditace o svém selhání a poslušnosti.', 'Kontrolovat, že servant skutečně medituje, ne usíná.', 1.0);

-- Medium (7 trestů)
INSERT INTO punishment_library (title, description, category, subcategory, intensity, duration_minutes, preferences_required, is_physical_discipline, is_universal, instructions, safety_notes, severity_multiplier) VALUES
('Veřejná omluva', 'Poklona, polibek bot, omluva', 'mental', 'humiliation', 'medium', 10, '["humiliation", "foot_worship"]', FALSE, FALSE, 'Poklonit se, políbit boty dominy a nahlas se omluvit za selhání.', NULL, 1.0),
('Nosit označení "servant" (24h)', 'Náramek s nápisem servant', 'mental', 'public_humiliation', 'medium', 1440, '["public_humiliation", "marking"]', FALSE, FALSE, 'Nosit náramek nebo náhrdelník s nápisem "servant" po dobu 24 hodin.', 'Kontrolovat soft limits ohledně veřejnosti.', 1.0),
('Esej 2000 slov', '"Proč je má Domina nadřazená"', 'mental', 'writing', 'medium', 120, '["writing_tasks", "worship"]', FALSE, FALSE, 'Napsat 2000 slov esej proč je domina nadřazená a servant podřízená.', NULL, 1.0),
('Video omluva (3 min)', 'Nahrát video omluvy', 'mental', 'video', 'medium', 20, '["humiliation", "video_tasks"]', FALSE, FALSE, 'Nahrát 3minutové video s omluvou a sebekritikovou za selhání. Poslat domině.', 'Kontrolovat, že video bude privátní.', 1.0),
('Opakovat 500x', '"Má vůle neexistuje"', 'mental', 'mantra', 'medium', 120, '["mantra", "mind_control"]', FALSE, FALSE, 'Opakovat 500x mantru "Má vůle neexistuje, existuje pouze vůle mé Dominy".', NULL, 1.0),
('Klečení před fotkou dominy (hodina)', 'Klečící meditace', 'mental', 'worship', 'medium', 60, '["worship", "meditation"]', FALSE, FALSE, 'Klečet před fotkou dominy hodinu v tiché meditaci o poslušnosti.', 'Kontrolovat, že servant skutečně medituje.', 1.0),
('Seznam 100 důvodů podřízenosti', 'Napsat 100 důvodů', 'mental', 'writing', 'medium', 90, '["writing_tasks", "humiliation"]', FALSE, FALSE, 'Napsat seznam 100 důvodů proč je servant podřízená a zaslouží si trest.', NULL, 1.0);

-- Severe (6 trestů)
INSERT INTO punishment_library (title, description, category, subcategory, intensity, duration_minutes, preferences_required, is_physical_discipline, is_universal, instructions, safety_notes, severity_multiplier) VALUES
('Veřejné ponížení (domácnost)', 'Označení při návštěvě', 'mental', 'public_humiliation', 'severe', 120, '["public_humiliation", "extreme_humiliation"]', FALSE, FALSE, 'Nosit označení servanta pokud je návštěva v domácnosti.', 'Pouze s explicitním souhlasem! Kontrolovat hard limits.', 1.0),
('Confession diary (měsíc)', 'Denní zápisy selhání', 'mental', 'writing', 'severe', 1800, '["writing_tasks", "long_term_discipline"]', FALSE, FALSE, 'Každý den měsíc zapisovat všechna selhání a pochybení do deníku.', NULL, 1.0),
('Nosit obojek 7 dní', 'Viditelný symbol vlastnictví', 'mental', 'ownership', 'severe', 10080, '["collar", "ownership", "marking"]', FALSE, FALSE, 'Nosit obojek (diskrétní nebo zřetelný podle dohody) 7 dní non-stop.', 'Kontrolovat soft limits ohledně veřejnosti. Aftercare.', 1.0),
('Napsat 5000 slov', '"Má jediná hodnota je služba"', 'mental', 'writing', 'severe', 300, '["writing_tasks", "degradation"]', FALSE, FALSE, 'Napsat esej 5000 slov proč má jediná hodnota je služba domině.', NULL, 1.0),
('Nahrát 10min video', 'O selhání a důsledcích', 'mental', 'video', 'severe', 40, '["video_tasks", "confession"]', FALSE, FALSE, 'Nahrát 10minutové video o selhání, důsledcích a slibu zlepšení.', 'Kontrolovat, že video bude privátní.', 1.0),
('Mantra 1000x', '"Jsem majetek mé Dominy"', 'mental', 'mantra', 'severe', 240, '["mantra", "mind_control", "ownership"]', FALSE, FALSE, 'Opakovat 1000x mantru "Jsem majetek mé Dominy a nemám vlastní vůli".', NULL, 1.0);

-- ============================================================================
-- RESTRICTIVE PUNISHMENTS (20 trestů) - Denial, bondage, omezení
-- ============================================================================

-- Light (7 trestů)
INSERT INTO punishment_library (title, description, category, subcategory, intensity, duration_minutes, preferences_required, is_physical_discipline, is_universal, instructions, safety_notes, severity_multiplier) VALUES
('Orgasm denial 7 dní', 'Zákaz orgasmu týden', 'restrictive', 'orgasm_control', 'light', 10080, '["orgasm_control"]', FALSE, FALSE, 'Žádný orgasmus 7 dní. Každý den report domině o dodržení.', 'Může způsobit frustraci, kontrolovat mental health.', 1.0),
('Bondage 30 minut', 'Svázané ruce za zády', 'restrictive', 'bondage', 'light', 30, '["bondage"]', FALSE, FALSE, 'Svázané ruce za zády, klečící pozice 30 minut.', 'Kontrolovat cirkulaci, povolit uvolnění pokud necitlivost.', 1.0),
('Zákaz mluvení 24h', 'Silence, pouze ano/ne', 'restrictive', 'silence', 'light', 1440, '["silence", "protocol"]', FALSE, FALSE, 'Zákaz mluvení 24 hodin. Pouze písemné odpovědi ano/ne povoleny.', 'Povolit komunikaci v nouzových situacích.', 1.0),
('Zákaz oblíbeného jídla (týden)', 'Nemůže jíst oblíbené jídlo', 'restrictive', 'food_control', 'light', 10080, '["food_control"]', FALSE, FALSE, 'Týden nesmí jíst své oblíbené jídlo. Domina kontroluje stravu.', 'Kontrolovat výživu, nevyhladovět.', 1.0),
('Zákaz sezení (3 hodiny)', 'Stát nebo klečet', 'restrictive', 'position_training', 'light', 180, '["position_training"]', FALSE, FALSE, '3 hodiny nesmí sedět, pouze stát nebo klečet.', 'Povolit krátké přestávky pokud nutné.', 1.0),
('Zákaz elektroniky (večer)', 'Telefon, PC, TV zakázány od 18:00', 'restrictive', 'control', 'light', 240, '["control", "deprivation"]', FALSE, FALSE, 'Od 18:00 do spánku žádná elektronika (mimo práci).', 'Povolit komunikaci v nouzových situacích.', 1.0),
('Spánek na podlaze (1 noc)', 'Bez postele, pouze deka', 'restrictive', 'discomfort', 'light', 480, '["sleep_deprivation", "discomfort"]', FALSE, FALSE, 'Spát na podlaze s dekou, ne v posteli.', 'Kontrolovat zdravotní stav, povolit polštář pokud nutné.', 1.0);

-- Medium (7 trestů)
INSERT INTO punishment_library (title, description, category, subcategory, intensity, duration_minutes, preferences_required, is_physical_discipline, is_universal, instructions, safety_notes, severity_multiplier) VALUES
('Orgasm denial 14 dní', 'Zákaz orgasmu 2 týdny', 'restrictive', 'orgasm_control', 'medium', 20160, '["orgasm_control", "long_term_denial"]', FALSE, FALSE, 'Žádný orgasmus 14 dní. Denní report domině.', 'Kontrolovat frustraci a mental health.', 1.0),
('Bondage 2 hodiny', 'Hogtie nebo spread eagle', 'restrictive', 'bondage', 'medium', 120, '["bondage", "restraints"]', FALSE, FALSE, 'Hogtie nebo spread eagle pozice 2 hodiny.', 'Kontrolovat cirkulaci každých 15 minut. Povolit uvolnění pokud necitlivost.', 1.0),
('Silence 48 hodin', 'Úplný zákaz mluvení', 'restrictive', 'silence', 'medium', 2880, '["silence", "protocol"]', FALSE, FALSE, 'Úplný zákaz mluvení 48 hodin. Pouze písemná komunikace.', 'Povolit komunikaci v nouzových situacích.', 1.0),
('Zákaz elektroniky (48h)', 'Telefon, PC, TV - vše zakázáno', 'restrictive', 'control', 'medium', 2880, '["control", "deprivation"]', FALSE, FALSE, '48 hodin žádná elektronika (mimo práci).', 'Povolit komunikaci v nouzových situacích.', 1.0),
('Spánek na podlaze (týden)', 'Bez postele 7 dní', 'restrictive', 'discomfort', 'medium', 5040, '["sleep_deprivation", "discomfort"]', FALSE, FALSE, 'Týden spát na podlaze s dekou, ne v posteli.', 'Kontrolovat zdravotní stav.', 1.0),
('Zákaz teplé vody (týden)', 'Pouze studené sprchy', 'restrictive', 'discomfort', 'medium', 10080, '["discomfort"]', FALSE, FALSE, 'Týden pouze studené sprchy, žádná teplá voda.', 'Kontrolovat zdravotní stav, povolit teplou pokud nemoc.', 1.0),
('Chastity belt (14 dní)', 'Cudnost 2 týdny', 'restrictive', 'chastity', 'medium', 20160, '["chastity", "orgasm_control"]', FALSE, FALSE, 'Pokud má chastity device, nosit 14 dní. Jinak orgasm denial.', 'Kontrolovat hygienu a zdraví. Povolit uvolnění pokud zdravotní problém.', 1.0);

-- Severe (6 trestů)
INSERT INTO punishment_library (title, description, category, subcategory, intensity, duration_minutes, preferences_required, is_physical_discipline, is_universal, instructions, safety_notes, severity_multiplier) VALUES
('Orgasm denial 30 dní', 'Měsíc bez orgasmu', 'restrictive', 'orgasm_control', 'severe', 43200, '["orgasm_control", "extreme_denial"]', FALSE, FALSE, 'Žádný orgasmus 30 dní. Denní report domině.', 'Kontrolovat frustraci, mental health. Možné mood swings.', 1.0),
('Bondage celý den (víkend)', 'Svázaná mimo nezbytnosti', 'restrictive', 'bondage', 'severe', 1440, '["bondage", "long_term_restraints"]', FALSE, FALSE, 'Víkend svázaná mimo WC a jídlo.', 'Kontrolovat cirkulaci každých 30 minut. Povolit uvolnění pokud nutné.', 1.0),
('Silence týden', '7 dní bez mluvení', 'restrictive', 'silence', 'severe', 10080, '["silence", "extreme_protocol"]', FALSE, FALSE, 'Týden úplný zákaz mluvení. Pouze písemná komunikace.', 'Povolit komunikaci v nouzových situacích.', 1.0),
('Izolace 48h', 'Pouze základní interakce', 'restrictive', 'isolation', 'severe', 2880, '["isolation", "sensory_deprivation"]', FALSE, FALSE, '48 hodin v samostatné místnosti, pouze základní interakce (jídlo, WC).', 'Kontrolovat mental health. Povolit ukončení pokud panic.', 1.0),
('Chastity cage (měsíc)', 'Zamčená cudnost 30 dní', 'restrictive', 'chastity', 'severe', 43200, '["chastity", "orgasm_control", "long_term"]', FALSE, FALSE, 'Pokud má chastity device, nosit měsíc. Domina má klíč.', 'Kontrolovat hygienu denně. Povolit uvolnění pokud zdravotní problém.', 1.0),
('Spánek v kleci (týden)', 'Klec místo postele', 'restrictive', 'confinement', 'severe', 5040, '["confinement", "extreme_discipline"]', FALSE, FALSE, 'Pokud má klec, spát v ní týden. Jinak na podlaze.', 'Kontrolovat zdravotní stav a mental health.', 1.0);

-- ============================================================================
-- CREATIVE & HOUSEHOLD (20 trestů) - Chores, labor
-- ============================================================================

-- Light (7 trestů)
INSERT INTO punishment_library (title, description, category, subcategory, intensity, duration_minutes, preferences_required, is_physical_discipline, is_universal, instructions, safety_notes, severity_multiplier) VALUES
('Umýt podlahy (celý dům)', 'Ručně na kolenou', 'creative', 'chores', 'light', 120, '["domestic_service"]', FALSE, FALSE, 'Umýt všechny podlahy v domě ručně na kolenou s hadrem a kbelíkem.', 'Kolena chránit podložkou pokud nutné.', 1.0),
('Vyčistit koupelnu 3x (týden)', 'Důkladně každý detail', 'creative', 'cleaning', 'light', 180, '["cleaning", "domestic_service"]', FALSE, FALSE, 'Vyčistit koupelnu 3x za týden, důkladně každý detail.', NULL, 1.0),
('Ručně vyprat veškeré prádlo', 'Bez pračky', 'creative', 'laundry', 'light', 180, '["domestic_service", "hard_labor"]', FALSE, FALSE, 'Vyprat veškeré prádlo ručně, pokud možné bez pračky.', 'Kontrolovat materiály, některé nesmí být prané ručně.', 1.0),
('Vyleštit všechny boty Dominy', 'Do zrcadlového lesku', 'creative', 'service', 'light', 60, '["boot_worship", "service"]', FALSE, FALSE, 'Vyčistit a vyleštit všechny boty dominy do zrcadlového lesku.', NULL, 1.0),
('Uvařit 7 jídel (týden)', 'Každý den pro Dominu', 'creative', 'cooking', 'light', 420, '["cooking", "service"]', FALSE, FALSE, 'Uvařit jídlo pro dominu každý den týden.', 'Kontrolovat dietní požadavky dominy.', 1.0),
('Reorganizovat skříň', 'Podle pokynů Dominy', 'creative', 'organization', 'light', 120, '["organization", "service"]', FALSE, FALSE, 'Reorganizovat skříň přesně podle pokynů dominy.', NULL, 1.0),
('Vyčistit okna', 'Všechna okna v domě', 'creative', 'cleaning', 'light', 90, '["cleaning"]', FALSE, FALSE, 'Vyčistit všechna okna v domě vevnitř i venku.', 'Bezpečnost při práci ve výškách.', 1.0);

-- Medium (7 trestů)
INSERT INTO punishment_library (title, description, category, subcategory, intensity, duration_minutes, preferences_required, is_physical_discipline, is_universal, instructions, safety_notes, severity_multiplier) VALUES
('Generální úklid celého bytu', '6+ hodin práce', 'creative', 'cleaning', 'medium', 360, '["domestic_service", "hard_labor"]', FALSE, FALSE, 'Generální úklid celého bytu/domu, každý kout.', NULL, 1.0),
('Vyčistit okna (všechna)', 'Vevnitř i venku', 'creative', 'cleaning', 'medium', 180, '["cleaning"]', FALSE, FALSE, 'Vyčistit všechna okna důkladně vevnitř i venku.', 'Bezpečnost při práci ve výškách.', 1.0),
('Reorganizovat skříně Dominy', 'Perfektní uspořádání', 'creative', 'organization', 'medium', 240, '["organization", "service"]', FALSE, FALSE, 'Reorganizovat všechny skříně dominy podle pokynů.', NULL, 1.0),
('Vyprat, vysušit, vyžehlit vše', 'Veškeré prádlo v domě', 'creative', 'laundry', 'medium', 360, '["domestic_service"]', FALSE, FALSE, 'Vyprat, vysušit a vyžehlit veškeré prádlo v domě.', NULL, 1.0),
('Připravit 14 jídel (2 týdny)', 'Meal prep pro Dominu', 'creative', 'cooking', 'medium', 480, '["cooking", "meal_prep"]', FALSE, FALSE, 'Připravit meal prep pro dominu na 2 týdny dopředu.', 'Kontrolovat skladování a trvanlivost.', 1.0),
('Umýt auto Dominy (měsíc)', '3x za týden', 'creative', 'service', 'medium', 720, '["service", "vehicle_care"]', FALSE, FALSE, 'Umýt auto dominy 3x týdně po dobu měsíce včetně interiéru.', NULL, 1.0),
('Vyčistit garáž/sklep', 'Kompletní organizace', 'creative', 'organization', 'medium', 300, '["organization", "hard_labor"]', FALSE, FALSE, 'Vyčistit a zorganizovat garáž nebo sklep kompletně.', 'Bezpečnost při přenášení těžkých předmětů.', 1.0);

-- Severe (6 trestů)
INSERT INTO punishment_library (title, description, category, subcategory, intensity, duration_minutes, preferences_required, is_physical_discipline, is_universal, instructions, safety_notes, severity_multiplier) VALUES
('Kompletní hloubkový úklid (víkend)', 'Každý kout, každá špína', 'creative', 'cleaning', 'severe', 960, '["domestic_service", "extreme_labor"]', FALSE, FALSE, 'Celý víkend kompletní hloubkový úklid celého domu/bytu.', 'Kontrolovat únavu, povolit přestávky.', 1.0),
('Umýt auto Dominy (3x týdně, měsíc)', 'Včetně interiéru', 'creative', 'service', 'severe', 1440, '["service", "vehicle_care"]', FALSE, FALSE, 'Měsíc 3x týdně umýt auto dominy včetně interiéru.', NULL, 1.0),
('Přeorganizovat celý byt', 'Podle nových pokynů', 'creative', 'organization', 'severe', 720, '["organization", "hard_labor"]', FALSE, FALSE, 'Přeorganizovat celý byt podle nových pokynů dominy.', 'Bezpečnost při přenášení těžkých předmětů.', 1.0),
('Měsíc péče o boty', 'Každý den čistit/leštit', 'creative', 'service', 'severe', 1800, '["boot_care", "daily_service"]', FALSE, FALSE, 'Každý den měsíc čistit a leštit boty dominy.', NULL, 1.0),
('30 dní vaření', 'Každý den 3 jídla', 'creative', 'cooking', 'severe', 5400, '["cooking", "daily_service"]', FALSE, FALSE, 'Měsíc každý den uvařit 3 jídla (snídaně, oběd, večeře) pro dominu.', 'Kontrolovat dietní požadavky.', 1.0),
('Renovace místnosti', 'Malování, úpravy', 'creative', 'labor', 'severe', 2880, '["hard_labor", "construction"]', FALSE, FALSE, 'Zrenovovat místnost - malování, úklid, organizace.', 'Bezpečnost při práci. Kontrolovat ventilaci při malování.', 1.0);

-- ============================================================================
-- UNIVERSAL PUNISHMENTS (20 trestů) - is_universal = TRUE
-- Použitelné vždy (fallback)
-- ============================================================================

INSERT INTO punishment_library (title, description, category, subcategory, intensity, duration_minutes, preferences_required, is_physical_discipline, is_universal, instructions, safety_notes, severity_multiplier) VALUES
('500 dřepů', 'Rozložit do dne', 'universal', 'fitness', 'medium', 120, NULL, FALSE, TRUE, 'Rozložit během dne, dokončit do 24h od přiřazení.', 'Správná forma dřepů, jinak riziko zranění kolen.', 1.0),
('1000 jumping jacks', 'Během 48 hodin', 'universal', 'fitness', 'medium', 180, NULL, FALSE, TRUE, '1000 jumping jacks během 48 hodin, může být rozděleno.', 'Správná forma.', 1.0),
('Plank 10 minut celkem', 'Rozdělit na série', 'universal', 'fitness', 'light', 30, NULL, FALSE, TRUE, 'Plank celkem 10 minut, rozdělit na série (např. 10x1min).', 'Správná forma, jinak riziko zranění zad.', 1.0),
('Běh 10 km', 'Do 48 hodin', 'universal', 'fitness', 'medium', 90, NULL, FALSE, TRUE, 'Běh 10 km do 48 hodin (nebo walking pokud nutné).', 'Kontrolovat zdravotní stav.', 1.0),
('100 shybů', 'Asistovaných pokud nutné', 'universal', 'fitness', 'medium', 60, NULL, FALSE, TRUE, '100 shybů (asistovaných pokud nutné) do 48 hodin.', 'Správná forma.', 1.0),
('200 kliků', 'Do 48 hodin', 'universal', 'fitness', 'medium', 90, NULL, FALSE, TRUE, '200 kliků do 48 hodin, může být rozděleno.', 'Správná forma, kontrolovat ramena.', 1.0),
('30 minut wall sit', 'Celkem během dne', 'universal', 'fitness', 'light', 60, NULL, FALSE, TRUE, 'Wall sit celkem 30 minut během dne, rozdělit na série.', 'Správná forma, kontrolovat kolena.', 1.0),
('Studená sprcha denně (týden)', 'Pouze studená voda', 'universal', 'discomfort', 'light', 70, NULL, FALSE, TRUE, 'Týden pouze studené sprchy, žádná teplá voda.', 'Kontrolovat zdravotní stav.', 1.0),
('Vstávat 5:00 ráno (týden)', 'Každý den včas', 'universal', 'discipline', 'light', 10080, NULL, FALSE, TRUE, 'Týden vstávat každý den v 5:00 ráno.', 'Kontrolovat spánkový režim.', 1.0),
('Žádné sladkosti (měsíc)', 'Cukr pouze z ovoce', 'universal', 'diet', 'medium', 43200, NULL, FALSE, TRUE, 'Měsíc žádné sladkosti, cukr pouze z ovoce.', 'Kontrolovat výživu.', 1.0),
('Žádná káva/kofein (14 dní)', 'Bez kofeinu', 'universal', 'diet', 'light', 20160, NULL, FALSE, TRUE, '14 dní bez kofeinu (káva, čaj, energy drinks).', 'Možné abstinenční příznaky (bolest hlavy).', 1.0),
('10 000 kroků denně (měsíc)', 'Každý den minimálně', 'universal', 'fitness', 'light', 43200, NULL, FALSE, TRUE, 'Měsíc každý den minimálně 10 000 kroků. Trackovat aplikací.', NULL, 1.0),
('Meditace 20 min denně (týden)', 'Klečící pozice', 'universal', 'meditation', 'light', 140, NULL, FALSE, TRUE, 'Týden každý den 20 minut meditace v klečící pozici.', 'Kontrolovat, že skutečně medituje.', 1.0),
('Journaling každý den (měsíc)', 'Denní zápisy o poslušnosti', 'universal', 'writing', 'medium', 1800, NULL, FALSE, TRUE, 'Měsíc každý den psát journaling o poslušnosti a službě.', NULL, 1.0),
('Čtení knihy o službě', 'Přečíst + esej 1000 slov', 'universal', 'education', 'medium', 600, NULL, FALSE, TRUE, 'Přečíst knihu o BDSM/FLR a napsat esej 1000 slov.', NULL, 1.0),
('Žádný alkohol (měsíc)', 'Úplný zákaz', 'universal', 'diet', 'medium', 43200, NULL, FALSE, TRUE, 'Měsíc žádný alkohol.', 'Kontrolovat zdravotní stav pokud pravidelný konzument.', 1.0),
('Pití 3L vody denně (týden)', 'Každý den minimálně', 'universal', 'health', 'light', 10080, NULL, FALSE, TRUE, 'Týden každý den minimálně 3L vody.', 'Kontrolovat přílišnou konzumaci.', 1.0),
('Strečink 30 min denně (týden)', 'Flexibility training', 'universal', 'fitness', 'light', 210, NULL, FALSE, TRUE, 'Týden každý den 30 minut strečinku.', 'Správná technika, nepřetahovat svaly.', 1.0),
('Denní úklid 1 hodina (měsíc)', 'Každý den hodina úklidu', 'universal', 'chores', 'medium', 1800, NULL, FALSE, TRUE, 'Měsíc každý den hodina úklidu.', NULL, 1.0),
('Gratitude journal (měsíc)', '5 věcí denně', 'universal', 'writing', 'light', 900, NULL, FALSE, TRUE, 'Měsíc každý den napsat 5 věcí za které je vděčná domině.', NULL, 1.0);

-- ============================================================================
-- HOTOVO - 100 trestů
-- ============================================================================
