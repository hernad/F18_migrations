drop view fmk.v_fin_suban_list_all;
update fmk.fin_suban set rbr='0' where rbr='****';
alter table fmk.fin_suban alter rbr type integer using rbr::integer;
