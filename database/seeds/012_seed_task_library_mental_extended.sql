-- =====================================================
-- TASK LIBRARY - MENTAL EXTENDED (40 tasks)
-- =====================================================
-- This seed adds remaining Mental tasks to reach 60 total
-- Categories: reading, writing, learning, meditation, personal_development

USE klaudie;

-- MENTAL - READING (10 tasks)
INSERT INTO task_library (title, description, category, subcategory, difficulty, level_required, bdsm_intensity, duration_minutes, instructions) VALUES
('Číst 30 minut', 'Číst knihu nebo článek 30 minut', 'mental', 'reading', 'trivial', 1, 'none', 30, 'Vybrat vhodnou literaturu, číst soustředěně.'),
('Přečíst jeden článek denně', 'Číst jeden odborný/vzdělávací článek', 'mental', 'reading', 'trivial', 1, 'none', 20, 'Najít a přečíst kvalitní článek o zvoleném tématu.'),
('Číst 1 hodinu denně týden', 'Každý den číst jednu hodinu', 'mental', 'reading', 'easy', 1, 'none', 420, 'Pravidelné čtení každý den po dobu týdne.'),
('Přečíst celou knihu', 'Dokončit jednu knihu od začátku do konce', 'mental', 'reading', 'medium', 2, 'none', 600, 'Vybrat knihu, naplánovat čtení, dokončit.'),
('Přečíst 3 knihy za měsíc', 'Přečíst tři knihy během měsíce', 'mental', 'reading', 'medium', 2, 'none', 1800, 'Naplánovat čtení, dodržovat tempo, dokončit tři knihy.'),
('Číst odbornou literaturu', 'Přečíst odbornou knihu z oboru', 'mental', 'reading', 'medium', 2, 'none', 480, 'Vybrat náročnější odbornou literaturu, pochopit obsah.'),
('Studium nové oblasti', 'Přečíst základní literaturu z nové oblasti', 'mental', 'reading', 'hard', 3, 'none', 900, 'Vybrat novou oblast, najít doporučenou literaturu, studovat.'),
('Přečíst klasickou literaturu', 'Přečíst dílo klasické literatury', 'mental', 'reading', 'hard', 3, 'none', 600, 'Vybrat klasické dílo, přečíst a pochopit kontext.'),
('Book club preparation', 'Přečíst knihu a připravit diskusi', 'mental', 'reading', 'hard', 3, 'none', 480, 'Přečíst knihu, připravit poznámky pro diskusi.'),
('Akademická četba', 'Přečíst akademický text nebo studii', 'mental', 'reading', 'extreme', 4, 'none', 360, 'Náročný akademický text, pochopit metodologii a závěry.'),

-- MENTAL - WRITING (10 tasks)
('Napsat deník záznam', 'Napsat denní záznam do deníku', 'mental', 'writing', 'trivial', 1, 'none', 15, 'Reflektovat den, zapsat myšlenky a pocity.'),
('Napsat dopis Domině', 'Napsat osobní dopis Domině', 'mental', 'writing', 'easy', 1, 'none', 30, 'Vyjádřit vděčnost, pocity, myšlenky v dopise.'),
('Napsat 500 slov esej', 'Napsat esej na zadané téma 500 slov', 'mental', 'writing', 'easy', 2, 'none', 45, 'Strukturovaná esej s úvodem, argumenty, závěrem.'),
('Denní journaling týden', 'Vést deník každý den týden', 'mental', 'writing', 'easy', 1, 'none', 105, 'Každý den zapisovat myšlenky, reflektovat.'),
('Napsat 1000 slov článek', 'Napsat článek o 1000 slovech', 'mental', 'writing', 'medium', 2, 'none', 90, 'Vybrat téma, strukturovat, napsat kvalitní článek.'),
('Kreativní psaní - povídka', 'Napsat krátkou povídku', 'mental', 'writing', 'medium', 2, 'none', 120, 'Vytvořit příběh s postavami, dějem, pointou.'),
('Napsat reflexi vztahu', 'Napsat hlubokou reflexi D/s dynamiky', 'mental', 'writing', 'medium', 2, 'none', 60, 'Reflektovat vztah, dynamiku, co funguje, co ne.'),
('Blog post vytvoření', 'Napsat a strukturovat blog post', 'mental', 'writing', 'hard', 3, 'none', 120, 'Téma, research, psaní, editace, formátování.'),
('Napsat 3000 slov práci', 'Napsat rozsáhlou práci 3000 slov', 'mental', 'writing', 'hard', 3, 'none', 240, 'Výzkumná práce s prameny, strukturou, argumentací.'),
('Vytvořit e-book', 'Napsat krátký e-book (10000+ slov)', 'mental', 'writing', 'extreme', 4, 'none', 1200, 'Kompletní e-book s kapitolami, strukturou, editací.'),

