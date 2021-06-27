insert into
    gn_exports.t_exports (label, view_name, schema_name, id_licence, geometry_field, geometry_srid)
    values
        ('[ODIN] Situation', 'v_odin_situation', 'gn_exports', 3, 'geom', 2154)
      , ('[ODIN] Ensemble', 'v_odin_ensemble', 'gn_exports', 3, null, null)
      , ('[ODIN] Observations', 'v_odin_observations', 'gn_exports', 3, 'geom', 2154)
ON CONFLICT DO NOTHING;
