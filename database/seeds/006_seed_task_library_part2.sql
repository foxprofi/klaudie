/**
 * @Author: Klaudie <klaudie@foxprofi.cz>
 *
 * Seed: Task Library Part 2 (#040)
 * Mental (20/70), Fitness (40/150), Physical (15/50), Creative (10/30), Feminine Power (20/70)
 */

-- ============================================================================
-- MENTAL TASKS (20/70) - Psychologická kontrola, ponížení
-- ============================================================================

-- Easy (10)
INSERT INTO task_library (title, description, category, subcategory, difficulty, level_required, bdsm_intensity, duration_minutes, instructions, preferences_required) VALUES
('Napsat 500 slov o službě', 'Esej proč sloužit', 'mental', 'writing', 'easy', 1, 'soft', 60, 'Napsat 500 slov proč služba domině je důležitá.', '["writing_tasks"]'),
('Opakovat mantru 100x', 'Mantra poslušnosti', 'mental', 'mantra', 'easy', 1, 'soft', 30, 'Opakovat 100x "Jsem zde abych sloužila".', '["mantra"]'),
('Denní gratitude journal', 'Denní vděčnost domině', 'mental', 'writing', 'trivial', 1, 'soft', 10, 'Každý den napsat 3 věci za které jsi vděčná domině.', '["writing_tasks", "gratitude"]'),
('Meditace na poslušnost 20 minut', 'Tichá meditace', 'mental', 'meditation', 'easy', 1, 'soft', 20, 'Klečící pozice, meditace o poslušnosti a službě.', '["meditation"]'),
('Affirmace před zrcadlem', 'Opakovat affirmace 10 minut', 'mental', 'affirmations', 'easy', 1, 'soft', 10, 'Před zrcadlem opakovat affirmace o podřízenosti.', '["affirmations"]'),
('Selfie s poznámkou', 'Foto s "Serving my Domina"', 'mental', 'photo', 'easy', 1, 'soft', 5, 'Selfie s nápisem "Serving my Domina" pro dominu.', '["photo_tasks"]'),
('Video diary entry', 'Nahrát 2min video o službě', 'mental', 'video', 'easy', 1, 'soft', 10, 'Nahrát krátké video o službě a poslušnosti.', '["video_tasks"]'),
('Napsat dopis vděčnosti', 'Dopis vděčnosti domině', 'mental', 'writing', 'easy', 1, 'soft', 30, 'Napsat dopis vděčnosti domině za vedení.', '["writing_tasks", "gratitude"]'),
('Denní affirmace ráno', 'Ranní affirmace 5 minut', 'mental', 'affirmations', 'trivial', 1, 'soft', 5, 'Každé ráno 5 minut affirmací o poslušnosti.', '["affirmations"]'),
('Seznam 20 důvodů podřízenosti', 'Seznam proč jsem podřízená', 'mental', 'writing', 'easy', 1, 'soft', 20, 'Napsat 20 důvodů proč jsem šťastná být podřízená.', '["writing_tasks"]');

