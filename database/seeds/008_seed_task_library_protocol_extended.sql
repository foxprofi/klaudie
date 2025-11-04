-- =====================================================
-- TASK LIBRARY - PROTOCOL EXTENDED (40 tasks)
-- =====================================================
-- This seed adds remaining Protocol tasks to reach 60 total
-- Categories: rituals, positions, addressing, rules, service

USE klaudie;

-- PROTOCOL - RITUALS (10 tasks)
INSERT INTO task_library (title, description, category, subcategory, difficulty, level_required, bdsm_intensity, duration_minutes, instructions) VALUES
('Ranní rituál pozdravení', 'Vykonat ranní rituál pozdravení Dominy', 'protocol', 'rituals', 'trivial', 1, 'soft', 5, 'Po probuzení se poklonit, políbit ruku/nohu, popřát hezký den.'),
('Večerní rituál díků', 'Vykonat večerní rituál poděkování za den', 'protocol', 'rituals', 'trivial', 1, 'soft', 5, 'Před spaním poděkovat za den, políbit ruku/nohu, popřát dobrou noc.'),
('Rituál před jídlem', 'Vykonat rituál před společným jídlem', 'protocol', 'trivial', 'rituals', 1, 'soft', 3, 'Poklonit se, poděkovat za jídlo, vyčkat na povolení začít jíst.'),
('Rituál přivítání Dominy', 'Přivítat Dominu při příchodu domů podle protokolu', 'protocol', 'rituals', 'easy', 1, 'soft', 10, 'Klečet u dveří, přivítat, nabídnout pomoc s věcmi, políbit ruku.'),
('Rituál rozloučení', 'Rozloučit se s Dominou při odchodu podle protokolu', 'protocol', 'rituals', 'easy', 1, 'soft', 5, 'Poklonit se, popřát hezký den, políbit ruku, vyčkat u dveří.'),
('Týdenní rituál hodnocení', 'Projít s Dominou týdenní hodnocení výkonu', 'protocol', 'rituals', 'medium', 2, 'soft', 30, 'Připravit přehled splněných úkolů, přijmout hodnocení, poděkovat.'),
('Rituál omluvy', 'Vykonat formální rituál omluvy za selhání', 'protocol', 'rituals', 'medium', 2, 'medium', 15, 'Klečet, omluvit se formálně, políbit nohy, přijmout trest.'),
('Měsíční rituál odevzdání', 'Vykonat slavnostní rituál odevzdání se Domině', 'protocol', 'rituals', 'hard', 3, 'medium', 60, 'Slavnostně obnovit závazek služby, odevzdat se, přijmout příkazy.'),
('Rituál přípravy prostoru', 'Připravit prostor pro BDSM session podle protokolu', 'protocol', 'rituals', 'hard', 3, 'medium', 30, 'Připravit náčiní, svíčky, prostírání, klečet v očekávání.'),
('Ceremonní rituál odvážení', 'Vykonat formální ceremonii odvážení se Domině', 'protocol', 'rituals', 'extreme', 4, 'intense', 90, 'Slavnostní obřad včetně přísah, symbolů, formálních aktů poslušnosti.'),

-- PROTOCOL - POSITIONS (10 tasks)
('Nacvičit pozici klečení', 'Nacvičit správnou pozici klečení po dobu 15 minut', 'protocol', 'positions', 'trivial', 1, 'soft', 15, 'Klečet vzpřímeně, ruce na stehnech, pohled dolů, záda rovná.'),
('Nacvičit pozici stání', 'Nacvičit správnou pozici stání ve službě', 'protocol', 'positions', 'trivial', 1, 'soft', 15, 'Stát vzpřímeně, ruce za zády, pohled dolů, nohy u sebe.'),
('Pozice čekání', 'Vyčkat v předepsané pozici po dobu 20 minut', 'protocol', 'positions', 'easy', 1, 'soft', 20, 'Zaujmout pozici čekání, nezměnit ji bez povolení.'),
('Pozice prezentace', 'Nacvičit pozici prezentace sebe Domině', 'protocol', 'positions', 'easy', 2, 'medium', 15, 'Pozice pro inspekci - nehybně čekat na prohlídku Dominy.'),
('Série pozic na příkaz', 'Rychle zaujímat různé pozice na příkaz', 'protocol', 'positions', 'medium', 2, 'medium', 30, 'Trénink 5 různých pozic, zaujmout každou do 3 sekund.'),
('Dlouhé klečení', 'Klečet v pozici po dobu 45 minut', 'protocol', 'positions', 'medium', 2, 'medium', 45, 'Vydržet v pozici bez pohybu, pouze se svolením pohnout.'),
('Ponižující pozice', 'Zaujmout a udržet ponižující pozici 30 minut', 'protocol', 'positions', 'hard', 3, 'intense', 30, 'Např. čelem k zemi, ruce natažené vpřed, hýždě nahoře.'),
('Pozice nábytek', 'Sloužit jako nábytek po dobu 45 minut', 'protocol', 'positions', 'hard', 3, 'intense', 45, 'Např. stolička pro nohy, stolek, držák nápojů - nehybně.'),
('Extrémní pozice vytrvalosti', 'Udržet obtížnou pozici po dobu 60 minut', 'protocol', 'positions', 'extreme', 4, 'intense', 60, 'Velmi náročná pozice vyžadující vytrvalost a kontrolu.'),
('Bondage pozice', 'Setrvat ve svázané pozici po určenou dobu', 'protocol', 'positions', 'extreme', 4, 'intense', 90, 'Svázaný v předepsané pozici, vyčkat bez pohybu.'),

