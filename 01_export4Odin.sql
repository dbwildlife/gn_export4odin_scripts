create extension IF NOT EXISTS pgcrypto;

set role pnr;

create or replace function ref_geo.fct_c_farthest_node_from_centroid_distance(_geom geometry, _default integer default 0)
    RETURNS float AS
$dist$
DECLARE
    _dist float;
BEGIN
    RAISE DEBUG 'Geometry type is %', st_geometrytype(_geom);
    if st_geometrytype(_geom) like 'ST_Point'
    then
        RAISE DEBUG 'Geometry type is "ST_Point"';
        select _default into _dist;
    else
        RAISE DEBUG 'Calculating distance';
        with
            t as (select (st_dumppoints(_geom)).geom)
        select
            max(st_distance(st_centroid(_geom), t.geom))
            into _dist
            from
                t;
    end if;
    return _dist;
END;
$dist$
    LANGUAGE plpgsql;


create table gn_exports.t_c_odin_lots as
select
    id_synthese
  , meta_update_date
  , ntile((select count(*) / 10000 from gn_synthese.synthese)::int) over (order by meta_update_date) as lot
    from
        gn_synthese.synthese;

create index on gn_exports.t_c_odin_lots (id_synthese);
create index on gn_exports.t_c_odin_lots (lot);

drop view IF EXISTS gn_exports.v_odin_situation;
create view gn_exports.v_odin_situation as
select distinct
                'IDS-SINPBN-' || upper(coalesce(borgds.champs_addi ->> 'CODE',
                                                coalesce(borgafprod.champs_addi ->> 'CODE',
                                                         coalesce(borgafmain.champs_addi ->> 'CODE', 'PNRNM')))) ||
                '-' || encode(hmac(st_astext(the_geom_local), 'test', 'sha1'), 'hex')                          as s_id
  ,             encode(hmac(st_astext(the_geom_local), 'test', 'sha1'), 'hex')                                 as s_uid
  ,             case
                    when st_geometrytype(the_geom_4326) LIKE 'ST_Point'
                        then 'centre géographique de la localisation'
                    else null end                                                                              as s_styp
  ,             ref_geo.fct_c_farthest_node_from_centroid_distance(the_geom_local, coalesce(syn.precision, 0)) as s_prec
  ,             st_x(st_centroid(the_geom_local))                                                              as s_coox
  ,             st_y(st_centroid(the_geom_local))                                                              as s_cooy
  ,             st_astext(st_transform(st_centroid(the_geom_4326), 4326))                                      as geometry
  ,             the_geom_local                                                                                 as geom
    from
        gn_synthese.synthese syn
            join gn_meta.t_datasets ds on ds.id_dataset = syn.id_dataset
            left join gn_meta.cor_dataset_actor cdsact
                      on (cdsact.id_dataset = ds.id_dataset and
                          cdsact.id_nomenclature_actor_role =
                          ref_nomenclatures.get_id_nomenclature('ROLE_ACTEUR', '6'))
            left join utilisateurs.bib_organismes borgds
                      on borgds.id_organisme = cdsact.id_organism
            left join gn_meta.t_acquisition_frameworks af
                      on ds.id_acquisition_framework = af.id_acquisition_framework
            left join gn_meta.cor_acquisition_framework_actor cafactprod
                      on (af.id_acquisition_framework = cafactprod.id_acquisition_framework and
                          cafactprod.id_nomenclature_actor_role =
                          ref_nomenclatures.get_id_nomenclature('ROLE_ACTEUR', '6'))
            left join utilisateurs.bib_organismes borgafprod on cafactprod.id_organism = borgafprod.id_organisme
            left join gn_meta.cor_acquisition_framework_actor cafactmain
                      on (af.id_acquisition_framework = cafactmain.id_acquisition_framework and
                          cafactmain.id_nomenclature_actor_role =
                          ref_nomenclatures.get_id_nomenclature('ROLE_ACTEUR', '1'))
            left join utilisateurs.bib_organismes borgafmain on cafactmain.id_organism = borgafmain.id_organisme
;


DROP VIEW IF EXISTS gn_exports.v_odin_ensemble;
create view gn_exports.v_odin_ensemble as
(
select distinct
    'IDE-SINPHN-PNRNM-' || unique_id_sinp_grp as e_id
  , unique_id_sinp_grp
  , 'Relevé'                                  as e_rtyp
    from
        gn_synthese.synthese
        );


