/***************************************
	Query Passthrough su TD
	Esempio USER CODE:
	execute (
				replace view &tdStagedb..&table_target. as
				select geography_dim.*
				from &tdStagedb..geography_dim geography_dim
			
		) by teradata;
***************************************/

%macro select;
/************************************
			BEGIN USER CODE 
************************************/


execute (
        replace view &tdStagedb..&table_target. as
        select R_REPORTING_SLR_GRP.*
        from P_KGU_LIS_SVA.R_REPORTING_SLR_GRP  R_REPORTING_SLR_GRP
      
    ) by teradata;







/************************************
			END USER CODE 
************************************/
%mend;