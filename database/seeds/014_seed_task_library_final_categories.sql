-- =====================================================
-- TASK LIBRARY - FINAL CATEGORIES (45 tasks)
-- =====================================================
-- Physical (15), Creative (20), Feminine Power (10)
-- This completes all 720 tasks

USE klaudie;

-- PHYSICAL - BODY MODIFICATION & GROOMING (15 tasks)
INSERT INTO task_library (title, description, category, subcategory, difficulty, level_required, bdsm_intensity, duration_minutes, instructions) VALUES
('Oholit celé tělo', 'Kompletní oholení celého těla', 'physical', 'grooming', 'easy', 1, 'none', 45, 'Důkladné oholení nohou, rukou, intimních partií, hrudí.'),
('Depilace nohou', 'Depilovat nohy voskem nebo krémem', 'physical', 'grooming', 'easy', 1, 'none', 30, 'Hladká kůže bez chloupků.'),
('Brazilská depilace', 'Profesionální brazilská depilace', 'physical', 'grooming', 'medium', 2, 'none', 60, 'Kompletní odstranění intimních chloupků.'),
('Full body waxing', 'Celotělový waxing', 'physical', 'grooming', 'medium', 2, 'none', 90, 'Profesionální waxing celého těla.'),
('Udržovat holé tělo měsíc', 'Celý měsíc udržovat tělo bez chloupků', 'physical', 'grooming', 'medium', 2, 'none', 1440, 'Pravidelné oholování/depilace po celý měsíc.'),
('Laserová epilace session', 'Session laserové epilace', 'physical', 'grooming', 'medium', 3, 'none', 90, 'Profesionální permanentní odstranění chloupků.'),
('Manikúra a pedikúra', 'Profesionální manikúra a pedikúra', 'physical', 'grooming', 'easy', 1, 'none', 90, 'Péče o nehty rukou a nohou.'),
('Gelové nehty aplikace', 'Nechat si udělat gelové nehty', 'physical', 'grooming', 'easy', 2, 'none', 120, 'Profesionální gelové nehty.'),
('Kosmetické ošetření pleti', 'Profesionální ošetření pleti', 'physical', 'grooming', 'medium', 2, 'none', 90, 'Hloubkové čištění, maska, péče.'),
('Permanentní makeup', 'Nechat si udělat permanentní makeup', 'physical', 'grooming', 'hard', 3, 'none', 180, 'Obočí, linky, rty - permanentní.'),
('Tetování dle výběru Dominy', 'Nechat si udělat tetování', 'physical', 'body_modification', 'hard', 4, 'none', 180, 'Tetování vybranší Dominou, trvalá změna.'),
('Piercing dle výběru', 'Nechat si udělat piercing', 'physical', 'body_modification', 'hard', 4, 'none', 60, 'Piercing na místě vybraném Dominou.'),
('Intimní piercing', 'Nechat si udělat intimní piercing', 'physical', 'body_modification', 'extreme', 5, 'none', 90, 'Piercing intimních partií.'),
('Trvalé označení', 'Trvalé označení vlastnictví', 'physical', 'body_modification', 'extreme', 5, 'none', 180, 'Tetování nebo brand jako značka vlastnictví.'),
('Permanent chastity consideration', 'Konzultace permanentní chastity', 'physical', 'body_modification', 'extreme', 5, 'none', 120, 'Diskuse a plánování permanentního řešení.'),

