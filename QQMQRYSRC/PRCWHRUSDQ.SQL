  select b.JCRBNDDIRL,
         b.JCRBNDDIR,
         b.JCRSRVPGML,
         JCRSRVPGM,
         imlbnm,
         immonm,
         substr(imsynm, 1, 50) as Procedure
    from prcwhrusdl, REFPROCED b
   where IMSYNM=b.JCRPROC
     and b.JCRSRVPGM<>''
     and imlbnm<>'QRPLOBJ'
     and trim( imsynm) &COND &PATTERN
order by imsynm, imlbnm, immonm

