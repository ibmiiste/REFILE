  select exlbnm,
         exmonm,
         substr(exsynm, 1, 50) as Procedure
    from prcwhrfndl
   where trim( exsynm) &COND &PATTERN
order by exsynm, exlbnm, exmonm

