/* Effectifs */

INSERT INTO
    ref_nomenclatures.t_synonymes (id_type, type_mnemonique, cd_nomenclature, initial_value, source)
    values
        (ref_nomenclatures.get_id_nomenclature_type('OBJ_DENBR'), 'OBJ_DENBR', 'COL', 'nombre de colonies', 'ODIN')
      , (ref_nomenclatures.get_id_nomenclature_type('OBJ_DENBR'), 'OBJ_DENBR', 'CPL', 'nombre de couples', 'ODIN')
      , (ref_nomenclatures.get_id_nomenclature_type('OBJ_DENBR'), 'OBJ_DENBR', 'HAM', 'nombre de hampes', 'ODIN')
      , (ref_nomenclatures.get_id_nomenclature_type('OBJ_DENBR'), 'OBJ_DENBR', 'PON', 'nombre de pontes', 'ODIN')
      , (ref_nomenclatures.get_id_nomenclature_type('OBJ_DENBR'), 'OBJ_DENBR', 'TIGE', 'nombre de tiges', 'ODIN')
      , (ref_nomenclatures.get_id_nomenclature_type('OBJ_DENBR'), 'OBJ_DENBR', 'TOUF', 'nombre de touffes', 'ODIN')
      , (ref_nomenclatures.get_id_nomenclature_type('OBJ_DENBR'), 'OBJ_DENBR', 'IND', 'nombre d''individus', 'ODIN')
      , (ref_nomenclatures.get_id_nomenclature_type('OBJ_DENBR'), 'OBJ_DENBR', 'SURF', 'surface (m²)', 'ODIN')
      , (ref_nomenclatures.get_id_nomenclature_type('OBJ_DENBR'), 'OBJ_DENBR', 'NSP', 'Ne sait pas', 'ODIN')
      , (ref_nomenclatures.get_id_nomenclature_type('OBJ_DENBR'), 'OBJ_DENBR', 'NID', 'Nombre de nids', 'ODIN');

/* Stade de vie*/

INSERT INTO
    ref_nomenclatures.t_synonymes (id_type, type_mnemonique, initial_value, cd_nomenclature, source)
    values
        (ref_nomenclatures.get_id_nomenclature_type('STADE_VIE'), 'STADE_VIE', 'adulte, mature', '2', 'ODIN')
      , (ref_nomenclatures.get_id_nomenclature_type('STADE_VIE'), 'STADE_VIE', 'adulte ou juvénile', '3', 'ODIN')
      , (ref_nomenclatures.get_id_nomenclature_type('STADE_VIE'), 'STADE_VIE', 'en graine', '20', 'ODIN')
      , (ref_nomenclatures.get_id_nomenclature_type('STADE_VIE'), 'STADE_VIE', 'fané', '19', 'ODIN')
      , (ref_nomenclatures.get_id_nomenclature_type('STADE_VIE'), 'STADE_VIE', 'imago, adulte', '15', 'ODIN')
      , (ref_nomenclatures.get_id_nomenclature_type('STADE_VIE'), 'STADE_VIE', 'immature', '4', 'ODIN')
      , (ref_nomenclatures.get_id_nomenclature_type('STADE_VIE'), 'STADE_VIE', 'larve', '6', 'ODIN')
      , (ref_nomenclatures.get_id_nomenclature_type('STADE_VIE'), 'STADE_VIE', 'nymphe, immature', '13', 'ODIN')
      , (ref_nomenclatures.get_id_nomenclature_type('STADE_VIE'), 'STADE_VIE', 'oeuf', '9', 'ODIN')
      , (ref_nomenclatures.get_id_nomenclature_type('STADE_VIE'), 'STADE_VIE', 'post-larves ou juvénile', '26', 'ODIN')
      , (ref_nomenclatures.get_id_nomenclature_type('STADE_VIE'), 'STADE_VIE', 'sub-adulte', '5', 'ODIN')
      , (ref_nomenclatures.get_id_nomenclature_type('STADE_VIE'), 'STADE_VIE', 'têtard', '8', 'ODIN');

/* METHO_OBS */