DROP VIEW IF EXISTS gn_exports.v_odin_observations;
CREATE OR REPLACE VIEW gn_exports.v_odin_observations AS
SELECT
                'IDO-SINPBN-' || upper(coalesce(borgds.champs_addi ->> 'CODE',
                                                coalesce(borgafprod.champs_addi ->> 'CODE',
                                                         coalesce(borgafmain.champs_addi ->> 'CODE', 'PNRNM')))) ||
                '-' || syn.id_synthese                                                          as o_id
  ,             unique_id_sinp                                                                  as o_uuid
  ,             lot.lot                                                                         as o_lots
  ,             to_char(date_min, 'DD/MM/YYYY')                                                 as o_date
  ,             to_char(date_max, 'DD/MM/YYYY')                                                 as o_dat2
  ,             meta_v_taxref                                                                   as o_refe
  ,             tx.nom_valide                                                                   as o_nlat
  ,             syn.cd_nom                                                                      as o_reid
  ,             tx.nom_vern                                                                     as o_nver
-- , xxxx as o_situ -- TODO Gérer le lien avec les situations.
  ,             'IDS-SINPBN-' || upper(coalesce(borgds.champs_addi ->> 'CODE',
                                                coalesce(borgafprod.champs_addi ->> 'CODE',
                                                         coalesce(borgafmain.champs_addi ->> 'CODE', 'PNRNM')))) ||
                '-' || encode(hmac(st_astext(the_geom_local), 'test', 'sha1'), 'hex')           as o_situ

  ,             la.area_code                                                                    as o_admin
  ,             case
                    when id_nomenclature_observation_status = ref_nomenclatures.get_id_nomenclature('STATUT_OBS', 'No')
                        then 0
                    else coalesce(coalesce(syn.count_max, syn.count_min), 1) end                as o_nbre
  ,             case
                    when syn.count_min is null then 'présence/absence'
                    else obj_denbr.initial_value end                                            as o_nbrt
  ,             case
                    when syn.id_nomenclature_sex = ref_nomenclatures.get_id_nomenclature('SEXE', '3')
                        then coalesce(coalesce(syn.count_max, syn.count_min), 1) end            as o_nbrm
  ,             case
                    when syn.id_nomenclature_sex = ref_nomenclatures.get_id_nomenclature('SEXE', '2')
                        then coalesce(coalesce(syn.count_max, syn.count_min), 1) end            as o_nbrf
  ,             case
                    when syn.id_nomenclature_bio_condition = ref_nomenclatures.get_id_nomenclature('ETA_BIO', '3')
                        then coalesce(coalesce(syn.count_max, syn.count_min), '2') end          as o_nbrd
  ,             bio_status.initial_value                                                        as o_stad
  ,             meth_obs.initial_value                                                          as o_indi
  ,             behaviour.initial_value                                                         as o_comp
  ,             eta_sante.initial_value                                                         as o_etat
  ,             coalesce(resi_bio_status.initial_value, resi_naturalness.initial_value)         as o_resi
  ,             coalesce(spon_naturalness.initial_value, spon_stat_biogeo.initial_value)        as o_spon
  ,             syn.altitude_min                                                                as o_p1h111
  ,             habref.lb_hab_fr                                                                as o_habi
  ,             habref.cd_hab                                                                   as o_habc
  ,             syn.observers                                                                   as o_obsv
  ,             syn.determiner                                                                  as o_detm
  ,             syn.validator                                                                   as o_vldt
  ,             'oui'                                                                           as o_anon
  ,             upper(coalesce(borgds.nom_organisme,
                               coalesce(borgafprod.nom_organisme,
                                        coalesce(borgafmain.nom_organisme,
                                                 'Parc naturel régional de Normandie-Maine')))) as o_strp
  ,             styp.initial_value                                                              as o_styp
  ,             sacq.initial_value                                                              as o_sacq
  ,             vali.initial_value                                                              as o_vali
  ,             json_build_object('releve', coalesce(syn.comment_context, '-'), 'observation',
                                  coalesce(syn.comment_description, '-'))                       as o_comt
  ,             syn.meta_update_date                                                            as o_dmaj
  ,             the_geom_local                                                                  as o_geom
  ,             syn.the_geom_4326                                                               as o_geom4326
  ,             st_astext(syn.the_geom_local)                                                   as o_geom_astext
  ,             the_geom_local                                                                  as geom
    from
        gn_synthese.synthese syn
            join gn_exports.t_c_odin_lots lot on syn.id_synthese = lot.id_synthese
            join taxonomie.taxref tx on syn.cd_nom = tx.cd_nom
            join gn_synthese.cor_area_synthese clasyn on syn.id_synthese = clasyn.id_synthese
            join ref_geo.l_areas la on clasyn.id_area = la.id_area
            join gn_meta.t_datasets ds on syn.id_dataset = ds.id_dataset
            join ref_nomenclatures.t_nomenclatures statut_source
                 on ds.id_nomenclature_collecting_method = statut_source.id_nomenclature
