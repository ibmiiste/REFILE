delete
  from prcwhrusdp
 where imsyty <> '0'
    or imsynm not in ( select exsynm
                         from prcwhrfndp)
