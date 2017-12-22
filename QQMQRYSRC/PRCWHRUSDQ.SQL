  select imlbnm,
         immonm,
         substr(imsynm, 1, 50) as Procedure
    from prcwhrusdl
   where trim( imsynm) &COND &PATTERN
order by imsynm, imlbnm, immonm