-- CREATIVE - ART & EXPRESSION (20 tasks)
('Nakreslit obrázek pro Dominu', 'Vytvořit kresbu jako dar', 'creative', 'art', 'easy', 1, 'none', 60, 'Nakreslit obrázek tužkou nebo barvami.'),
('Napsat báseň pro Dominu', 'Složit báseň vyjadřující oddanost', 'creative', 'writing', 'easy', 1, 'none', 30, 'Poezie vyjadřující city a oddanost.'),
('Vytvořit koláž', 'Vytvořit uměleckou koláž', 'creative', 'art', 'easy', 2, 'none', 90, 'Koláž z fotek, magazínů, různých materiálů.'),
('Malovat obraz', 'Namalovat obraz akrylem nebo olejem', 'creative', 'art', 'medium', 2, 'none', 180, 'Kompletní obraz na plátně.'),
('Vytvořit scrapbook', 'Vytvořit scrapbook vztahu', 'creative', 'crafts', 'medium', 2, 'none', 240, 'Fotky, vzpomínky, dekorace - osobní kniha.'),
('Vyřezat sochu', 'Vyřezat dřevěnou sochu', 'creative', 'art', 'hard', 3, 'none', 360, 'Vyřezávání ze dřeva, vytvořit sochu.'),
('Vytvořit šperky', 'Vytvořit ručně vyrobené šperky', 'creative', 'crafts', 'medium', 2, 'none', 180, 'Náhrdelník, náramek - ručně vyrobené.'),
('Složit hudbu', 'Složit hudební skladbu', 'creative', 'music', 'hard', 3, 'none', 240, 'Napsat melodii, text, nahrát.'),
('Naučit se hrát na nástroj', 'Začít se učit na hudební nástroj', 'creative', 'music', 'medium', 2, 'none', 480, 'Vybrat nástroj, začít pravidelně cvičit.'),
('Fotografický projekt', 'Vytvořit fotografickou sérii', 'creative', 'photography', 'medium', 2, 'none', 300, '20+ fotek na jedno téma, vyprávět příběh.'),
('Video montáž vytvořit', 'Vytvořit video montáž', 'creative', 'video', 'medium', 3, 'none', 240, 'Sestříhat video z fotek a klipů.'),
('Vytvořit komiks', 'Nakreslit krátký komiks', 'creative', 'art', 'hard', 3, 'none', 480, 'Příběh vyprávěný komiksem.'),
('Keramika vytvořit', 'Vytvořit keramický objekt', 'creative', 'crafts', 'medium', 2, 'none', 180, 'Hrnčířský kruh nebo ruční formování.'),
('Šít oblečení', 'Ušít kus oblečení', 'creative', 'crafts', 'hard', 3, 'none', 360, 'Navrhnout a ušít oblečení.'),
('Háčkovat/plést dárek', 'Uháčkovat nebo uplést dárek', 'creative', 'crafts', 'medium', 2, 'none', 480, 'Šála, čepice nebo jiný předmět.'),
('Vytvořit blog', 'Založit a psát blog', 'creative', 'writing', 'medium', 2, 'none', 300, 'Vytvořit blog, napsat 5+ článků.'),
('Napsat povídku 5000 slov', 'Napsat kratší povídku', 'creative', 'writing', 'hard', 3, 'none', 360, 'Kompletní povídka s příběhem.'),
('Naučit se kaligrafii', 'Zvládnout základy kaligrafie', 'creative', 'art', 'medium', 2, 'none', 240, 'Krásné písmo, cvičit různé styly.'),
('Origami série', 'Vytvořit 20 origami modelů', 'creative', 'crafts', 'easy', 2, 'none', 180, 'Skládat papír, různé modely.'),
('Vytvořit umělecké dílo Domině', 'Velký creative projekt pro Dominu', 'creative', 'art', 'hard', 4, 'none', 720, 'Rozsáhlý umělecký projekt jako vyjádření oddanosti.'),

-- FEMININE POWER - EMPOWERMENT (10 tasks)
('Masáž celého těla Dominy', 'Profesionální masáž celého těla 60 minut', 'feminine_power', 'empowerment', 'easy', 2, 'none', 60, 'Kvalitní masáž s olejem, relaxační.'),
('Spa den pro Dominu', 'Organizovat kompletní spa den doma', 'feminine_power', 'empowerment', 'medium', 2, 'none', 240, 'Koupel, masáž, maska, manikúra - kompletní péče.'),
('Luxusní večeře připravit', 'Připravit luxusní vícechochodvou večeři', 'feminine_power', 'empowerment', 'medium', 3, 'none', 180, 'Kvalitní ingredience, krásná servírování, svíčky.'),
('Romantický večer zorganizovat', 'Připravit kompletní romantický večer', 'feminine_power', 'empowerment', 'medium', 2, 'none', 240, 'Večeře, svíčky, hudba, atmosféra - vše připravené.'),
('Shopping day asistence', 'Doprovázet Dominu na nákupech celý den', 'feminine_power', 'empowerment', 'easy', 2, 'none', 300, 'Nosit tašky, radit, platit, sloužit.'),
('Fotografická session', 'Profesionální foto session pro Dominu', 'feminine_power', 'empowerment', 'medium', 3, 'none', 180, 'Najmout fotografa nebo fotit sám, krásné fotky.'),
('Víkendový výlet zorganizovat', 'Naplánovat a zorganizovat víkendový výlet', 'feminine_power', 'empowerment', 'hard', 3, 'none', 480, 'Vše naplánovat a zaplatit, Domina si jen užívá.'),
('Wellness víkend darovat', 'Darovat wellness pobyt', 'feminine_power', 'empowerment', 'hard', 4, 'none', 2880, 'Zaplatit a zorganizovat wellness víkend.'),
('Překvapení den', 'Celý den plný překvapení pro Dominu', 'feminine_power', 'empowerment', 'medium', 3, 'none', 720, 'Sérii překvapení po celý den - dárky, aktivity, péče.'),
('Uctívání bohyně rituál', 'Slavnostní rituál uctívání Dominy jako bohyně', 'feminine_power', 'empowerment', 'medium', 3, 'none', 90, 'Připravit oltář, svíčky, dary, rituál velebení její moci.');
