/**
 * @Author: Klaudie <klaudie@foxprofi.cz>
 *
 * Seed: Task Library Part 1 (#040)
 * Household (30/120), Protocol (20/80), BDSM (40/150)
 */

-- ============================================================================
-- HOUSEHOLD TASKS (30/120) - Domácnost, úklid, vaření, služba
-- ============================================================================

-- Trivial (10)
INSERT INTO task_library (title, description, category, subcategory, difficulty, level_required, bdsm_intensity, duration_minutes, instructions) VALUES
('Umýt nádobí', 'Umýt veškeré nádobí po jídle', 'household', 'cleaning', 'trivial', 1, 'none', 15, 'Umýt veškeré nádobí, utřít a uklidit na místo.'),
('Vynést koš', 'Vynést odpadkový koš', 'household', 'chores', 'trivial', 1, 'none', 5, 'Vynést koš, vyměnit pytel.'),
('Ustel postel', 'Ustlat postel dominy', 'household', 'service', 'trivial', 1, 'none', 10, 'Ustlat postel dominy pečlivě, vyrovnat polštáře.'),
('Utřít prach', 'Utřít prach v obývacím pokoji', 'household', 'cleaning', 'trivial', 1, 'none', 20, 'Utřít prach ze všech povrchů.'),
('Zalít květiny', 'Zalít všechny květiny v domě', 'household', 'chores', 'trivial', 1, 'none', 10, 'Zkontrolovat a zalít všechny květiny.'),
('Přinést kávu', 'Přinést kávu do postele', 'household', 'service', 'trivial', 1, 'none', 10, 'Uvařit kávu přesně jak domina chce a přinést do postele.'),
('Vyluxovat jednu místnost', 'Vysát jednu místnost', 'household', 'cleaning', 'trivial', 1, 'none', 15, 'Důkladně vysát vybranou místnost včetně rohů.'),
('Složit prádlo', 'Složit vysušené prádlo', 'household', 'laundry', 'trivial', 1, 'none', 20, 'Pečlivě složit a uklidit vysušené prádlo.'),
('Připravit snídani', 'Připravit snídani pro dominu', 'household', 'cooking', 'trivial', 1, 'none', 30, 'Připravit snídani podle preferencí dominy.'),
('Vyčistit zrcadla', 'Vyčistit všechna zrcadla', 'household', 'cleaning', 'trivial', 1, 'none', 15, 'Vyčistit zrcadla do čista bez šmouh.');

-- Easy (10)
INSERT INTO task_library (title, description, category, subcategory, difficulty, level_required, bdsm_intensity, duration_minutes, instructions) VALUES
('Umýt podlahu v kuchyni', 'Umýt podlahu v kuchyni na kolenou', 'household', 'cleaning', 'easy', 1, 'none', 30, 'Umýt podlahu ručně na kolenou s hadrem.'),
('Vyčistit koupelnu', 'Důkladně vyčistit celou koupelnu', 'household', 'cleaning', 'easy', 1, 'none', 45, 'Vyčistit WC, umyvadlo, vanu, podlahu - vše do čista.'),
('Vyprat prádlo', 'Vyprat všechno špinavé prádlo', 'household', 'laundry', 'easy', 1, 'none', 60, 'Roztřídit, vyprat, pověsit k sušení.'),
('Uvařit oběd', 'Uvařit oběd pro dominu', 'household', 'cooking', 'easy', 1, 'none', 60, 'Uvařit teplé jídlo podle preferencí dominy.'),
('Uklidit ložnici', 'Uklidit a utřídit ložnici', 'household', 'cleaning', 'easy', 1, 'none', 40, 'Uklidit vše na místa, utřít prach, vysát.'),
('Vyčistit lednici', 'Vyčistit celou lednici', 'household', 'cleaning', 'easy', 1, 'none', 45, 'Vyndat vše, vyčistit, zkontrolovat trvanlivost.'),
('Žehlení', 'Vyžehlit veškeré prádlo', 'household', 'laundry', 'easy', 1, 'none', 60, 'Vyžehlit všechno prádlo pečlivě.'),
('Nakoupit potraviny', 'Nakoupit podle seznamu dominy', 'household', 'errands', 'easy', 1, 'none', 60, 'Nakoupit vše podle seznamu, bez improvizace.'),
('Vyčistit boty dominy', 'Vyčistit všechny boty dominy', 'household', 'service', 'easy', 1, 'none', 30, 'Vyčistit a vyleštit všechny boty dominy.'),
('Uklidit kuchyni', 'Kompletně uklidit kuchyni', 'household', 'cleaning', 'easy', 1, 'none', 45, 'Umýt nádobí, utřít pracovní plochy, uklidit vše.');