INSERT INTO
    ref_nomenclatures.t_synonymes (id_type, type_mnemonique, initial_value, cd_nomenclature, source)
    values
        (ref_nomenclatures.get_id_nomenclature_type('METH_OBS'), 'METH_OBS', 'déjections, crottes', '6', 'ODIN')
      , (ref_nomenclatures.get_id_nomenclature_type('METH_OBS'), 'METH_OBS', 'empreintes', '4', 'ODIN')
      , (ref_nomenclatures.get_id_nomenclature_type('METH_OBS'), 'METH_OBS', 'exuvie', '5', 'ODIN')
      , (ref_nomenclatures.get_id_nomenclature_type('METH_OBS'), 'METH_OBS', 'fientes', '6', 'ODIN')
      , (ref_nomenclatures.get_id_nomenclature_type('METH_OBS'), 'METH_OBS', 'nid', '8', 'ODIN')
      , ( ref_nomenclatures.get_id_nomenclature_type('METH_OBS')
        , 'METH_OBS'
        , 'nid, fourmilière, entonnoir...'
        , '8'
        , 'ODIN')
      , (ref_nomenclatures.get_id_nomenclature_type('METH_OBS'), 'METH_OBS', 'pelote de réjection', '9', 'ODIN')
      , (ref_nomenclatures.get_id_nomenclature_type('METH_OBS'), 'METH_OBS', 'plumes', '11', 'ODIN')
      , (ref_nomenclatures.get_id_nomenclature_type('METH_OBS'), 'METH_OBS', 'poils', '11', 'ODIN')
      , (ref_nomenclatures.get_id_nomenclature_type('METH_OBS'), 'METH_OBS', 'restes', '12', 'ODIN')
      , (ref_nomenclatures.get_id_nomenclature_type('METH_OBS'), 'METH_OBS', 'taupinière', '23', 'ODIN')
      , (ref_nomenclatures.get_id_nomenclature_type('METH_OBS'), 'METH_OBS', 'terrier, habitation', '23', 'ODIN')
;

/* METHO_OBS */

INSERT INTO
    ref_nomenclatures.t_synonymes (id_type, type_mnemonique, initial_value, cd_nomenclature, source)
    values
        ( ref_nomenclatures.get_id_nomenclature_type('OCC_COMPORTEMENT')
        , 'OCC_COMPORTEMENT'
        , 'accouplement'
        , '19'
        , 'ODIN')
      , (ref_nomenclatures.get_id_nomenclature_type('OCC_COMPORTEMENT'), 'OCC_COMPORTEMENT', 'chant', '18', 'ODIN')
      , ( ref_nomenclatures.get_id_nomenclature_type('OCC_COMPORTEMENT')
        , 'OCC_COMPORTEMENT'
        , 'déplacement'
        , '16'
        , 'ODIN')
      , ( ref_nomenclatures.get_id_nomenclature_type('OCC_COMPORTEMENT')
        , 'OCC_COMPORTEMENT'
        , 'nourrissage des jeunes'
        , '14'
        , 'ODIN')
      , (ref_nomenclatures.get_id_nomenclature_type('OCC_COMPORTEMENT'), 'OCC_COMPORTEMENT', 'ponte', '23', 'ODIN')
      , ( ref_nomenclatures.get_id_nomenclature_type('OCC_COMPORTEMENT')
        , 'OCC_COMPORTEMENT'
        , 'recherche de nourriture, chasse'
        , '8'
        , 'ODIN')
      , ( ref_nomenclatures.get_id_nomenclature_type('OCC_COMPORTEMENT')
        , 'OCC_COMPORTEMENT'
        , 'repos, utilisation des reposoirs'
        , '17'
        , 'ODIN')
      , (ref_nomenclatures.get_id_nomenclature_type('OCC_COMPORTEMENT'), 'OCC_COMPORTEMENT', 'tandem', '21', 'ODIN')
      , (ref_nomenclatures.get_id_nomenclature_type('OCC_COMPORTEMENT'), 'OCC_COMPORTEMENT', 'vol', '10', 'ODIN')
      , ( ref_nomenclatures.get_id_nomenclature_type('OCC_COMPORTEMENT')
        , 'OCC_COMPORTEMENT'
        , 'vol de migration'
        , '4'
        , 'ODIN');

INSERT INTO
    ref_nomenclatures.t_synonymes (id_type, type_mnemonique, initial_value, cd_nomenclature, source)
    values
    (ref_nomenclatures.get_id_nomenclature_type('ETA_BIO'), 'ETA_BIO', 'mort', '3', 'ODIN');



INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , type_mnemonique
                                  , initial_value
                                  , cd_nomenclature
                                  , source
                                  , initial_source_field)
    values
        ( ref_nomenclatures.get_id_nomenclature_type('NATURALITE')
        , 'NATURALITE'
        , 'cultivée, élevée'
        , '2'
        , 'ODIN'
        , 'o_resi')
      , (ref_nomenclatures.get_id_nomenclature_type('STAT_BIOGEO'), 'STAT_BIOGEO', 'indigène', '2', 'ODIN', 'o_resi')
      , ( ref_nomenclatures.get_id_nomenclature_type('STAT_BIOGEO')
        , 'STAT_BIOGEO'
        , 'introduite (établi)'
        , '3'
        , 'ODIN'
        , 'o_resi')
      , (ref_nomenclatures.get_id_nomenclature_type('STATUT_BIO'), 'STATUT_BIO', 'migration', '6', 'ODIN', 'o_resi')
      , ( ref_nomenclatures.get_id_nomenclature_type('STATUT_BIO')
        , 'STATUT_BIO'
        , 'présence irrégulière'
        , '11'
        , 'ODIN'
        , 'o_resi')
      , ( ref_nomenclatures.get_id_nomenclature_type('STATUT_BIO')
        , 'STATUT_BIO'
        , 'présence régulière (sédentaire)'
        , '12'
        , 'ODIN'
        , 'o_resi')
      , (ref_nomenclatures.get_id_nomenclature_type('STATUT_BIO'), 'STATUT_BIO', 'reproduction', '3', 'ODIN', 'o_resi');

INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , type_mnemonique
                                  , initial_value
                                  , cd_nomenclature
                                  , source
                                  , initial_source_field)
    values
        (ref_nomenclatures.get_id_nomenclature_type('NATURALITE'), 'NATURALITE', '?', '0', 'ODIN', 'o_spon')
      , (ref_nomenclatures.get_id_nomenclature_type('NATURALITE'), 'NATURALITE', 'X', '1', 'ODIN', 'o_spon')
      , (ref_nomenclatures.get_id_nomenclature_type('NATURALITE'), 'NATURALITE', 'T', '4', 'ODIN', 'o_spon')
      , (ref_nomenclatures.get_id_nomenclature_type('NATURALITE'), 'NATURALITE', 'S', '5', 'ODIN', 'o_spon')
      , (ref_nomenclatures.get_id_nomenclature_type('STAT_BIOGEO'), 'STAT_BIOGEO', 'Q', '3', 'ODIN', 'o_spon');


INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , type_mnemonique
                                  , initial_value
                                  , cd_nomenclature
                                  , source
                                  , initial_source_field)
    values
        (ref_nomenclatures.get_id_nomenclature_type('STATUT_SOURCE'), 'STATUT_SOURCE', 'D', 'Te', 'ODIN', 'o_styp')
      , (ref_nomenclatures.get_id_nomenclature_type('STATUT_SOURCE'), 'STATUT_SOURCE', 'C', 'Co', 'ODIN', 'o_spon')
      , (ref_nomenclatures.get_id_nomenclature_type('STATUT_SOURCE'), 'STATUT_SOURCE', 'P', 'Li', 'ODIN', 'o_spon');

INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , type_mnemonique
                                  , initial_value
                                  , cd_nomenclature
                                  , source
                                  , initial_source_field)
    values
        (ref_nomenclatures.get_id_nomenclature_type('METH_OBS'), 'METH_OBS', 'à l''écoute', '1', 'ODIN', 'o_sacq')
      , (ref_nomenclatures.get_id_nomenclature_type('METH_OBS'), 'METH_OBS', 'à vue', '0', 'ODIN', 'o_sacq')
      , ( ref_nomenclatures.get_id_nomenclature_type('METH_OBS')
        , 'METH_OBS'
        , 'analyse de pelotes de réjection'
        , '9'
        , 'ODIN'
        , 'o_sacq')
      , ( ref_nomenclatures.get_id_nomenclature_type('METH_OBS')
        , 'METH_OBS'
        , 'comptage ciblé (nids, terriers, cavités, dortoirs …)'
        , '8'
        , 'ODIN'
        , 'o_sacq')
      , ( ref_nomenclatures.get_id_nomenclature_type('METH_OBS')
        , 'METH_OBS'
        , 'comptage du nombre de pieds en fleur'
        , '17'
        , 'ODIN'
        , 'o_sacq')
      , ( ref_nomenclatures.get_id_nomenclature_type('METH_OBS')
        , 'METH_OBS'
        , 'détection des ultrasons (chauves-souris)'
        , '3'
        , 'ODIN'
        , 'o_sacq')
;

INSERT INTO
    ref_nomenclatures.t_synonymes ( id_type
                                  , type_mnemonique
                                  , initial_value
                                  , cd_nomenclature
                                  , source
                                  , initial_source_field)
    values
        (ref_nomenclatures.get_id_nomenclature_type('STATUT_VALID'), 'STATUT_VALID', 'à valider', '6', 'ODIN', 'o_vali')
      , ( ref_nomenclatures.get_id_nomenclature_type('STATUT_VALID')
        , 'STATUT_VALID'
        , 'non plausible'
        , '4'
        , 'ODIN'
        , 'o_vali')
      , (ref_nomenclatures.get_id_nomenclature_type('STATUT_VALID'), 'STATUT_VALID', 'doute', '3', 'ODIN', 'o_vali')
      , (ref_nomenclatures.get_id_nomenclature_type('STATUT_VALID'), 'STATUT_VALID', 'plausible', '2', 'ODIN', 'o_vali')
      , (ref_nomenclatures.get_id_nomenclature_type('STATUT_VALID'), 'STATUT_VALID', 'validée', '1', 'ODIN', 'o_vali');



update ref_nomenclatures.t_synonymes s

SET
    id_type         = b.id_type
  , id_nomenclature = t.id_nomenclature
  , mnemonique      = t.mnemonique
  , label_default   =
        t.label_default
    FROM
        ref_nomenclatures.t_nomenclatures t
      , ref_nomenclatures.bib_nomenclatures_types b
    WHERE
          s.cd_nomenclature = t.cd_nomenclature
      and t.id_type = b.id_type
      and s.type_mnemonique like b.mnemonique;