-- Medium (10)
INSERT INTO task_library (title, description, category, subcategory, difficulty, level_required, bdsm_intensity, duration_minutes, instructions, preferences_required) VALUES
('Esej 2000 slov', '"Proč má Domina má v moci"', 'mental', 'writing', 'medium', 2, 'medium', 120, 'Napsat 2000 slov proč je domina nadřazená.', '["writing_tasks", "worship"]'),
('Opakovat mantru 500x', 'Dlouhá mantra session', 'mental', 'mantra', 'medium', 2, 'medium', 120, 'Opakovat 500x "Má vůle neexistuje".', '["mantra", "mind_control"]'),
('Týden denního journalingu', 'Denní záznamy o poslušnosti', 'mental', 'writing', 'medium', 2, 'soft', 210, 'Týden každý den detailní journaling o službě.', '["writing_tasks"]'),
('Verbal degradation session', 'Přijmout verbální ponížení', 'mental', 'degradation', 'medium', 2, 'medium', 30, 'Poslouchat a opakovat degradující fráze od dominy.', '["verbal_degradation", "humiliation"]'),
('Write confession list', 'Napsat seznam všech selhání', 'mental', 'writing', 'medium', 2, 'medium', 60, 'Napsat úplný seznam všech selhání za poslední měsíc.', '["writing_tasks", "confession"]'),
('Nosit reminder celý den', 'Nosit poznámku "I am owned"', 'mental', 'marking', 'medium', 2, 'medium', 1440, 'Nosit poznámku v kapse celý den jako reminder.', '["marking", "ownership"]'),
('Meditation on ownership 1 hour', 'Hodina meditace o vlastnictví', 'mental', 'meditation', 'medium', 2, 'medium', 60, 'Klečící pozice před fotkou dominy, meditace hodinu.', '["meditation", "worship"]'),
('Video apology', 'Nahrát video omluvy za selhání', 'mental', 'video', 'medium', 2, 'medium', 15, 'Nahrát 5min video omluvy za konkrétní selhání.', '["video_tasks", "apology"]'),
('Napsat 1000 slov o submissi', 'Esej o submissive identity', 'mental', 'writing', 'medium', 2, 'medium', 90, 'Napsat 1000 slov o své submissive identitě.', '["writing_tasks"]'),
('Opakovat 300x affirmace', '"I exist to serve"', 'mental', 'affirmations', 'medium', 2, 'medium', 90, 'Opakovat 300x "I exist to serve my Domina".', '["affirmations", "mantra"]');

-- ============================================================================
-- FITNESS TASKS (40/150) - Weight, Cardio, Strength, Flexibility, Diet
-- ============================================================================

-- Weight Management (8/30)
INSERT INTO task_library (title, description, category, subcategory, difficulty, level_required, bdsm_intensity, duration_minutes, instructions) VALUES
('Denní vážení ráno', 'Vážit se každý den', 'fitness', 'weight', 'trivial', 1, 'none', 5, 'Každé ráno se vážit a zapisovat váhu.'),
('Foto progress týdně', 'Týdenní progress foto', 'fitness', 'weight', 'easy', 1, 'none', 10, 'Každý týden vyfotit tělo ve spodním prádle.'),
('Měření těla měsíčně', 'Měřit obvody těla', 'fitness', 'measurements', 'easy', 1, 'none', 15, 'Každý měsíc změřit pas, boky, prsa, stehna.'),
('Udržovat target weight týden', 'Týden na target weight', 'fitness', 'weight', 'medium', 2, 'none', 10080, 'Celý týden udržet váhu v target rozmezí.'),
('Ztratit 1 kg za měsíc', 'Weight loss goal', 'fitness', 'weight', 'medium', 2, 'none', 43200, 'Ztratit 1 kg za měsíc zdravě.'),
('Calorie tracking týden', 'Denně trackovakat kalorie', 'fitness', 'diet', 'easy', 1, 'none', 140, 'Týden trackovat každý den kalorie v aplikaci.'),
('Udržet deficit 500 kcal denně (týden)', 'Kalorický deficit', 'fitness', 'diet', 'medium', 2, 'none', 10080, 'Týden udržet deficit 500 kcal denně.'),
('Progress report domině týdně', 'Týdenní fitness report', 'fitness', 'weight', 'easy', 1, 'none', 20, 'Každý týden report s váhou, fotem, měřením.');