--             join dsactor on ds.id_dataset = dsactor.id_dataset
            left join gn_meta.cor_dataset_actor cdsact
                      on (cdsact.id_dataset = ds.id_dataset and
                          cdsact.id_nomenclature_actor_role =
                          ref_nomenclatures.get_id_nomenclature('ROLE_ACTEUR', '6'))
            left join utilisateurs.bib_organismes borgds
                      on borgds.id_organisme = cdsact.id_organism
            left join gn_meta.t_acquisition_frameworks af
                      on ds.id_acquisition_framework = af.id_acquisition_framework
            left join gn_meta.cor_acquisition_framework_actor cafactprod
                      on (af.id_acquisition_framework = cafactprod.id_acquisition_framework and
                          cafactprod.id_nomenclature_actor_role =
                          ref_nomenclatures.get_id_nomenclature('ROLE_ACTEUR', '6'))
            left join utilisateurs.bib_organismes borgafprod on cafactprod.id_organism = borgafprod.id_organisme
            left join gn_meta.cor_acquisition_framework_actor cafactmain
                      on (af.id_acquisition_framework = cafactmain.id_acquisition_framework and
                          cafactmain.id_nomenclature_actor_role =
                          ref_nomenclatures.get_id_nomenclature('ROLE_ACTEUR', '1'))
            left join utilisateurs.bib_organismes borgafmain on cafactmain.id_organism = borgafmain.id_organisme
            left join ref_nomenclatures.t_synonymes as obj_denbr
                      on (syn.id_nomenclature_obj_count = obj_denbr.id_nomenclature and obj_denbr.source = 'ODIN')
            left join ref_nomenclatures.t_synonymes as bio_status
                      on (bio_status.id_nomenclature = id_nomenclature_bio_status and bio_status.source = 'ODIN')
            left join ref_nomenclatures.t_synonymes as meth_obs
                      on (meth_obs.id_nomenclature = id_nomenclature_obs_technique and meth_obs.source = 'ODIN')
            left join ref_nomenclatures.t_synonymes as behaviour
                      on (behaviour.id_nomenclature = id_nomenclature_behaviour and behaviour.source = 'ODIN')
            left join ref_nomenclatures.t_synonymes as eta_sante
                      on (eta_sante.id_nomenclature = id_nomenclature_bio_status and eta_sante.source = 'ODIN')
            left join ref_nomenclatures.t_synonymes as resi_bio_status
                      on (resi_bio_status.id_nomenclature = id_nomenclature_bio_status and
                          resi_bio_status.source = 'ODIN' and
                          resi_bio_status.initial_source_field = 'o_resi')
            left join ref_nomenclatures.t_synonymes as resi_naturalness
                      on (resi_naturalness.id_nomenclature = id_nomenclature_naturalness and
                          resi_naturalness.source = 'ODIN' and resi_naturalness.initial_source_field = 'o_resi')
            left join ref_nomenclatures.t_synonymes as spon_naturalness
                      on (spon_naturalness.id_nomenclature = id_nomenclature_naturalness and
                          spon_naturalness.source = 'ODIN' and
                          spon_naturalness.initial_source_field = 'o_spon')
            left join ref_nomenclatures.t_synonymes as spon_stat_biogeo
                      on (spon_stat_biogeo.id_nomenclature = id_nomenclature_biogeo_status and
                          spon_stat_biogeo.source = 'ODIN' and spon_stat_biogeo.initial_source_field = 'o_spon')
            left join ref_habitats.habref on syn.cd_hab = habref.cd_hab
            left join ref_nomenclatures.t_synonymes as styp
                      on (styp.id_nomenclature = ds.id_nomenclature_source_status and
                          styp.source = 'ODIN' and styp.initial_source_field = 'o_styp')
            left join ref_nomenclatures.t_synonymes as sacq
                      on (sacq.id_nomenclature = syn.id_nomenclature_obs_technique and sacq.source like 'ODIN' and
                          sacq.initial_source_field = 'o_sacq')
            left join ref_nomenclatures.t_synonymes as vali
                      on (vali.id_nomenclature = syn.id_nomenclature_obs_technique and vali.source like 'ODIN' and
                          vali.initial_source_field = 'o_vali')
    where
            la.id_type = ref_geo.get_id_area_type ('COM_ODIN');


