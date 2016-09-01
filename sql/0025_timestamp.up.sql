alter table fmk.kalk_doks add obradjeno timestamp default now(),
              add korisnik text  default current_user;

alter table fmk.fin_nalog add obradjeno timestamp default now(),
            add korisnik text  default current_user;


alter table fmk.fakt_doks add obradjeno timestamp default now(),
            add korisnik text  default current_user;