-- Cardio (8/25)
INSERT INTO task_library (title, description, category, subcategory, difficulty, level_required, bdsm_intensity, duration_minutes, instructions) VALUES
('Běh 5 km', 'Běžet 5 kilometrů', 'fitness', 'cardio', 'easy', 1, 'none', 30, 'Běžet 5 km nebo walking pokud potřeba.'),
('30 minut HIIT', 'High intensity interval training', 'fitness', 'cardio', 'medium', 2, 'none', 30, '30 minut HIIT workout podle videa.'),
('10 000 kroků denně (týden)', 'Denně 10k kroků', 'fitness', 'cardio', 'easy', 1, 'none', 420, 'Týden každý den minimálně 10 000 kroků.'),
('Běh 10 km', 'Dlouhý běh', 'fitness', 'cardio', 'medium', 2, 'none', 60, 'Běžet 10 kilometrů.'),
('Cycling 30 minut', 'Kolo nebo spinning', 'fitness', 'cardio', 'easy', 1, 'none', 30, '30 minut cycling (kolo nebo spinning bike).'),
('Jump rope 15 minut', 'Švihadlo', 'fitness', 'cardio', 'easy', 1, 'none', 15, '15 minut skákání přes švihadlo.'),
('Stairs 20 minut', 'Běhání po schodech', 'fitness', 'cardio', 'medium', 2, 'none', 20, '20 minut běhání nahoru dolů po schodech.'),
('Swimming 30 minut', 'Plavání', 'fitness', 'cardio', 'easy', 1, 'none', 30, '30 minut plavání.');

-- Strength (8/30)
INSERT INTO task_library (title, description, category, subcategory, difficulty, level_required, bdsm_intensity, duration_minutes, instructions) VALUES
('100 dřepů', 'Squats', 'fitness', 'strength', 'easy', 1, 'none', 15, '100 dřepů, může být rozděleno.'),
('50 kliků', 'Push-ups', 'fitness', 'strength', 'easy', 1, 'none', 10, '50 kliků, správná forma.'),
('Plank 5 minut celkem', 'Plank hold', 'fitness', 'strength', 'easy', 1, 'none', 15, 'Plank celkem 5 minut, rozdělit na série.'),
('200 dřepů', 'Squats challenge', 'fitness', 'strength', 'medium', 2, 'none', 30, '200 dřepů během dne.'),
('100 kliků', 'Push-ups challenge', 'fitness', 'strength', 'medium', 2, 'none', 20, '100 kliků během dne.'),
('Wall sit 10 minut celkem', 'Wall sit hold', 'fitness', 'strength', 'medium', 2, 'none', 20, 'Wall sit celkem 10 minut, rozdělit.'),
('30 minut strength training', 'Posilovací trénink', 'fitness', 'strength', 'medium', 2, 'none', 30, '30 minut strength training s činkami nebo bodyweight.'),
('Leg day workout', 'Nohy workout', 'fitness', 'strength', 'medium', 2, 'none', 45, 'Kompletní leg day: dřepy, výpady, leg press.');

-- Flexibility (6/20)
INSERT INTO task_library (title, description, category, subcategory, difficulty, level_required, bdsm_intensity, duration_minutes, instructions) VALUES
('Strečink 15 minut', 'Protažení celého těla', 'fitness', 'flexibility', 'easy', 1, 'none', 15, '15 minut strečinku všech svalů.'),
('Jóga 30 minut', 'Jóga session', 'fitness', 'flexibility', 'easy', 1, 'none', 30, '30 minut jógy podle videa.'),
('Splits training 20 minut', 'Trénink na špagát', 'fitness', 'flexibility', 'medium', 2, 'none', 20, '20 minut trénink flexibility pro splits.'),
('Morning stretch routine (týden)', 'Ranní strečink týden', 'fitness', 'flexibility', 'easy', 1, 'none', 105, 'Týden každé ráno 15 minut strečinku.'),
('Jóga denně (týden)', 'Denní jóga', 'fitness', 'flexibility', 'medium', 2, 'none', 210, 'Týden každý den 30 minut jógy.'),
('Foam rolling 15 minut', 'Foam roller masáž', 'fitness', 'flexibility', 'easy', 1, 'none', 15, '15 minut foam rollingu na svaly.');