select
    count(distinct id_synthese)            count_id_unique
  , count(distinct entity_source_pk_value) count_ent_src_pk_value
  , count(distinct the_geom_local)         count_geom
    from
        gn_synthese.synthese;
/*
+---------------+----------------------+----------+
|count_id_unique|count_ent_src_pk_value|count_geom|
+---------------+----------------------+----------+
|269257         |232988                |22129     |
+---------------+----------------------+----------+
*/

select
    encode(digest(st_astext(the_geom_local), 'sha1'), 'hex')
    from
        gn_synthese.synthese
    limit 10;

select *
    from
        gn_exports.v_odin_situation
    limit 10;

/*
+---------------------------------------------------------+--------+-----------+-----------+--------------------------------------------------------------------+
|o_id                                                     |s_styp  |s_coox     |s_cooy     |geometry                                                            |
+---------------------------------------------------------+--------+-----------+-----------+--------------------------------------------------------------------+
|IDS-SINPBN-PNRNM-aae86fcc21f3bdabc897abccf736874ae8d11e1f|ST_Point|444201.3134|6832589.744|{"type":"Point","coordinates":[-0.466501891777846,48.5429973520288]}|
|IDS-SINPBN-PNRNM-97a823a7ea0fbe8325de5af7b60488f808681f44|ST_Point|451071.9787|6831795.413|{"type":"Point","coordinates":[-0.373048087213763,48.5385344555859]}|
|IDS-SINPBN-PNRNM-a3c1377f073508440e32df008d6760d0a901fb52|ST_Point|445459     |6829442    |{"type":"Point","coordinates":[-0.447618549510936,48.5152034677202]}|
|IDS-SINPBN-PNRNM-75e70d617c7d430720bde9034d156fedd543979b|ST_Point|447929     |6832123    |{"type":"Point","coordinates":[-0.415775498255391,48.5402635666763]}|
|IDS-SINPBN-PNRNM-c518de4927649a1821d788523630f3f1c8ce5076|ST_Point|448314     |6828690    |{"type":"Point","coordinates":[-0.408558034634456,48.5095596379563]}|
|IDS-SINPBN-PNRNM-75e70d617c7d430720bde9034d156fedd543979b|ST_Point|447929     |6832123    |{"type":"Point","coordinates":[-0.415775498255391,48.5402635666763]}|
|IDS-SINPBN-PNRNM-9d5d39821dbaea71b11f4801be2fb3cf545f50c2|ST_Point|445716     |6834490    |{"type":"Point","coordinates":[-0.447124963431927,48.5606711161562]}|
|IDS-SINPBN-PNRNM-f0d7ab71c4fcc04950a6c7610d807ce50efd4014|ST_Point|448954     |6832940    |{"type":"Point","coordinates":[-0.40237983865552,48.5480040805287]} |
|IDS-SINPBN-PNRNM-f01bbda5b1bb1b8f528e42fc76c46fc1a1d82d5c|ST_Point|448879     |6831700    |{"type":"Point","coordinates":[-0.402671303459041,48.5368308113779]}|
|IDS-SINPBN-PNRNM-439698cbcf05c1ec73a2596116a5caebbc281fb3|ST_Point|448354     |6830340    |{"type":"Point","coordinates":[-0.408981108324644,48.5244044011119]}|
+---------------------------------------------------------+--------+-----------+-----------+--------------------------------------------------------------------+
*/
select
    count(*)
  , st_geometrytype(the_geom_point)
    from
        gn_synthese.synthese
    group by
        st_geometrytype(the_geom_point)
;
select
    count(*)
    from
        gn_exports.v_odin_situation
            join gn_exports.v_odin_observations on o_situ = s_id;
;

select *
    from
        gn_exports.v_odin_observations
    where
        o_situ in (select s_id from gn_exports.v_odin_situation limit 10);

select
    count(*)
  , o_lots
  , min(o_date)
  , max(o_date)
  , min()
    from
        gn_exports.v_odin_observations
    group by
        o_lots
    order by
        o_lots;
