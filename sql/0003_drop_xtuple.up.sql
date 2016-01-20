set search_path to public;
drop table acalitem        CASCADE;
drop table accnt           CASCADE;
drop table addr            CASCADE;
drop table alarm           CASCADE;
drop table apaccnt         CASCADE;
drop table apapply         CASCADE;
drop table apcreditapply   CASCADE;
drop table apopen          CASCADE;
drop table apopentax       CASCADE;
drop table apselect        CASCADE;
drop table araccnt         CASCADE;
drop table arapply         CASCADE;
drop table arcreditapply   CASCADE;
drop table aropen          CASCADE;
drop table aropenalloc     CASCADE;
drop table aropentax       CASCADE;
drop table asohist         CASCADE;
drop table asohisttax      CASCADE;
drop table atlasmap        CASCADE;
drop table backup_usr      CASCADE;
drop table bankaccnt       CASCADE;
drop table bankadj         CASCADE;
drop table bankadjtype     CASCADE;
drop table bankrec         CASCADE;
drop table bankrecitem     CASCADE;
drop table bomhead         CASCADE;
drop table bomitem         CASCADE;
drop table bomitemsub      CASCADE;
drop table bomwork         CASCADE;
drop table budghead        CASCADE;
drop table budgitem        CASCADE;
drop table calhead         CASCADE;
drop table cashrcpt        CASCADE;
drop table cashrcptitem    CASCADE;
drop table cashrcptmisc    CASCADE;
drop table ccard           CASCADE;
drop table ccardaud        CASCADE;
drop table ccbank          CASCADE;
drop table ccpay           CASCADE;
drop table char            CASCADE;
drop table charass         CASCADE;
drop table charopt         CASCADE;
drop table checkhead       CASCADE;
drop table checkitem       CASCADE;
drop table classcode       CASCADE;
drop table cmd             CASCADE;
drop table cmdarg          CASCADE;
drop table cmhead          CASCADE;
drop table cmheadtax       CASCADE;
drop table cmitem          CASCADE;
drop table cmitemtax       CASCADE;
drop table cmnttype        CASCADE;
drop table cmnttypesource  CASCADE;
drop table cntct           CASCADE;
drop table cntctaddr       CASCADE;
drop table cntctdata       CASCADE;
drop table cntcteml        CASCADE;
drop table cntctmrgd       CASCADE;
drop table cntctsel        CASCADE;
drop table cntslip         CASCADE;
drop table cobill          CASCADE;
drop table cobilltax       CASCADE;
drop table cobmisc         CASCADE;
drop table cobmisctax      CASCADE;
drop table cohead          CASCADE;
drop table cohist          CASCADE;
drop table cohisttax       CASCADE;
drop table coitem          CASCADE;
drop table comment         CASCADE;
drop table company         CASCADE;
drop table costcat         CASCADE;
drop table costelem        CASCADE;
drop table costhist        CASCADE;
drop table costupdate      CASCADE;
drop table country         CASCADE;
drop table crmacct         CASCADE;
drop table crmacctsel      CASCADE;
drop table curr_rate       CASCADE;
drop table curr_symbol     CASCADE;
drop table custform        CASCADE;
drop table custgrp         CASCADE;
drop table custgrpitem     CASCADE;
drop table custinfo        CASCADE;
drop table custtype        CASCADE;
drop table dept            CASCADE;
drop table destination     CASCADE;
drop table docass          CASCADE;
drop table emp             CASCADE;
drop table empgrp          CASCADE;
drop table empgrpitem      CASCADE;
drop table evntlog         CASCADE;
drop table evntnot         CASCADE;
drop table evnttype        CASCADE;
drop table expcat          CASCADE;
drop table filter          CASCADE;
drop table flcol           CASCADE;
drop table flgrp           CASCADE;
drop table flhead          CASCADE;
drop table flitem          CASCADE;
drop table flnotes         CASCADE;
drop table flrpt           CASCADE;
drop table flspec          CASCADE;
drop table form            CASCADE;
drop table freightclass    CASCADE;
drop table glseries        CASCADE;
drop table gltrans         CASCADE;
drop table grp             CASCADE;
drop table grppriv         CASCADE;
drop table hnfc            CASCADE;
drop table image           CASCADE;
drop table imageass        CASCADE;
drop table incdt           CASCADE;
drop table incdtcat        CASCADE;
drop table incdthist       CASCADE;
drop table incdtpriority   CASCADE;
drop table incdtresolution CASCADE;
drop table incdtseverity   CASCADE;
drop table invbal          CASCADE;
drop table invchead        CASCADE;
drop table invcheadtax     CASCADE;
drop table invcitem        CASCADE;
drop table invcitemtax     CASCADE;
drop table invcnt          CASCADE;
drop table invdetail       CASCADE;
drop table invhist         CASCADE;
drop table ipsass          CASCADE;
drop table ipsfreight      CASCADE;
drop table ipshead         CASCADE;
drop table ipsitemchar     CASCADE;
drop table ipsiteminfo     CASCADE;
drop table ipsprodcat      CASCADE;
drop table item            CASCADE;
drop table itemalias       CASCADE;
drop table itemcost        CASCADE;
drop table itemgrp         CASCADE;
drop table itemgrpitem     CASCADE;
drop table itemloc         CASCADE;
drop table itemlocdist     CASCADE;
drop table itemlocpost     CASCADE;
drop table itemsite        CASCADE;
drop table itemsrc         CASCADE;
drop table itemsrcp        CASCADE;
drop table itemsub         CASCADE;
drop table itemtax         CASCADE;
drop table itemtrans       CASCADE;
drop table itemuom         CASCADE;
drop table itemuomconv     CASCADE;
drop table jrnluse         CASCADE;
drop table labeldef        CASCADE;
drop table labelform       CASCADE;
drop table lang            CASCADE;
-- drop table locale          CASCADE;
drop table location        CASCADE;
drop table locitem         CASCADE;
drop table metasql         CASCADE;
drop table metric          CASCADE;
drop table metricenc       CASCADE;
drop table mrghist         CASCADE;
drop table mrgundo         CASCADE;
drop table msg             CASCADE;
drop table msguser         CASCADE;
drop table obsolete_tax    CASCADE;
drop table ophead          CASCADE;
drop table opsource        CASCADE;
drop table opstage         CASCADE;
drop table optype          CASCADE;
drop table orderseq        CASCADE;
drop table pack            CASCADE;
drop table payaropen       CASCADE;
drop table payco           CASCADE;
drop table period          CASCADE;
drop table pkgdep          CASCADE;
drop table pkghead         CASCADE;
drop table pkgitem         CASCADE;
drop table plancode        CASCADE;
drop table pohead          CASCADE;
drop table poitem          CASCADE;
drop table poreject        CASCADE;
drop table potype          CASCADE;
drop table pr              CASCADE;
drop table prftcntr        CASCADE;
drop table priv            CASCADE;
drop table prj             CASCADE;
drop table prjtask         CASCADE;
drop table prjtaskuser     CASCADE;
drop table prodcat         CASCADE;
drop table prospect        CASCADE;
drop table qryhead         CASCADE;
drop table qryitem         CASCADE;
drop table quhead          CASCADE;
drop table quitem          CASCADE;
drop table rcalitem        CASCADE;
drop table recur           CASCADE;
drop table recurtype       CASCADE;
drop table recv            CASCADE;
drop table report          CASCADE;
drop table rjctcode        CASCADE;
drop table rsncode         CASCADE;
drop table sale            CASCADE;
drop table salesaccnt      CASCADE;
drop table salescat        CASCADE;
drop table salesrep        CASCADE;
drop table script          CASCADE;
drop table sequence        CASCADE;
drop table shift           CASCADE;
drop table shipchrg        CASCADE;
drop table shipdata        CASCADE;
drop table shipdatasum     CASCADE;
drop table shipform        CASCADE;
drop table shiphead        CASCADE;
drop table shipitem        CASCADE;
drop table shiptoinfo      CASCADE;
drop table shipvia         CASCADE;
drop table shipzone        CASCADE;
drop table sitetype        CASCADE;
drop table sltrans         CASCADE;
drop table source          CASCADE;
drop table state           CASCADE;
drop table status          CASCADE;
drop table stdjrnl         CASCADE;
drop table stdjrnlgrp      CASCADE;
drop table stdjrnlgrpitem  CASCADE;
drop table stdjrnlitem     CASCADE;
drop table subaccnt        CASCADE;
drop table subaccnttype    CASCADE;
drop table tax             CASCADE;
drop table taxass          CASCADE;
drop table taxauth         CASCADE;
drop table taxclass        CASCADE;
drop table taxhist         CASCADE;
drop table taxrate         CASCADE;
drop table taxreg          CASCADE;
drop table taxtype         CASCADE;
drop table taxzone         CASCADE;
drop table terms           CASCADE;
drop table todoitem        CASCADE;
drop table trgthist        CASCADE;
drop table trialbal        CASCADE;
drop table uiform          CASCADE;
drop table uom             CASCADE;
drop table uomconv         CASCADE;
drop table uomtype         CASCADE;
drop table url             CASCADE;
drop table usr_bak         CASCADE;
-- drop table usrgrp          CASCADE;
-- setUserPreference
-- drop table usrpref         CASCADE;
-- drop table usrpriv         CASCADE;
drop table vendaddrinfo    CASCADE;
drop table vendinfo        CASCADE;
drop table vendtype        CASCADE;
drop table vodist          CASCADE;
drop table vohead          CASCADE;
/* drop table voheadtax       CASCADE; */
drop table voitem          CASCADE;
-- drop table voitemtax       CASCADE;
drop table whsezone        CASCADE;
drop table whsinfo         CASCADE;
drop table wo              CASCADE;
drop table womatl          CASCADE;
drop table womatlpost      CASCADE;
drop table womatlvar       CASCADE;
drop table xsltmap         CASCADE;
drop table yearperiod      CASCADE;