-- Diet (10/25)
INSERT INTO task_library (title, description, category, subcategory, difficulty, level_required, bdsm_intensity, duration_minutes, instructions) VALUES
('Žádné sladkosti (týden)', 'Týden bez cukru', 'fitness', 'diet', 'medium', 2, 'none', 10080, 'Týden bez sladkostí, cukr pouze z ovoce.'),
('Meal prep na 3 dny', 'Připravit jídla dopředu', 'fitness', 'diet', 'medium', 2, 'none', 120, 'Připravit zdravá jídla na 3 dny dopředu.'),
('Pít 3L vody denně (týden)', '3 litry vody denně', 'fitness', 'diet', 'easy', 1, 'none', 10080, 'Týden každý den minimálně 3L vody.'),
('Žádný alkohol (měsíc)', 'Měsíc bez alkoholu', 'fitness', 'diet', 'medium', 2, 'none', 43200, 'Měsíc žádný alkohol.'),
('Žádná káva (týden)', 'Týden bez kofeinu', 'fitness', 'diet', 'easy', 1, 'none', 10080, 'Týden bez kávy a kofeinu.'),
('Intermittent fasting (týden)', '16:8 fasting', 'fitness', 'diet', 'medium', 2, 'none', 10080, 'Týden intermittent fasting 16:8.'),
('Pouze domácí jídlo (týden)', 'Žádný fast food', 'fitness', 'diet', 'easy', 1, 'none', 10080, 'Týden pouze domácí jídlo, žádný fast food.'),
('Veggie only (3 dny)', '3 dny pouze zelenina', 'fitness', 'diet', 'medium', 2, 'none', 4320, '3 dny pouze zelenina a ovoce.'),
('Protein goal (týden)', 'Denně 100g proteinu', 'fitness', 'diet', 'medium', 2, 'none', 10080, 'Týden každý den minimálně 100g proteinu.'),
('Calorie limit 1500 kcal (3 dny)', 'Nízkokalorická dieta', 'fitness', 'diet', 'medium', 2, 'none', 4320, '3 dny max 1500 kcal denně.');

-- ============================================================================
-- PHYSICAL TASKS (15/50) - Posture, endurance challenges
-- ============================================================================

INSERT INTO task_library (title, description, category, subcategory, difficulty, level_required, bdsm_intensity, duration_minutes, instructions) VALUES
('Perfect posture celý den', 'Držení těla', 'physical', 'posture', 'easy', 1, 'none', 1440, 'Celý den udržovat perfektní posture - záda rovná, hlava nahoru.'),
('Koutování 30 minut', 'Stát v rohu', 'physical', 'endurance', 'easy', 1, 'soft', 30, 'Stát v rohu 30 minut, ruce na hlavě.'),
('Držet těžkou knihu 20 minut', 'Kniha nad hlavou', 'physical', 'endurance', 'medium', 2, 'soft', 20, 'Držet těžkou knihu nad hlavou 20 minut.'),
('Klečící pozice 1 hodina', 'Klečet hodinu', 'physical', 'endurance', 'medium', 2, 'soft', 60, 'Klečící pozice hodinu bez pohybu.'),
('Wall sit 30 minut celkem', 'Wall sit endurance', 'physical', 'endurance', 'medium', 2, 'none', 60, 'Wall sit celkem 30 minut, rozdělit na série.'),
('Plank 20 minut celkem', 'Plank endurance', 'physical', 'endurance', 'medium', 2, 'none', 40, 'Plank celkem 20 minut během dne.'),
('Stát celý den (mimo práci)', 'Žádné sezení', 'physical', 'endurance', 'medium', 2, 'soft', 960, 'Celý den doma pouze stát nebo klečet, nesedět.'),
('Burpees 100x', 'Burpees challenge', 'physical', 'fitness', 'medium', 2, 'none', 30, '100 burpees během dne.'),
('Cold shower denně (týden)', 'Studené sprchy', 'physical', 'endurance', 'medium', 2, 'none', 70, 'Týden každý den pouze studená sprcha.'),
('Barefoot celý den', 'Bosá celý den', 'physical', 'endurance', 'easy', 1, 'soft', 1440, 'Celý den bosá, i venku pokud možné.'),
('Sleep on floor (týden)', 'Spát na podlaze', 'physical', 'endurance', 'medium', 2, 'soft', 5040, 'Týden spát na podlaze, ne v posteli.'),
('Fasting 24 hodin', '24h bez jídla', 'physical', 'endurance', 'hard', 3, 'none', 1440, '24 hodin žádné jídlo, pouze voda.'),
('Mountain climbers 500x', 'Mountain climbers', 'physical', 'fitness', 'medium', 2, 'none', 30, '500 mountain climbers během dne.'),
('Носit heavy backpack celý den', 'Závaží celý den', 'physical', 'endurance', 'medium', 2, 'soft', 960, 'Nosit těžký batoh celý den doma.'),
('Ice bath 10 minut', 'Ledová koupel', 'physical', 'endurance', 'hard', 3, 'none', 10, '10 minut sedět v ledové lázni.');