-- Medium (10)
INSERT INTO task_library (title, description, category, subcategory, difficulty, level_required, bdsm_intensity, duration_minutes, instructions) VALUES
('Generální úklid koupelny', 'Hloubkový úklid celé koupelny', 'household', 'cleaning', 'medium', 2, 'none', 90, 'Vyčistit každý detail včetně spár, odtoků, ventilace.'),
('Meal prep na týden', 'Připravit jídla na celý týden', 'household', 'cooking', 'medium', 2, 'none', 240, 'Naplánovat, uvařit a skladovat jídla na týden dopředu.'),
('Vyleštit všechny boty do zrcadla', 'Všechny boty do zrcadlového lesku', 'household', 'service', 'medium', 2, 'none', 60, 'Vyčistit a vyleštit všechny boty dominy do perfektního stavu.'),
('Umýt okna (celý byt)', 'Všechna okna vevnitř i venku', 'household', 'cleaning', 'medium', 2, 'none', 120, 'Vyčistit všechna okna důkladně bez šmouh.'),
('Reorganizovat šatní skříň', 'Reorganizovat skříň dominy', 'household', 'organization', 'medium', 2, 'none', 90, 'Vytřídit, složit a uspořádat podle pokynů dominy.'),
('Uvařit slavnostní večeři', 'Tříchodové menu pro dominu', 'household', 'cooking', 'medium', 2, 'none', 180, 'Připravit a servírovat elegantní večeři.'),
('Vyčistit lednici a spíž kompletně', 'Hloubkový úklid lednice a spíže', 'household', 'cleaning', 'medium', 2, 'none', 90, 'Vyndat vše, vyčistit, reorganizovat.'),
('Vyprat a vyžehlit vše za týden', 'Veškeré prádlo za týden', 'household', 'laundry', 'medium', 2, 'none', 180, 'Vyprat, vysušit, vyžehlit veškeré prádlo z týdne.'),
('Umýt podlahy v celém bytě na kolenou', 'Všechny podlahy ručně', 'household', 'cleaning', 'medium', 2, 'soft', 120, 'Umýt všechny podlahy v bytě ručně na kolenou.'),
('Uklidit a vyčistit balkon/terasu', 'Kompletní úklid venkovního prostoru', 'household', 'cleaning', 'medium', 2, 'none', 90, 'Umýt, uklidit a uspořádat balkon/terasu.');

-- ============================================================================
-- PROTOCOL TASKS (20/80) - Pravidla, etiketa, pozice, rituály
-- ============================================================================

-- Trivial (7)
INSERT INTO task_library (title, description, category, subcategory, difficulty, level_required, bdsm_intensity, duration_minutes, instructions) VALUES
('Pozdrav dominu správným oslovením', 'Ráno pozdravit dominu korektně', 'protocol', 'etiquette', 'trivial', 1, 'soft', 1, 'Při prvním setkání dne pozdravit "Dobré ráno, paní" nebo dohodnuté oslovení.'),
('Podržet dveře', 'Otevřít a podržet dveře domině', 'protocol', 'service', 'trivial', 1, 'none', 1, 'Vždy otevřít a podržet dveře, nechat projít dominu první.'),
('Připravit věci dominy ráno', 'Připravit oblečení a věci na den', 'protocol', 'service', 'trivial', 1, 'none', 10, 'Připravit oblečení, tašku, klíče podle pokynů.'),
('Zeptat se na povolení mluvit', 'Před mluvením požádat o svolení', 'protocol', 'permission', 'trivial', 1, 'soft', 1, 'Před každou konverzací se zeptat "Mohu mluvit, paní?".'),
('Oční kontakt pouze s povolením', 'Nedívat se do očí bez svolení', 'protocol', 'respect', 'trivial', 1, 'soft', 1, 'Pohlédnout do očí pouze pokud domina povolí.'),
('Uklidit za dominou', 'Uklidit vše co domina použila', 'protocol', 'service', 'trivial', 1, 'none', 10, 'Průběžně uklidit věci které domina použila a nechala.'),
('Nabídnout nápoj pravidelně', 'Každou hodinu nabídnout domině nápoj', 'protocol', 'service', 'trivial', 1, 'none', 5, 'Každou hodinu se zeptat zda domina nechce pít.');

