BEGIN TRANSACTION;
CREATE TABLE administrateurs (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    login TEXT NOT NULL UNIQUE,
    empreinte TEXT NOT NULL
);
INSERT INTO "administrateurs" VALUES(1,'admin','scrypt:32768:8:1$eOAWOR8D3wTgie9j$f089efedb4113bdf1304b7fdf00278fb34941e5cdbce70a2bf54d9bb6abcf377321fc930a580ed20b69458b8252641e92773499fe5a40c06d0185dc00e90dc67');
CREATE TABLE categories (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nom TEXT NOT NULL UNIQUE,
    description TEXT
);
INSERT INTO "categories" VALUES(1,'Sculptures','Masques et statues traditionnels en bois noble.');
INSERT INTO "categories" VALUES(2,'Vannerie','Paniers, corbeilles et sacs tressés en raphia.');
INSERT INTO "categories" VALUES(3,'Textiles & Tissus','Tissus Ndop, pagnes tissés et tentures traditionnelles.');
INSERT INTO "categories" VALUES(4,'Bijouterie artisanale','Colliers, perles royales et bracelets en bronze.');
INSERT INTO "categories" VALUES(5,'Poterie & Céramique','Vases, cruches et objets décoratifs en terre cuite.');
CREATE TABLE commandes (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    client_nom TEXT NOT NULL,
    client_telephone TEXT NOT NULL,
    adresse TEXT NOT NULL,
    date TEXT NOT NULL,
    mode_paiement TEXT NOT NULL CHECK (mode_paiement IN ('Mobile Money', 'À la livraison')),
    statut TEXT NOT NULL DEFAULT 'reçue' CHECK (statut IN ('reçue', 'préparée', 'livrée', 'annulée')),
    total INTEGER NOT NULL CHECK (total >= 0)
);
INSERT INTO "commandes" VALUES(1,'Carine Tchoupo','677359183','Akwa, Douala','2026-09-26 21:53:45','Mobile Money','livrée',154280);
INSERT INTO "commandes" VALUES(2,'Aïcha Diallo','682910648','Omnisports, Yaoundé','2026-10-02 20:53:45','À la livraison','annulée',105428);
INSERT INTO "commandes" VALUES(3,'Carine Tchoupo','673743069','Bastos, Yaoundé','2026-09-21 11:53:45','À la livraison','reçue',370525);
INSERT INTO "commandes" VALUES(4,'Therese Ngo','675128434','Bastos, Yaoundé','2026-10-12 11:53:45','Mobile Money','livrée',88843);
INSERT INTO "commandes" VALUES(5,'Therese Ngo','699461113','Up Station, Bamenda','2026-08-30 08:53:45','À la livraison','livrée',231872);
INSERT INTO "commandes" VALUES(6,'Therese Ngo','688095773','Centre-ville, Foumban','2026-10-08 12:53:45','À la livraison','préparée',88321);
INSERT INTO "commandes" VALUES(7,'Samuel Eto''o','689740364','Up Station, Bamenda','2026-09-09 00:53:45','Mobile Money','reçue',72383);
INSERT INTO "commandes" VALUES(8,'Ibrahim Bello','692447169','Omnisports, Yaoundé','2026-09-07 23:53:45','Mobile Money','livrée',76127);
INSERT INTO "commandes" VALUES(9,'Félix Mbarga','681888253','Omnisports, Yaoundé','2026-09-20 20:53:45','Mobile Money','livrée',91845);
INSERT INTO "commandes" VALUES(10,'Béatrice Ekane','674703737','Omnisports, Yaoundé','2026-09-05 14:53:45','À la livraison','préparée',43636);
INSERT INTO "commandes" VALUES(11,'Samuel Eto''o','673129379','Akwa, Douala','2026-09-04 19:53:45','À la livraison','livrée',65441);
INSERT INTO "commandes" VALUES(12,'Béatrice Ekane','679571375','Omnisports, Yaoundé','2026-10-09 05:53:45','À la livraison','reçue',75987);
INSERT INTO "commandes" VALUES(13,'Carine Tchoupo','671918148','Bonapriso, Douala','2026-10-01 21:53:45','Mobile Money','reçue',178448);
INSERT INTO "commandes" VALUES(14,'Aïcha Diallo','699873085','Up Station, Bamenda','2026-09-10 00:53:45','Mobile Money','livrée',72887);
INSERT INTO "commandes" VALUES(15,'Carine Tchoupo','678008971','Bastos, Yaoundé','2026-09-19 10:53:45','À la livraison','livrée',95961);
INSERT INTO "commandes" VALUES(16,'Aïcha Diallo','672458221','Up Station, Bamenda','2026-09-07 22:53:45','À la livraison','reçue',98427);
INSERT INTO "commandes" VALUES(17,'Ibrahim Bello','690524499','Centre-ville, Foumban','2026-09-27 06:53:45','À la livraison','annulée',69635);
INSERT INTO "commandes" VALUES(18,'Marc Atangana','679138489','Bastos, Yaoundé','2026-10-02 12:53:45','À la livraison','préparée',143885);
INSERT INTO "commandes" VALUES(19,'Samuel Eto''o','670118973','Bastos, Yaoundé','2026-10-13 10:53:45','À la livraison','reçue',100321);
INSERT INTO "commandes" VALUES(20,'Marc Atangana','688306972','Bonapriso, Douala','2026-10-17 17:53:45','Mobile Money','livrée',107765);
INSERT INTO "commandes" VALUES(21,'Therese Ngo','692886360','Akwa, Douala','2026-10-06 09:53:45','À la livraison','livrée',115365);
INSERT INTO "commandes" VALUES(22,'Samuel Eto''o','676018345','Centre-ville, Foumban','2026-10-23 16:53:45','À la livraison','livrée',121213);
INSERT INTO "commandes" VALUES(23,'Therese Ngo','697400099','Omnisports, Yaoundé','2026-09-16 15:53:45','Mobile Money','préparée',122992);
INSERT INTO "commandes" VALUES(24,'Félix Mbarga','692800844','Up Station, Bamenda','2026-09-15 06:53:45','Mobile Money','livrée',161386);
INSERT INTO "commandes" VALUES(25,'Félix Mbarga','681599334','Centre-ville, Foumban','2026-10-14 16:53:45','À la livraison','livrée',121030);
INSERT INTO "commandes" VALUES(26,'Samuel Eto''o','687445631','Up Station, Bamenda','2026-10-08 05:53:45','Mobile Money','préparée',139661);
INSERT INTO "commandes" VALUES(27,'Aïcha Diallo','694150945','Bastos, Yaoundé','2026-09-26 15:53:45','À la livraison','préparée',292496);
INSERT INTO "commandes" VALUES(28,'Marc Atangana','690653253','Up Station, Bamenda','2026-09-13 18:53:45','Mobile Money','préparée',174501);
INSERT INTO "commandes" VALUES(29,'Carine Tchoupo','685602414','Omnisports, Yaoundé','2026-09-23 03:53:45','Mobile Money','livrée',277813);
INSERT INTO "commandes" VALUES(30,'Aïcha Diallo','697461734','Akwa, Douala','2026-10-07 15:53:45','Mobile Money','livrée',39983);
INSERT INTO "commandes" VALUES(31,'Aïcha Diallo','685281230','Omnisports, Yaoundé','2026-10-21 02:53:45','Mobile Money','livrée',121360);
INSERT INTO "commandes" VALUES(32,'Samuel Eto''o','699952693','Bonapriso, Douala','2026-10-13 19:53:45','Mobile Money','reçue',76850);
INSERT INTO "commandes" VALUES(33,'Béatrice Ekane','692400191','Up Station, Bamenda','2026-09-30 01:53:45','À la livraison','annulée',181582);
INSERT INTO "commandes" VALUES(34,'Béatrice Ekane','685101835','Bastos, Yaoundé','2026-10-12 13:53:45','À la livraison','livrée',101206);
INSERT INTO "commandes" VALUES(35,'Ibrahim Bello','681269173','Bastos, Yaoundé','2026-10-21 23:53:45','Mobile Money','reçue',84595);
INSERT INTO "commandes" VALUES(36,'Aïcha Diallo','683920656','Omnisports, Yaoundé','2026-09-15 23:53:45','À la livraison','livrée',67014);
INSERT INTO "commandes" VALUES(37,'Samuel Eto''o','698747156','Up Station, Bamenda','2026-09-18 21:53:45','Mobile Money','annulée',139380);
INSERT INTO "commandes" VALUES(38,'Therese Ngo','686382262','Akwa, Douala','2026-09-11 19:53:45','À la livraison','reçue',122692);
INSERT INTO "commandes" VALUES(39,'Samuel Eto''o','683221125','Up Station, Bamenda','2026-10-01 03:53:45','Mobile Money','reçue',124971);
INSERT INTO "commandes" VALUES(40,'Carine Tchoupo','677102140','Omnisports, Yaoundé','2026-09-14 16:53:45','À la livraison','préparée',145802);
INSERT INTO "commandes" VALUES(41,'Samuel Eto''o','681742720','Akwa, Douala','2026-10-05 08:53:45','Mobile Money','livrée',72379);
INSERT INTO "commandes" VALUES(42,'Therese Ngo','674235273','Omnisports, Yaoundé','2026-10-06 09:53:45','Mobile Money','livrée',257997);
INSERT INTO "commandes" VALUES(43,'Aïcha Diallo','696098364','Akwa, Douala','2026-09-13 09:53:45','Mobile Money','annulée',152579);
INSERT INTO "commandes" VALUES(44,'Aïcha Diallo','693393915','Bastos, Yaoundé','2026-10-19 03:53:45','Mobile Money','livrée',190526);
INSERT INTO "commandes" VALUES(45,'Carine Tchoupo','670424535','Omnisports, Yaoundé','2026-10-16 21:53:45','Mobile Money','livrée',263060);
INSERT INTO "commandes" VALUES(46,'Ibrahim Bello','690666589','Up Station, Bamenda','2026-10-13 21:53:45','À la livraison','livrée',70831);
INSERT INTO "commandes" VALUES(47,'Béatrice Ekane','689120981','Up Station, Bamenda','2026-10-06 18:53:45','À la livraison','reçue',85082);
INSERT INTO "commandes" VALUES(48,'Ibrahim Bello','699538636','Up Station, Bamenda','2026-10-08 14:53:45','Mobile Money','livrée',95154);
INSERT INTO "commandes" VALUES(49,'Béatrice Ekane','688628622','Akwa, Douala','2026-10-08 21:53:45','À la livraison','livrée',107224);
INSERT INTO "commandes" VALUES(50,'Therese Ngo','680274569','Centre-ville, Foumban','2026-10-01 17:53:45','À la livraison','livrée',210224);
INSERT INTO "commandes" VALUES(51,'Ibrahim Bello','680288560','Bastos, Yaoundé','2026-09-08 09:53:45','Mobile Money','préparée',187916);
INSERT INTO "commandes" VALUES(52,'Ibrahim Bello','673373096','Akwa, Douala','2026-09-12 13:53:45','À la livraison','reçue',79237);
INSERT INTO "commandes" VALUES(53,'Samuel Eto''o','688567645','Bastos, Yaoundé','2026-10-08 10:53:45','À la livraison','reçue',115122);
INSERT INTO "commandes" VALUES(54,'Béatrice Ekane','681432194','Akwa, Douala','2026-08-28 14:53:45','À la livraison','reçue',38725);
INSERT INTO "commandes" VALUES(55,'Samuel Eto''o','675091113','Akwa, Douala','2026-10-16 00:53:45','À la livraison','reçue',121346);
INSERT INTO "commandes" VALUES(56,'Therese Ngo','696027956','Up Station, Bamenda','2026-09-18 20:53:45','À la livraison','préparée',232682);
INSERT INTO "commandes" VALUES(57,'Therese Ngo','690988801','Akwa, Douala','2026-09-11 03:53:45','Mobile Money','reçue',35010);
INSERT INTO "commandes" VALUES(58,'Félix Mbarga','685116395','Centre-ville, Foumban','2026-10-02 21:53:45','À la livraison','reçue',166449);
INSERT INTO "commandes" VALUES(59,'Therese Ngo','684265296','Bonapriso, Douala','2026-09-28 13:53:45','Mobile Money','annulée',23976);
INSERT INTO "commandes" VALUES(60,'Ibrahim Bello','684735544','Bonapriso, Douala','2026-09-24 04:53:45','À la livraison','livrée',93963);
CREATE TABLE lignes_commande (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    commande_id INTEGER NOT NULL,
    produit_id INTEGER NOT NULL,
    quantite INTEGER NOT NULL CHECK (quantite > 0),
    prix_unitaire INTEGER NOT NULL CHECK (prix_unitaire >= 0),
    FOREIGN KEY (commande_id) REFERENCES commandes (id) ON DELETE CASCADE,
    FOREIGN KEY (produit_id) REFERENCES produits (id) ON DELETE RESTRICT
);
INSERT INTO "lignes_commande" VALUES(1,1,10,3,42118);
INSERT INTO "lignes_commande" VALUES(2,1,11,2,13963);
INSERT INTO "lignes_commande" VALUES(3,2,8,2,16531);
INSERT INTO "lignes_commande" VALUES(4,2,35,3,24122);
INSERT INTO "lignes_commande" VALUES(5,3,17,3,38642);
INSERT INTO "lignes_commande" VALUES(6,3,33,2,24173);
INSERT INTO "lignes_commande" VALUES(7,3,12,3,25798);
INSERT INTO "lignes_commande" VALUES(8,3,7,3,42953);
INSERT INTO "lignes_commande" VALUES(9,4,2,2,19549);
INSERT INTO "lignes_commande" VALUES(10,4,8,1,16531);
INSERT INTO "lignes_commande" VALUES(11,4,24,1,33214);
INSERT INTO "lignes_commande" VALUES(12,5,9,2,30993);
INSERT INTO "lignes_commande" VALUES(13,5,31,3,17892);
INSERT INTO "lignes_commande" VALUES(14,5,36,3,29428);
INSERT INTO "lignes_commande" VALUES(15,5,11,2,13963);
INSERT INTO "lignes_commande" VALUES(16,6,24,1,33214);
INSERT INTO "lignes_commande" VALUES(17,6,29,1,14208);
INSERT INTO "lignes_commande" VALUES(18,6,34,1,7837);
INSERT INTO "lignes_commande" VALUES(19,6,8,2,16531);
INSERT INTO "lignes_commande" VALUES(20,7,4,2,9197);
INSERT INTO "lignes_commande" VALUES(21,7,15,1,27026);
INSERT INTO "lignes_commande" VALUES(22,7,5,3,5582);
INSERT INTO "lignes_commande" VALUES(23,7,3,1,10217);
INSERT INTO "lignes_commande" VALUES(24,8,37,1,12863);
INSERT INTO "lignes_commande" VALUES(25,8,31,1,17892);
INSERT INTO "lignes_commande" VALUES(26,8,16,1,20835);
INSERT INTO "lignes_commande" VALUES(27,8,27,3,8179);
INSERT INTO "lignes_commande" VALUES(28,9,7,1,42953);
INSERT INTO "lignes_commande" VALUES(29,9,4,1,9197);
INSERT INTO "lignes_commande" VALUES(30,9,26,1,17230);
INSERT INTO "lignes_commande" VALUES(31,9,22,1,22465);
INSERT INTO "lignes_commande" VALUES(32,10,29,1,14208);
INSERT INTO "lignes_commande" VALUES(33,10,36,1,29428);
INSERT INTO "lignes_commande" VALUES(34,11,4,1,9197);
INSERT INTO "lignes_commande" VALUES(35,11,11,2,13963);
INSERT INTO "lignes_commande" VALUES(36,11,25,2,14159);
INSERT INTO "lignes_commande" VALUES(37,12,14,3,9578);
INSERT INTO "lignes_commande" VALUES(38,12,4,3,9197);
INSERT INTO "lignes_commande" VALUES(39,12,38,1,19662);
INSERT INTO "lignes_commande" VALUES(40,13,6,1,17828);
INSERT INTO "lignes_commande" VALUES(41,13,12,3,25798);
INSERT INTO "lignes_commande" VALUES(42,13,5,1,5582);
INSERT INTO "lignes_commande" VALUES(43,13,39,2,38822);
INSERT INTO "lignes_commande" VALUES(44,14,38,2,19662);
INSERT INTO "lignes_commande" VALUES(45,14,37,2,12863);
INSERT INTO "lignes_commande" VALUES(46,14,34,1,7837);
INSERT INTO "lignes_commande" VALUES(47,15,1,3,10796);
INSERT INTO "lignes_commande" VALUES(48,15,30,3,21191);
INSERT INTO "lignes_commande" VALUES(49,16,5,2,5582);
INSERT INTO "lignes_commande" VALUES(50,16,16,1,20835);
INSERT INTO "lignes_commande" VALUES(51,16,24,2,33214);
INSERT INTO "lignes_commande" VALUES(52,17,9,1,30993);
INSERT INTO "lignes_commande" VALUES(53,17,17,1,38642);
INSERT INTO "lignes_commande" VALUES(54,18,17,1,38642);
INSERT INTO "lignes_commande" VALUES(55,18,33,3,24173);
INSERT INTO "lignes_commande" VALUES(56,18,32,2,7165);
INSERT INTO "lignes_commande" VALUES(57,18,4,2,9197);
INSERT INTO "lignes_commande" VALUES(58,19,36,1,29428);
INSERT INTO "lignes_commande" VALUES(59,19,28,1,38505);
INSERT INTO "lignes_commande" VALUES(60,19,1,3,10796);
INSERT INTO "lignes_commande" VALUES(61,20,20,1,41337);
INSERT INTO "lignes_commande" VALUES(62,20,24,2,33214);
INSERT INTO "lignes_commande" VALUES(63,21,40,1,31577);
INSERT INTO "lignes_commande" VALUES(64,21,10,1,42118);
INSERT INTO "lignes_commande" VALUES(65,21,16,2,20835);
INSERT INTO "lignes_commande" VALUES(66,22,16,2,20835);
INSERT INTO "lignes_commande" VALUES(67,22,18,1,8664);
INSERT INTO "lignes_commande" VALUES(68,22,11,2,13963);
INSERT INTO "lignes_commande" VALUES(69,22,7,1,42953);
INSERT INTO "lignes_commande" VALUES(70,23,13,1,17610);
INSERT INTO "lignes_commande" VALUES(71,23,26,2,17230);
INSERT INTO "lignes_commande" VALUES(72,23,22,2,22465);
INSERT INTO "lignes_commande" VALUES(73,23,18,3,8664);
INSERT INTO "lignes_commande" VALUES(74,24,12,1,25798);
INSERT INTO "lignes_commande" VALUES(75,24,38,1,19662);
INSERT INTO "lignes_commande" VALUES(76,24,17,3,38642);
INSERT INTO "lignes_commande" VALUES(77,25,8,2,16531);
INSERT INTO "lignes_commande" VALUES(78,25,25,1,14159);
INSERT INTO "lignes_commande" VALUES(79,25,37,3,12863);
INSERT INTO "lignes_commande" VALUES(80,25,13,2,17610);
INSERT INTO "lignes_commande" VALUES(81,26,22,2,22465);
INSERT INTO "lignes_commande" VALUES(82,26,40,3,31577);
INSERT INTO "lignes_commande" VALUES(83,27,19,2,44698);
INSERT INTO "lignes_commande" VALUES(84,27,36,3,29428);
INSERT INTO "lignes_commande" VALUES(85,27,9,2,30993);
INSERT INTO "lignes_commande" VALUES(86,27,13,3,17610);
INSERT INTO "lignes_commande" VALUES(87,28,28,3,38505);
INSERT INTO "lignes_commande" VALUES(88,28,38,3,19662);
INSERT INTO "lignes_commande" VALUES(89,29,11,3,13963);
INSERT INTO "lignes_commande" VALUES(90,29,6,3,17828);
INSERT INTO "lignes_commande" VALUES(91,29,19,3,44698);
INSERT INTO "lignes_commande" VALUES(92,29,33,2,24173);
INSERT INTO "lignes_commande" VALUES(93,30,2,1,19549);
INSERT INTO "lignes_commande" VALUES(94,30,3,2,10217);
INSERT INTO "lignes_commande" VALUES(95,31,32,1,7165);
INSERT INTO "lignes_commande" VALUES(96,31,26,3,17230);
INSERT INTO "lignes_commande" VALUES(97,31,16,3,20835);
INSERT INTO "lignes_commande" VALUES(98,32,34,1,7837);
INSERT INTO "lignes_commande" VALUES(99,32,30,1,21191);
INSERT INTO "lignes_commande" VALUES(100,32,4,2,9197);
INSERT INTO "lignes_commande" VALUES(101,32,36,1,29428);
INSERT INTO "lignes_commande" VALUES(102,33,40,3,31577);
INSERT INTO "lignes_commande" VALUES(103,33,33,2,24173);
INSERT INTO "lignes_commande" VALUES(104,33,28,1,38505);
INSERT INTO "lignes_commande" VALUES(105,34,32,1,7165);
INSERT INTO "lignes_commande" VALUES(106,34,16,3,20835);
INSERT INTO "lignes_commande" VALUES(107,34,18,2,8664);
INSERT INTO "lignes_commande" VALUES(108,34,29,1,14208);
INSERT INTO "lignes_commande" VALUES(109,35,25,3,14159);
INSERT INTO "lignes_commande" VALUES(110,35,10,1,42118);
INSERT INTO "lignes_commande" VALUES(111,36,27,3,8179);
INSERT INTO "lignes_commande" VALUES(112,36,25,3,14159);
INSERT INTO "lignes_commande" VALUES(113,37,25,3,14159);
INSERT INTO "lignes_commande" VALUES(114,37,27,3,8179);
INSERT INTO "lignes_commande" VALUES(115,37,35,3,24122);
INSERT INTO "lignes_commande" VALUES(116,38,26,1,17230);
INSERT INTO "lignes_commande" VALUES(117,38,11,3,13963);
INSERT INTO "lignes_commande" VALUES(118,38,30,3,21191);
INSERT INTO "lignes_commande" VALUES(119,39,9,1,30993);
INSERT INTO "lignes_commande" VALUES(120,39,30,2,21191);
INSERT INTO "lignes_commande" VALUES(121,39,12,2,25798);
INSERT INTO "lignes_commande" VALUES(122,40,17,1,38642);
INSERT INTO "lignes_commande" VALUES(123,40,6,3,17828);
INSERT INTO "lignes_commande" VALUES(124,40,31,3,17892);
INSERT INTO "lignes_commande" VALUES(125,41,13,3,17610);
INSERT INTO "lignes_commande" VALUES(126,41,2,1,19549);
INSERT INTO "lignes_commande" VALUES(127,42,24,3,33214);
INSERT INTO "lignes_commande" VALUES(128,42,11,3,13963);
INSERT INTO "lignes_commande" VALUES(129,42,39,3,38822);
INSERT INTO "lignes_commande" VALUES(130,43,25,3,14159);
INSERT INTO "lignes_commande" VALUES(131,43,26,3,17230);
INSERT INTO "lignes_commande" VALUES(132,43,13,3,17610);
INSERT INTO "lignes_commande" VALUES(133,43,5,1,5582);
INSERT INTO "lignes_commande" VALUES(134,44,3,3,10217);
INSERT INTO "lignes_commande" VALUES(135,44,23,2,10119);
INSERT INTO "lignes_commande" VALUES(136,44,35,1,24122);
INSERT INTO "lignes_commande" VALUES(137,44,28,3,38505);
INSERT INTO "lignes_commande" VALUES(138,45,30,1,21191);
INSERT INTO "lignes_commande" VALUES(139,45,10,3,42118);
INSERT INTO "lignes_commande" VALUES(140,45,28,3,38505);
INSERT INTO "lignes_commande" VALUES(141,46,38,1,19662);
INSERT INTO "lignes_commande" VALUES(142,46,18,2,8664);
INSERT INTO "lignes_commande" VALUES(143,46,21,2,6503);
INSERT INTO "lignes_commande" VALUES(144,46,16,1,20835);
INSERT INTO "lignes_commande" VALUES(145,47,12,2,25798);
INSERT INTO "lignes_commande" VALUES(146,47,32,2,7165);
INSERT INTO "lignes_commande" VALUES(147,47,14,2,9578);
INSERT INTO "lignes_commande" VALUES(148,48,6,3,17828);
INSERT INTO "lignes_commande" VALUES(149,48,16,2,20835);
INSERT INTO "lignes_commande" VALUES(150,49,6,1,17828);
INSERT INTO "lignes_commande" VALUES(151,49,19,2,44698);
INSERT INTO "lignes_commande" VALUES(152,50,28,2,38505);
INSERT INTO "lignes_commande" VALUES(153,50,36,3,29428);
INSERT INTO "lignes_commande" VALUES(154,50,22,2,22465);
INSERT INTO "lignes_commande" VALUES(155,51,35,3,24122);
INSERT INTO "lignes_commande" VALUES(156,51,12,2,25798);
INSERT INTO "lignes_commande" VALUES(157,51,13,2,17610);
INSERT INTO "lignes_commande" VALUES(158,51,14,3,9578);
INSERT INTO "lignes_commande" VALUES(159,52,35,2,24122);
INSERT INTO "lignes_commande" VALUES(160,52,9,1,30993);
INSERT INTO "lignes_commande" VALUES(161,53,37,2,12863);
INSERT INTO "lignes_commande" VALUES(162,53,19,2,44698);
INSERT INTO "lignes_commande" VALUES(163,54,26,1,17230);
INSERT INTO "lignes_commande" VALUES(164,54,32,3,7165);
INSERT INTO "lignes_commande" VALUES(165,55,8,2,16531);
INSERT INTO "lignes_commande" VALUES(166,55,36,3,29428);
INSERT INTO "lignes_commande" VALUES(167,56,28,1,38505);
INSERT INTO "lignes_commande" VALUES(168,56,20,3,41337);
INSERT INTO "lignes_commande" VALUES(169,56,37,3,12863);
INSERT INTO "lignes_commande" VALUES(170,56,40,1,31577);
INSERT INTO "lignes_commande" VALUES(171,57,36,1,29428);
INSERT INTO "lignes_commande" VALUES(172,57,5,1,5582);
INSERT INTO "lignes_commande" VALUES(173,58,19,3,44698);
INSERT INTO "lignes_commande" VALUES(174,58,30,1,21191);
INSERT INTO "lignes_commande" VALUES(175,58,5,2,5582);
INSERT INTO "lignes_commande" VALUES(176,59,5,1,5582);
INSERT INTO "lignes_commande" VALUES(177,59,4,2,9197);
INSERT INTO "lignes_commande" VALUES(178,60,33,2,24173);
INSERT INTO "lignes_commande" VALUES(179,60,35,1,24122);
INSERT INTO "lignes_commande" VALUES(180,60,32,3,7165);
CREATE TABLE produits (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    categorie_id INTEGER NOT NULL,
    nom TEXT NOT NULL,
    description TEXT,
    prix INTEGER NOT NULL CHECK (prix >= 0),
    stock INTEGER NOT NULL CHECK (stock >= 0),
    image TEXT NOT NULL,
    artisan TEXT NOT NULL,
    actif INTEGER NOT NULL DEFAULT 1 CHECK (actif IN (0, 1)),
    FOREIGN KEY (categorie_id) REFERENCES categories (id) ON DELETE RESTRICT
);
INSERT INTO "produits" VALUES(1,1,'Sculpture - Modèle 01','Pièce artisanale authentique faite main. Finition soignée.',10796,2,'sculpture.svg','Maître Nji Oumarou (Foumban)',1);
INSERT INTO "produits" VALUES(2,1,'Sculpture - Modèle 02','Pièce artisanale authentique faite main. Finition soignée.',19549,9,'sculpture.svg','Coopérative Nso Raphia (Bamenda)',1);
INSERT INTO "produits" VALUES(3,1,'Sculpture - Modèle 03','Pièce artisanale authentique faite main. Finition soignée.',10217,23,'sculpture.svg','Poterie Royale de Noun (Foumban)',1);
INSERT INTO "produits" VALUES(4,1,'Sculpture - Modèle 04','Pièce artisanale authentique faite main. Finition soignée.',9197,20,'sculpture.svg','Tissage Che & Fils (Bamenda)',1);
INSERT INTO "produits" VALUES(5,1,'Sculpture - Modèle 05','Pièce artisanale authentique faite main. Finition soignée.',5582,2,'sculpture.svg','Atelier Fon Kouamé (Foumban)',1);
INSERT INTO "produits" VALUES(6,1,'Sculpture - Modèle 06','Pièce artisanale authentique faite main. Finition soignée.',17828,9,'sculpture.svg','Poterie Royale de Noun (Foumban)',1);
INSERT INTO "produits" VALUES(7,1,'Sculpture - Modèle 07','Pièce artisanale authentique faite main. Finition soignée.',42953,2,'sculpture.svg','Poterie Royale de Noun (Foumban)',1);
INSERT INTO "produits" VALUES(8,1,'Sculpture - Modèle 08','Pièce artisanale authentique faite main. Finition soignée.',16531,24,'sculpture.svg','Poterie Royale de Noun (Foumban)',1);
INSERT INTO "produits" VALUES(9,2,'Vanneri - Modèle 01','Pièce artisanale authentique faite main. Finition soignée.',30993,9,'vannerie.svg','Tissage Che & Fils (Bamenda)',1);
INSERT INTO "produits" VALUES(10,2,'Vanneri - Modèle 02','Pièce artisanale authentique faite main. Finition soignée.',42118,10,'vannerie.svg','Atelier Fon Kouamé (Foumban)',1);
INSERT INTO "produits" VALUES(11,2,'Vanneri - Modèle 03','Pièce artisanale authentique faite main. Finition soignée.',13963,24,'vannerie.svg','Tissage Che & Fils (Bamenda)',1);
INSERT INTO "produits" VALUES(12,2,'Vanneri - Modèle 04','Pièce artisanale authentique faite main. Finition soignée.',25798,10,'vannerie.svg','Coopérative Nso Raphia (Bamenda)',1);
INSERT INTO "produits" VALUES(13,2,'Vanneri - Modèle 05','Pièce artisanale authentique faite main. Finition soignée.',17610,12,'vannerie.svg','Atelier Fon Kouamé (Foumban)',1);
INSERT INTO "produits" VALUES(14,2,'Vanneri - Modèle 06','Pièce artisanale authentique faite main. Finition soignée.',9578,14,'vannerie.svg','Atelier Fon Kouamé (Foumban)',1);
INSERT INTO "produits" VALUES(15,2,'Vanneri - Modèle 07','Pièce artisanale authentique faite main. Finition soignée.',27026,13,'vannerie.svg','Poterie Royale de Noun (Foumban)',1);
INSERT INTO "produits" VALUES(16,2,'Vanneri - Modèle 08','Pièce artisanale authentique faite main. Finition soignée.',20835,3,'vannerie.svg','Tissage Che & Fils (Bamenda)',1);
INSERT INTO "produits" VALUES(17,3,'Textiles & Tissu - Modèle 01','Pièce artisanale authentique faite main. Finition soignée.',38642,5,'textile.svg','Tissage Che & Fils (Bamenda)',1);
INSERT INTO "produits" VALUES(18,3,'Textiles & Tissu - Modèle 02','Pièce artisanale authentique faite main. Finition soignée.',8664,19,'textile.svg','Maître Nji Oumarou (Foumban)',1);
INSERT INTO "produits" VALUES(19,3,'Textiles & Tissu - Modèle 03','Pièce artisanale authentique faite main. Finition soignée.',44698,21,'textile.svg','Maître Nji Oumarou (Foumban)',1);
INSERT INTO "produits" VALUES(20,3,'Textiles & Tissu - Modèle 04','Pièce artisanale authentique faite main. Finition soignée.',41337,8,'textile.svg','Atelier Fon Kouamé (Foumban)',1);
INSERT INTO "produits" VALUES(21,3,'Textiles & Tissu - Modèle 05','Pièce artisanale authentique faite main. Finition soignée.',6503,23,'textile.svg','Coopérative Nso Raphia (Bamenda)',1);
INSERT INTO "produits" VALUES(22,3,'Textiles & Tissu - Modèle 06','Pièce artisanale authentique faite main. Finition soignée.',22465,4,'textile.svg','Coopérative Nso Raphia (Bamenda)',1);
INSERT INTO "produits" VALUES(23,3,'Textiles & Tissu - Modèle 07','Pièce artisanale authentique faite main. Finition soignée.',10119,14,'textile.svg','Maître Nji Oumarou (Foumban)',1);
INSERT INTO "produits" VALUES(24,3,'Textiles & Tissu - Modèle 08','Pièce artisanale authentique faite main. Finition soignée.',33214,22,'textile.svg','Maître Nji Oumarou (Foumban)',1);
INSERT INTO "produits" VALUES(25,4,'Bijouterie artisanal - Modèle 01','Pièce artisanale authentique faite main. Finition soignée.',14159,13,'bijou.svg','Maître Nji Oumarou (Foumban)',1);
INSERT INTO "produits" VALUES(26,4,'Bijouterie artisanal - Modèle 02','Pièce artisanale authentique faite main. Finition soignée.',17230,23,'bijou.svg','Maître Nji Oumarou (Foumban)',1);
INSERT INTO "produits" VALUES(27,4,'Bijouterie artisanal - Modèle 03','Pièce artisanale authentique faite main. Finition soignée.',8179,21,'bijou.svg','Coopérative Nso Raphia (Bamenda)',1);
INSERT INTO "produits" VALUES(28,4,'Bijouterie artisanal - Modèle 04','Pièce artisanale authentique faite main. Finition soignée.',38505,25,'bijou.svg','Coopérative Nso Raphia (Bamenda)',1);
INSERT INTO "produits" VALUES(29,4,'Bijouterie artisanal - Modèle 05','Pièce artisanale authentique faite main. Finition soignée.',14208,16,'bijou.svg','Tissage Che & Fils (Bamenda)',1);
INSERT INTO "produits" VALUES(30,4,'Bijouterie artisanal - Modèle 06','Pièce artisanale authentique faite main. Finition soignée.',21191,22,'bijou.svg','Poterie Royale de Noun (Foumban)',1);
INSERT INTO "produits" VALUES(31,4,'Bijouterie artisanal - Modèle 07','Pièce artisanale authentique faite main. Finition soignée.',17892,23,'bijou.svg','Maître Nji Oumarou (Foumban)',1);
INSERT INTO "produits" VALUES(32,4,'Bijouterie artisanal - Modèle 08','Pièce artisanale authentique faite main. Finition soignée.',7165,9,'bijou.svg','Atelier Fon Kouamé (Foumban)',1);
INSERT INTO "produits" VALUES(33,5,'Poterie & Céramiqu - Modèle 01','Pièce artisanale authentique faite main. Finition soignée.',24173,14,'poterie.svg','Maître Nji Oumarou (Foumban)',1);
INSERT INTO "produits" VALUES(34,5,'Poterie & Céramiqu - Modèle 02','Pièce artisanale authentique faite main. Finition soignée.',7837,8,'poterie.svg','Poterie Royale de Noun (Foumban)',1);
INSERT INTO "produits" VALUES(35,5,'Poterie & Céramiqu - Modèle 03','Pièce artisanale authentique faite main. Finition soignée.',24122,8,'poterie.svg','Tissage Che & Fils (Bamenda)',1);
INSERT INTO "produits" VALUES(36,5,'Poterie & Céramiqu - Modèle 04','Pièce artisanale authentique faite main. Finition soignée.',29428,22,'poterie.svg','Tissage Che & Fils (Bamenda)',1);
INSERT INTO "produits" VALUES(37,5,'Poterie & Céramiqu - Modèle 05','Pièce artisanale authentique faite main. Finition soignée.',12863,10,'poterie.svg','Coopérative Nso Raphia (Bamenda)',1);
INSERT INTO "produits" VALUES(38,5,'Poterie & Céramiqu - Modèle 06','Pièce artisanale authentique faite main. Finition soignée.',19662,25,'poterie.svg','Poterie Royale de Noun (Foumban)',1);
INSERT INTO "produits" VALUES(39,5,'Poterie & Céramiqu - Modèle 07','Pièce artisanale authentique faite main. Finition soignée.',38822,10,'poterie.svg','Poterie Royale de Noun (Foumban)',1);
INSERT INTO "produits" VALUES(40,5,'Poterie & Céramiqu - Modèle 08','Pièce artisanale authentique faite main. Finition soignée.',31577,20,'poterie.svg','Tissage Che & Fils (Bamenda)',1);
DELETE FROM "sqlite_sequence";
INSERT INTO "sqlite_sequence" VALUES('administrateurs',1);
INSERT INTO "sqlite_sequence" VALUES('categories',5);
INSERT INTO "sqlite_sequence" VALUES('produits',40);
INSERT INTO "sqlite_sequence" VALUES('commandes',60);
INSERT INTO "sqlite_sequence" VALUES('lignes_commande',180);
COMMIT;