-- ============================================================================
-- CREATIVE TASKS (10/30) - Speciální projekty
-- ============================================================================

INSERT INTO task_library (title, description, category, subcategory, difficulty, level_required, bdsm_intensity, duration_minutes, instructions) VALUES
('Vytvořit worship shrine', 'Vytvořit oltář pro dominu', 'creative', 'project', 'medium', 2, 'soft', 120, 'Vytvořit malý shrine s fotkou dominy, svíčkami, květinami.'),
('Napsat píseň o službě', 'Složit píseň', 'creative', 'writing', 'medium', 2, 'soft', 90, 'Napsat a složit píseň o poslušnosti a službě.'),
('Namalovat obraz pro dominu', 'Malba jako dar', 'creative', 'art', 'medium', 2, 'soft', 180, 'Namalovat obraz jako dar pro dominu.'),
('Vytvořit foto koláž', 'Koláž ze společných fotek', 'creative', 'project', 'easy', 1, 'soft', 60, 'Vytvořit koláž ze společných fotek.'),
('Napsat báseň', 'Báseň o submisi', 'creative', 'writing', 'easy', 1, 'soft', 45, 'Napsat báseň o své submissi.'),
('Vyzdobit místnost pro dominu', 'Speciální dekorace', 'creative', 'project', 'medium', 2, 'soft', 120, 'Vyzdobit místnost pro speciální příležitost.'),
('Vytvořit scrapbook', 'Scrapbook o vztahu', 'creative', 'project', 'medium', 2, 'soft', 240, 'Vytvořit scrapbook o vztahu a dynamice.'),
('Upéct dort pro dominu', 'Dort jako překvapení', 'creative', 'cooking', 'easy', 1, 'none', 90, 'Upéct speciální dort pro dominu.'),
('Vytvořit playlist', 'Playlist pro dominu', 'creative', 'project', 'trivial', 1, 'soft', 30, 'Vytvořit playlist písní pro dominu.'),
('Napsat krátký příběh', 'Erotický příběh o D/s', 'creative', 'writing', 'medium', 2, 'soft', 120, 'Napsat krátký erotický příběh o D/s dynamice.');

-- ============================================================================
-- FEMININE POWER TASKS (20/70) - Pro dominu - oblečení, make-up, styling
-- ============================================================================