-- Easy (7)
INSERT INTO task_library (title, description, category, subcategory, difficulty, level_required, bdsm_intensity, duration_minutes, instructions) VALUES
('Klečící pozice 15 minut', 'Klečet v respectful pozici', 'protocol', 'position', 'easy', 1, 'soft', 15, 'Klečící pozice, ruce na stehnech nebo za zády, hlava skloněná.'),
('Servírovat jídlo správným způsobem', 'Servírovat s etiketou', 'protocol', 'service', 'easy', 1, 'none', 30, 'Servírovat jídlo domině jako první, čekat na povolení jíst.'),
('Referovat o dni večer', 'Evening report o aktivitách', 'protocol', 'reporting', 'easy', 1, 'soft', 15, 'Večer referovat domině o všech aktivitách dne.'),
('Požádat o povolení k jídlu', 'Před každým jídlem požádat o svolení', 'protocol', 'permission', 'easy', 1, 'soft', 1, 'Před snídaní, obědem, večeří požádat o povolení jíst.'),
('Ranní rituál služby', 'Ranní rituální služba domině', 'protocol', 'ritual', 'easy', 1, 'soft', 30, 'Přinést kávu, připravit snídani, nabídnout masáž chodidel.'),
('Večerní rituál před spaním', 'Večerní služba před spánkem', 'protocol', 'ritual', 'easy', 1, 'soft', 30, 'Připravit postel, nabídnout masáž, požádat o dovolení jít spát.'),
('Denní kontrolní check-in', 'Check-in s dominou o splnění úkolů', 'protocol', 'reporting', 'easy', 1, 'none', 10, 'Reportovat domině stav úkolů a zeptat se na další pokyny.');

-- Medium (6)
INSERT INTO task_library (title, description, category, subcategory, difficulty, level_required, bdsm_intensity, duration_minutes, instructions) VALUES
('Klečící pozice hodinu denně', 'Klečet v pozici hodinu', 'protocol', 'position', 'medium', 2, 'soft', 60, 'Klečící pozice hodinu denně, kontrolovat správné držení těla.'),
('Naučit se formální protokol oslovení', 'Formální protokol pro různé situace', 'protocol', 'etiquette', 'medium', 2, 'soft', 120, 'Naučit se správné oslovení pro různé situace (ráno, večer, před hosty, atd.).'),
('Celý den v klečící pozici (mimo práci)', 'Doma pouze klečet', 'protocol', 'position', 'medium', 2, 'medium', 480, 'Celý den doma klečet, stát nebo ležet pouze s povolením.'),
('Slavnostní večerní rituál', 'Rozsáhlý večerní rituál služby', 'protocol', 'ritual', 'medium', 2, 'soft', 90, 'Připravit lázeň, masáž, oblečení na noc, připravit postel.'),
('Mluvit pouze když se ptají', 'Celý den mluvit pouze na otázky', 'protocol', 'silence', 'medium', 2, 'medium', 1440, 'Celý den nemluvit, pouze odpovídat na přímé otázky dominy.'),
('Týden denního check-in protokolu', 'Týden pravidelných reportů', 'protocol', 'reporting', 'medium', 2, 'soft', 70, 'Celý týden denní ranní, polední a večerní check-in s dominou.');

-- ============================================================================
-- BDSM TASKS (40/150) - Soft/Medium/Hard
-- ============================================================================

