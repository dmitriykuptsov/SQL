SELECT S.PROJECT
FROM GB_SITE AS S
  LEFT JOIN GB_SAMPLE AS SA ON S.SITE_ID = SA.SITE_ID
  LEFT JOIN ST_DESPATCH_SAMPLE DS ON SA.SAMPLE_ID = DS.SAMPLE_ID
  LEFT JOIN ST_RESULT AS R ON DS.SAMPLE_TAG = R.SAMPLE_TAG
GROUP BY S.PROJECT, R.LAB_ELEMENT
ORDER BY S.PROJECT