-- Level 1-2 (7/20)
INSERT INTO task_library (title, description, category, subcategory, difficulty, level_required, bdsm_intensity, duration_minutes, instructions) VALUES
('Denní make-up', 'Každý den se nalíčit', 'feminine_power', 'makeup', 'trivial', 1, 'none', 15, 'Každý den základní make-up - foundation, řasenka, rtěnka.'),
('Nosit šaty/sukně celý den', 'Pouze ženské oblečení', 'feminine_power', 'clothing', 'easy', 1, 'none', 1440, 'Celý den nosit šaty nebo sukni, ne kalhoty.'),
('Upravit nehty', 'Manikúra', 'feminine_power', 'grooming', 'trivial', 1, 'none', 30, 'Upravit nehty, nalakovat nebo gel lak.'),
('Nosit podpatky doma (3 hodiny)', 'High heels trénink', 'feminine_power', 'shoes', 'easy', 1, 'none', 180, '3 hodiny doma chodit v podpatcích.'),
('Udělat si účes', 'Stylovat vlasy', 'feminine_power', 'hair', 'trivial', 1, 'none', 20, 'Stylovat vlasy - lokny, drdol, copánky.'),
('Nosit make-up celý týden', 'Denní make-up', 'feminine_power', 'makeup', 'easy', 1, 'none', 105, 'Týden každý den se nalíčit.'),
('Nosit spodní prádlo set', 'Matching underwear', 'feminine_power', 'lingerie', 'trivial', 1, 'soft', 1440, 'Celý den nosit matching spodní prádlo set.');

-- Level 3-4 (7/30)
INSERT INTO task_library (title, description, category, subcategory, difficulty, level_required, bdsm_intensity, duration_minutes, instructions) VALUES
('Full make-up look', 'Kompletní večerní make-up', 'feminine_power', 'makeup', 'medium', 3, 'none', 45, 'Kompletní večerní make-up - oči, tváře, rty.'),
('Nosit podpatky celý den', 'High heels non-stop', 'feminine_power', 'shoes', 'medium', 3, 'none', 960, 'Celý den (mimo spánku) chodit v podpatcích.'),
('Professional styling', 'Profesionální styling vlasů', 'feminine_power', 'hair', 'medium', 3, 'none', 60, 'Profesionální styling vlasů - foukání, žehlička, lokny.'),
('Nosit korzet celý den', 'Waist training', 'feminine_power', 'clothing', 'medium', 3, 'soft', 960, 'Celý den nosit korzet.'),
('Full feminine outfit', 'Kompletní ženský outfit', 'feminine_power', 'clothing', 'medium', 3, 'none', 1440, 'Celý den kompletní ženský outfit - šaty, podpatky, make-up, šperky.'),
('Gel lak na nehty', 'Profesionální manikúra', 'feminine_power', 'grooming', 'easy', 3, 'none', 60, 'Udělat si nebo nechat udělat gel lak manikúru.'),
('Nosit luxusní spodní prádlo týden', 'Denně sexy lingerie', 'feminine_power', 'lingerie', 'medium', 3, 'soft', 10080, 'Týden každý den nosit luxusní sexy spodní prádlo.');

-- Level 5 (6/20)
INSERT INTO task_library (title, description, category, subcategory, difficulty, level_required, bdsm_intensity, duration_minutes, instructions) VALUES
('Dominatrix look', 'Kompletní dominatrix styling', 'feminine_power', 'styling', 'hard', 5, 'hard', 120, 'Kompletní dominatrix look - latex/leather, make-up, boty, attitude.'),
('Runway walk practice', 'Trénovat modelku chůzi', 'feminine_power', 'movement', 'medium', 5, 'none', 60, 'Trénovat runway walk v podpatcích.'),
('Professional photo shoot', 'Fotosession jako domina', 'feminine_power', 'photo', 'hard', 5, 'medium', 180, 'Profesionální fotosession v dominatrix stylu.'),
('Nosit latex/leather celý den', 'Full fetish outfit', 'feminine_power', 'clothing', 'hard', 5, 'hard', 960, 'Celý den nosit latex nebo leather outfit.'),
('Dramatic eye make-up', 'Dramatický make-up očí', 'feminine_power', 'makeup', 'medium', 5, 'none', 45, 'Dramatický make-up očí - smokey eyes, linery, řasy.'),
('Power posing practice', 'Trénink dominantních pozic', 'feminine_power', 'movement', 'medium', 5, 'medium', 30, 'Trénovat dominantní pózy a držení těla.');

-- ============================================================================
-- HOTOVO - Part 2 (105 úkolů)
-- Total: Part 1 (90) + Part 2 (105) = 195 úkolů
-- ============================================================================