-- BDSM Soft (15/50)
INSERT INTO task_library (title, description, category, subcategory, difficulty, bdsm_intensity, level_required, duration_minutes, instructions, preferences_required) VALUES
('Lehké bondage 30 minut', 'Svázané ruce na 30 minut', 'bdsm', 'bondage', 'easy', 'soft', 1, 30, 'Svázané ruce za zády nebo vpředu, klečící nebo sedící pozice.', '["bondage"]'),
('10 plácnutí přes zadek', 'Lehký spanking', 'bdsm', 'spanking', 'easy', 'soft', 1, 10, 'OTK pozice, 10 plácnutí otevřenou dlaní.', '["spanking", "impact_play"]'),
('Nosit obojek hodinu', 'Nosit obojek jako symbol', 'bdsm', 'collar', 'trivial', 'soft', 1, 60, 'Nosit obojek hodinu doma.', '["collar"]'),
('Lízat boty dominy', 'Očistit boty jazykem', 'bdsm', 'foot_worship', 'easy', 'soft', 1, 10, 'Očistit boty dominy jazykem jako akt podřízenosti.', '["foot_worship"]'),
('Masáž chodidel 20 minut', 'Masírovat chodidla dominy', 'bdsm', 'foot_worship', 'trivial', 'soft', 1, 20, 'Pečlivá masáž chodidel dominy.', '["foot_worship"]'),
('Roleplay - služka', 'Roleplay jako služka po hodinu', 'bdsm', 'roleplay', 'easy', 'soft', 1, 60, 'Oblečení a chování služky, servírovat dominu.', '["roleplay"]'),
('Zavázané oči 15 minut', 'Sensory deprivation - oči', 'bdsm', 'sensory', 'easy', 'soft', 1, 15, 'Zavázané oči, klečící pozice, soustředit se na ostatní smysly.', '["sensory_deprivation", "blindfold"]'),
('Prezentovat tělo ke kontrole', 'Stát nude ke kontrole', 'bdsm', 'inspection', 'easy', 'soft', 1, 10, 'Stát nahá v inspection pozici, domina kontroluje tělo.', '["inspection", "nudity"]'),
('5 minut tickling torture', 'Lehké lechtání jako trest', 'bdsm', 'torture', 'easy', 'soft', 1, 5, 'Svázané ruce, 5 minut lechtání.', '["bondage", "tickling"]'),
('Držet pozici 10 minut', 'Stressful position holding', 'bdsm', 'endurance', 'easy', 'soft', 1, 10, 'Držet těžkou pozici (např. dřep, wall sit) 10 minut.', '["position_training"]'),
('Nosit butt plug hodinu', 'Anální plug jako reminder', 'bdsm', 'anal_play', 'easy', 'soft', 1, 60, 'Nosit butt plug hodinu jako připomínku podřízenosti.', '["anal_play", "toys"]'),
('Crawling po bytě', 'Pohybovat se pouze po čtyřech', 'bdsm', 'degradation', 'easy', 'soft', 1, 30, 'Půl hodiny se pohybovat pouze po čtyřech jako zvíře.', '["pet_play", "degradation"]'),
('Tepování klitorisu 20x', 'Lehké impact play', 'bdsm', 'impact', 'easy', 'soft', 1, 5, '20 lehkých tepů prstem na klitoris.', '["clit_torture", "impact_play"]'),
('Corner time s rozpřaženými nohama', 'Stát v rohu s nohama od sebe', 'bdsm', 'corner_time', 'easy', 'soft', 1, 15, 'Stát v rohu, ruce na hlavě, nohy širokorozkročené 15 minut.', '["corner_time", "exposure"]'),
('Poklona s políbením bot', 'Ceremonial bow', 'bdsm', 'worship', 'trivial', 'soft', 1, 2, 'Plná poklona, čelo k zemi, políbit boty dominy.', '["worship", "foot_worship"]');

-- BDSM Medium (15/60)
INSERT INTO task_library (title, description, category, subcategory, difficulty, bdsm_intensity, level_required, duration_minutes, instructions, preferences_required) VALUES
('Bondage 2 hodiny', 'Svázaná 2 hodiny', 'bdsm', 'bondage', 'medium', 'medium', 2, 120, 'Hogtie nebo spread eagle pozice 2 hodiny.', '["bondage", "restraints"]'),
('30 ran pádlem', 'Impact play s pádlem', 'bdsm', 'impact', 'medium', 'medium', 2, 15, 'OTK pozice, 30 ran dřevěným pádlem na zadek.', '["impact_play", "paddling"]'),
('Orgasm denial týden', 'Zákaz orgasmu 7 dní', 'bdsm', 'orgasm_control', 'medium', 'medium', 2, 10080, 'Týden žádný orgasmus, denní report domině.', '["orgasm_control"]'),
('Forced orgasm session', 'Opakované vynucené orgasmy', 'bdsm', 'orgasm_torture', 'medium', 'medium', 2, 30, 'Svázaná, vibrátor, nucení k opakovaným orgasmům.', '["forced_orgasm", "bondage", "toys"]'),
('Nipple clamps 30 minut', 'Svorky na bradavky', 'bdsm', 'pain_play', 'medium', 'medium', 2, 30, 'Svorky na bradavky 30 minut při normálních činnostech.', '["nipple_torture", "pain_play"]'),
('Ice torture 15 minut', 'Ledové kostky na těle', 'bdsm', 'temperature_play', 'medium', 'medium', 2, 15, 'Ledové kostky po celém těle, svázané ruce.', '["temperature_play", "bondage"]'),
('Wax play session', 'Hor kav na tělo', 'bdsm', 'wax_play', 'medium', 'medium', 3, 30, 'Horký vosk kapá na záda, zadek, prsa.', '["wax_play", "pain_play"]'),
('Spreader bar 1 hodina', 'Roztahovací tyč na nohy', 'bdsm', 'bondage', 'medium', 'medium', 2, 60, 'Spreader bar na kotníky, klečící nebo ležící pozice hodinu.', '["bondage", "restraints"]'),
('Gag + bondage 30 minut', 'Roubík a svázání', 'bdsm', 'bondage', 'medium', 'medium', 2, 30, 'Roubík v ústech, ruce za zády, klečící pozice.', '["bondage", "gag"]'),
('Kneel on rice 20 minut', 'Klečení na rýži', 'bdsm', 'pain_play', 'medium', 'medium', 2, 20, 'Klečet na zrní rýže 20 minut, ruce na hlavě.', '["pain_play", "endurance"]'),
('Public humiliation (mild)', 'Mírné ponížení ve veřejném prostoru', 'bdsm', 'humiliation', 'medium', 'medium', 3, 60, 'Nosit obojek nebo jiné označení v polopřívátním prostoru (např. auto).', '["public_humiliation", "collar"]'),
('Serve dinner naked', 'Servírovat večeři nahá', 'bdsm', 'nudity', 'medium', 'medium', 2, 60, 'Připravit a servírovat večeři kompletně nahá.', '["nudity", "exposure"]'),
('Orgasm on command training', 'Trénink orgasmu na povel', 'bdsm', 'orgasm_control', 'medium', 'medium', 2, 60, 'Trénink dosažení orgasmu pouze na povel dominy.', '["orgasm_control"]'),
('Stress position 30 minut', 'Těžká pozice', 'bdsm', 'endurance', 'medium', 'medium', 2, 30, 'Wall sit, plank nebo jiná stressful pozice 30 minut.', '["endurance", "pain_play"]'),
('Clothespins torture', '20 kolíčků na tělo', 'bdsm', 'pain_play', 'medium', 'medium', 2, 20, '20 kolíčků na prádlo po celém těle, nosit 20 minut.', '["pain_play", "clothespins"]');