-- PROTOCOL - ADDRESSING & COMMUNICATION (8 tasks)
('Den bez používání "já"', 'Celý den mluvit o sobě ve třetí osobě', 'protocol', 'addressing', 'easy', 1, 'soft', 720, 'Místo "já" používat "tento servant" nebo jméno. Celý den.'),
('Správné oslovování', 'Používat pouze správné tituly a oslovení', 'protocol', 'addressing', 'easy', 1, 'soft', 1440, 'Paní, Domina, Mistress - podle preference. Nikdy křestním jménem.'),
('Komunikace očima dolu', 'Mluvit s Dominou pouze s očima dolu', 'protocol', 'addressing', 'medium', 2, 'medium', 480, 'Během komunikace nikdy nepohlížet do očí bez povolení.'),
('Žádání o povolení mluvit', 'Vždy požádat o povolení promluvit', 'protocol', 'addressing', 'medium', 2, 'medium', 1440, 'Před každým promluvením požádat o souhlas. Celý den.'),
('Den mlčení', 'Nemluvit celý den bez výslovného příkazu', 'protocol', 'addressing', 'hard', 3, 'intense', 1440, 'Mlčet celý den, mluvit jen na přímý příkaz nebo otázku.'),
('Formální komunikace', 'Používat pouze formální jazyk a protokol', 'protocol', 'addressing', 'hard', 3, 'medium', 1440, 'Formální oslovování, žádné nespisovné výrazy, úplná gramatika.'),
('Písemná komunikace pouze', 'Komunikovat s Dominou pouze písemně', 'protocol', 'addressing', 'extreme', 4, 'intense', 1440, 'Nemluvit nahlas, vše komunikovat psaním na papír nebo SMS.'),
('Protokol non-verbální komunikace', 'Komunikovat pouze gesty a signály', 'protocol', 'addressing', 'extreme', 5, 'intense', 480, 'Žádné slovo, pouze předem domluvená gesta.'),

-- PROTOCOL - SERVICE (8 tasks)
('Služba u stolu', 'Servírovat jídlo a pití podle protokolu', 'protocol', 'service', 'easy', 1, 'soft', 60, 'Připravit jídlo, naservírovat, stát po boku, doplňovat podle potřeby.'),
('Pomoc s oblékáním', 'Pomoci Domině s oblékáním podle protokolu', 'protocol', 'service', 'easy', 1, 'soft', 20, 'Připravit oblečení, pomoci obléknout, zapnout zip/knoflíky.'),
('Péče o obuv', 'Obout Dominu a svléknout boty podle protokolu', 'protocol', 'service', 'easy', 1, 'soft', 10, 'Klečet, nabídnout boty, pomoci obout, svléknout boty po příchodu.'),
('Příprava koupele', 'Připravit koupel pro Dominu podle požadavků', 'protocol', 'service', 'medium', 2, 'soft', 30, 'Připravit vodu správné teploty, pěnu, svíčky, ručníky.'),
('Masáž nohou', 'Poskytnout profesionální masáž nohou 30 minut', 'protocol', 'service', 'medium', 2, 'soft', 30, 'Masírovat chodidla a lýtka, používat olej nebo krém.'),
('Celotělová masáž', 'Poskytnout kvalitní celotělovou masáž', 'protocol', 'service', 'hard', 3, 'medium', 60, 'Profesionální masáž celého těla podle preferencí Dominy.'),
('Osobní péče Dominy', 'Poskytnout kompletní osobní péči', 'protocol', 'service', 'hard', 3, 'medium', 90, 'Koupel, mytí vlasů, masáž, péče o ruce/nohy, oblékání.'),
('24hodin služby non-stop', 'Být k dispozici nepřetržitě 24 hodin', 'protocol', 'service', 'extreme', 5, 'intense', 1440, 'Být neustále k dispozici pro jakýkoliv příkaz, spát u postele.'),

-- PROTOCOL - RULES & DISCIPLINE (4 tasks)
('Denní hlášení úkolů', 'Každý večer podat formální hlášení o splněných úkolech', 'protocol', 'rules', 'easy', 1, 'soft', 15, 'Shrnout splněné úkoly, ohodnotit vlastní výkon, požádat o hodnocení.'),
('Žádání o každé povolení', 'Žádat o povolení pro každou běžnou aktivitu', 'protocol', 'rules', 'medium', 2, 'medium', 1440, 'Jídlo, pití, toaleta, odpočinek - vše po žádosti o povolení.'),
('Pravidlo kontroly oblečení', 'Nechat Dominu schválit oblečení každý den', 'protocol', 'rules', 'medium', 2, 'medium', 1440, 'Ráno předložit 3 varianty oblečení, Domina vybere.'),
('Absolutní poslušnost 24h', 'Okamžitě plnit každý příkaz bez diskuze 24h', 'protocol', 'rules', 'extreme', 4, 'intense', 1440, 'Žádné otázky, žádné váhání, okamžité plnění příkazů.');
