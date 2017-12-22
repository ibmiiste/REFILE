  select b.JCRBNDDIRL,
         b.JCRBNDDIR,
         b.JCRSRVPGML,
         b.JCRSRVPGM,
         exlbnm,
         exmonm,
         substr(exsynm, 1, 50) as Procedure
    from prcwhrfndl, refproced b
   where exsynm=b.JCRPROC
     and b.JCRSRVPGM<>''
     and exlbnm<>'QRPLOBJ'
     and b.JCRSRVPGML<>'QRPLOBJ'
     and b.JCRBNDDIRL<>'QRPLOBJ'
     And trim( exsynm) &COND &PATTERN
order by exsynm, exlbnm, exmonm