-- BDSM Hard (10/40)
INSERT INTO task_library (title, description, category, subcategory, difficulty, bdsm_intensity, level_required, duration_minutes, instructions, preferences_required) VALUES
('50 ran třtinou', 'Těžké caning', 'bdsm', 'caning', 'hard', 'hard', 4, 30, '50 ran třtinou na zadek a stehna, zanechá modřiny.', '["caning", "impact_play", "severe_pain"]'),
('Orgasm denial měsíc', 'Zákaz orgasmu 30 dní', 'bdsm', 'orgasm_control', 'hard', 'hard', 4, 43200, 'Měsíc bez orgasmu, denní check-in.', '["orgasm_control", "extreme_denial"]'),
('Bondage celý den', 'Svázaná celý den (víkend)', 'bdsm', 'bondage', 'hard', 'hard', 4, 1440, 'Celý víkend svázaná mimo WC a jídlo.', '["bondage", "long_term_restraints"]'),
('Extreme nipple torture', 'Těžká torture bradavek', 'bdsm', 'nipple_torture', 'hard', 'hard', 4, 45, 'Svorky + závaží, lechtání, ice, štípání - 45 minut.', '["nipple_torture", "extreme_pain"]'),
('100 ran floggerem', 'Těžký flogging', 'bdsm', 'flogging', 'hard', 'hard', 4, 40, '100 ran floggerem na záda, zadek, stehna.', '["flogging", "impact_play", "severe_pain"]'),
('Breath play session', 'Kontrola dechu', 'bdsm', 'breath_play', 'extreme', 'hard', 5, 20, 'Kontrola dechu s roubíkem nebo rukou, velmi nebezpečné!', '["breath_play", "edge_play"]'),
('Extended chastity (3 měsíce)', 'Chastity belt 3 měsíce', 'bdsm', 'chastity', 'extreme', 'hard', 4, 129600, '3 měsíce v chastity device, domina má klíč.', '["chastity", "extreme_orgasm_control"]'),
('Suspension bondage 30 minut', 'Zavěšení v bondage', 'bdsm', 'suspension', 'extreme', 'hard', 5, 30, 'Zavěšení v rope bondage, velmi pokročilé!', '["suspension", "rope_bondage", "extreme"]'),
('Electrostimulation session', 'Elektrická stimulace', 'bdsm', 'electro', 'hard', 'hard', 4, 30, 'TENS unit na bradavky, klitoris, genitálie.', '["electrostimulation", "extreme_pain"]'),
('Extended sensory deprivation', '4 hodiny zavřená v izolaci', 'bdsm', 'sensory_deprivation', 'extreme', 'hard', 5, 240, '4 hodiny zavřená v temné místnosti, bez zvuků.', '["sensory_deprivation", "isolation", "extreme"]');

