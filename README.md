# gn_export4odin_scripts
Scripts de configuration d'exports depuis une base de données GeoNature (v2.6.2) pour la plateforme ODIN (SINP régional de Normandie).

Ce projet contient:
* Une première version de mise en correspondance des nomenclatures GeoNature/ODIN (fichier `00_synonymes.sql`)
* Un script permettant de générer les vues standardisées pour ODIN:
  * `gn_exports.v_odin_situation`, la localisation géographique des données. La précision des données polygonales est faite sur la distance maximale entre le centroid du polygone et sa bordure (noeud le plus éloigné) grâce à la fonction `ref_geo.fct_c_farthest_node_from_centroid_distance`. Les identifiants uniques des localisations, absents dans GeoNature, sont générées par encodage du champ geom avec la fonction suivante `encode(hmac(st_astext(the_geom_local), 'test', 'sha1')`. 
  * `gn_exports.v_odin_ensemble` les relevés (regroupements d'observations).
  * `gn_exports.v_odin_observations` les observations (= une ligne de synthèse GeoNature)
Un script pour peupler la table des exports avec ces 3 vues.

Réalisation:
* [dbWildlife.info](https://github.com/dbwildlife)
* [Parc naturel régional Normandie-Maine](https://www.parc-naturel-normandie-maine.fr/)

Financement:
* [Parc naturel régional Normandie-Maine](https://www.parc-naturel-normandie-maine.fr/)

Partenaire technique:
* [L’ Agence Normande de la Biodiversité](https://www.anbdd.fr/)

[![logo dbWildlife](https://avatars.githubusercontent.com/u/74882019?s=200&v=4)](https://github.com/dbwildlife)

[![logo PnrNM](https://biodiversite.parc-naturel-normandie-maine.fr/geonature/custom/images/logo_structure.png)](https://www.parc-naturel-normandie-maine.fr)

[![logo anbdd](https://www.anbdd.fr/wp-content/themes/anbdd-theme/assets/images/logo-anbdd.svg)](https://www.anbdd.fr/)