-- MENTAL - LEARNING (10 tasks)
('Sledovat vzdělávací video', 'Shlédnout a pochopit vzdělávací obsah', 'mental', 'learning', 'trivial', 1, 'none', 30, 'TED talk, kurz, tutorial - aktivně sledovat a učit se.'),
('Projít online kurz lekci', 'Dokončit jednu lekci online kurzu', 'mental', 'learning', 'easy', 1, 'none', 60, 'Vybrat kurz, projít lekci, udělat poznámky.'),
('Naučit se 20 nových slov', 'Naučit se 20 slov v cizím jazyce', 'mental', 'learning', 'easy', 1, 'none', 45, 'Používat flashcards nebo aplikaci, opakovat.'),
('Dokončit mini online kurz', 'Dokončit krátký online kurz (5-10 lekcí)', 'mental', 'learning', 'medium', 2, 'none', 300, 'Kompletní projití kurzu včetně cvičení.'),
('Naučit se novou dovednost', 'Začít se učit novou praktickou dovednost', 'mental', 'learning', 'medium', 2, 'none', 180, 'Vybrat dovednost, najít zdroje, začít praktikovat.'),
('Jazykový kurz týden', 'Týden intenzivní ho studia jazyka', 'mental', 'learning', 'medium', 2, 'none', 420, 'Každý den studovat jazyk 1 hodinu.'),
('Dokončit full online kurz', 'Dokončit kompletní online kurz', 'mental', 'learning', 'hard', 3, 'none', 1200, 'Projít celý kurz od začátku do konce, udělat testy.'),
('Certifikace získání', 'Získat certifikaci v oboru', 'mental', 'learning', 'hard', 3, 'none', 2400, 'Projít kurz, naučit se materiál, složit zkoušku.'),
('Naučit se programovat základy', 'Zvládnout základy programování', 'mental', 'learning', 'hard', 3, 'none', 1800, 'Vybrat jazyk, projít tutorialy, napsat programy.'),
('Expertní level dovednost', 'Dosáhnout pokročilé úrovně v dovednosti', 'mental', 'learning', 'extreme', 5, 'none', 7200, 'Dlouhodobé studium a praxe pro zvládnutí na vysoké úrovni.'),

-- MENTAL - MEDITATION & MINDFULNESS (5 tasks)
('Meditace 10 minut', 'Meditovat 10 minut v klidu', 'mental', 'meditation', 'trivial', 1, 'none', 10, 'Najít klidné místo, sedět, soustředit se na dech.'),
('Ranní meditace týden', 'Každé ráno meditovat 15 minut', 'mental', 'meditation', 'easy', 1, 'none', 105, 'Pravidelná ranní praxe po dobu týdne.'),
('Mindfulness walking', 'Procházka s plnou pozorností 30 minut', 'mental', 'meditation', 'easy', 1, 'none', 30, 'Chodit pomalu, vnímat každý krok, okolí, dech.'),
('Meditace 30 minut denně', 'Hluboká meditace půl hodiny', 'mental', 'meditation', 'medium', 2, 'none', 30, 'Delší meditační session, hluboké soustředění.'),
('Meditační retreat den', 'Celodenní meditační praxe', 'mental', 'meditation', 'hard', 3, 'none', 480, 'Celý den věnovaný meditaci a tichu.'),

-- MENTAL - PERSONAL DEVELOPMENT (5 tasks)
('Stanovit osobní cíle', 'Definovat a zapsat osobní cíle', 'mental', 'personal_development', 'easy', 1, 'none', 30, 'SMART cíle - specifické, měřitelné, dosažitelné.'),
('Týdenní sebereflexe', 'Provést hlubokou sebereflexe týdne', 'mental', 'personal_development', 'easy', 2, 'none', 45, 'Analyzovat týden - úspěchy, selhání, poučení.'),
('Pracovat na špatném návyku', 'Identifikovat a začít měnit špatný návyk', 'mental', 'personal_development', 'medium', 2, 'none', 1440, 'Vybrat návyk, naplánovat změnu, začít praktikovat.'),
('Vytvořit osobní růstový plán', 'Naplánovat osobní rozvoj na 3 měsíce', 'mental', 'personal_development', 'medium', 2, 'none', 120, 'Analýza současnosti, cíle, kroky, timeline.'),
('30denní personal challenge', 'Dokončit 30denní výzvu osobního rozvoje', 'mental', 'personal_development', 'hard', 3, 'none', 1440, 'Vybrat výzvu, dodržovat každý den, dokumentovat.');
