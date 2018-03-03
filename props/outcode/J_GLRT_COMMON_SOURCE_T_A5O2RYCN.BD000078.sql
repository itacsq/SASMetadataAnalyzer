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

execute(
   replace view &tdStagedb..US_Distinct_NOCFL as
   (
     select distinct 
       cast(SK_ID_NOCFL as varchar(20)) as SK_ID_NOCFL, 
       TEMPLATE_ROW_CD
      from &tdStagedb..US_TEMPLATE_DD_NEW_VLD
)   
) by teradata;

execute(replace view &tdStagedb..US_Distinct_NOCFL1 as
  (
    select distinct SK_ID_NOCFL,
	  cast(oreplace(trim(cast(min(case when trim(TEMPLATE_ROW_CD)='010'    then 1 else null end) as varchar(1))),'1','010')    as varchar(3)) as FLG_010,
	  cast(oreplace(trim(cast(min(case when trim(TEMPLATE_ROW_CD)='010b.2' then 2 else null end) as varchar(1))),'2','010b.2') as varchar(6)) as FLG_010b2,
      cast(oreplace(trim(cast(min(case when trim(TEMPLATE_ROW_CD)='010b'   then 3 else null end) as varchar(1))),'3','010b')   as varchar(4)) as FLG_010b,
      cast(oreplace(trim(cast(min(case when trim(TEMPLATE_ROW_CD)='010c.1' then 1 else null end) as varchar(1))),'1','010c.1') as varchar(6)) as FLG_010c1,
      cast(oreplace(trim(cast(min(case when trim(TEMPLATE_ROW_CD)='010c.6' then 1 else null end) as varchar(1))),'1','010c.6') as varchar(6)) as FLG_010c6
	from &tdStagedb..US_Distinct_NOCFL
	group  by SK_ID_NOCFL
  )
 
) by teradata;


execute (
				  replace view &tdStagedb..&table_target as
(			

SELECT	cast(t1.SK_ID_NOCFL as VARCHAR(20)) SK_ID_NOCFL, GLRT_SOURCE_CD, PROVIDER_CD, LEGAL_ENTITY_CD,
		INSERT_TS, PERIMETER_CD, DEAL_SK_ID, BALANCE_SHEET_ITEM_CD, SIGN WTE_SIGN,
		ISIN_NUM, OPERATION_TYPE_CD, PRODUCT_CD, CURRENCY_CD, COUNTERPARTY_CD,
		INTRAGROUP_COUNTERPARTY_IND, INTRAGROUP_COUNTERPARTY_CD, B3_COUNTERPARTY_TYPE_CD,
		COUNTERPARTY_COUNTRY_CD, ORIGINAL_MATURITY_CD, FINREP_CPARTY_TYPE_CD,
		FINREP_PRODUCT_TYPE_CD, RELATIONSHIP_IND, INSURED_IND, PREPAY_CLAUSE_IND,
		NOTICE_DAYS_NUM, TRANSACTIONAL_IND, SECURITY_LENDING_IND, COLLATERAL_CD,
		PHANTOM_LIABILITY_IND, COLLATERAL_PLATFORM_CD, OPERATIONAL_IND,
		COLLATERAL_MATURITY_DT, CAT_DEPO_DIFF_OUTFLOWS_CD, PHANTOM_CD,
		SPV_FLG, EVIDENCE_FLG, SPEC_DEBT_TYPE_CD, DERIVATIVE_CONTRACT_TYPE_CD,
		QUOTATION_CD, SETTLEMENT_TYPE_CD, FLOW_CRNCY_CD, COLLATERALIZED_DERIVATIVE_IND,
		CONTRACT_MAT_DT, CENTRAL_CPARTY_FLG, NETTING_FLG, LEG, COMM_CPARTY_TYPE_CD,
		SETTLEMENT_DT, CONTRACT_MATURITY_DT, TRANSACTION_TYPE_CD, TOBE_RECEIVED_CCY_CD,
		TOBE_DELIVERED_CCY_CD, RETAIL_IND, OWNER_EARLY_EXERCISE_OPT_IND,
		MORTGAGE_TYPE_CD, GUARANTEE_TYPE_CD, GUARANTEE_CODE_CD, GUARANTEE_MATURITY_CD,
		ASSET_CLASS_CD, SPV_IND, SECURITIZATION_IND, OPERATIONAL_TYPE_CD,
		MAT_TYPE_CD, SPEC_CREDIT_TYPE_CD, ELG_CREDIT_CLAIM_FLG, CLEARING_HOUSE_FLG,
		CREDIT_STATUS_CD, COLLATERALIZED_TYPE_CD, MARGIN_CALL_TYPE_CD,
		LEGAL_OWNERSHIP_FLG, FIELD_CD, INSTRUMENT_TYPE_CD WTE_INSTRUMENT_TYPE_CD, CREDIT_LINE_TYPE_CD,
		SPEC_OFF_BAL_TYPE_CD, SIDE_CD, REG_CPARTY_FLG, LOCAL_CURRENCY_IND,
		SECURITY_LENDING_CCY_CD, LIQUIDITY_PORTFOLIO_IND, SECURITY_LENDING_TYPE_CD,
		COUNTERPARTY_RWA_PCT, SECURITY_TYPE_CD CONTRACT_TYPE_CD, FIRST_NOTICE_DATE_CD,
		RWA_B2_STAND_APPR_PCT, COLLATERAL_TYPE_CD, CATEGORY_CD, CATEGORY_NUM,
		CATEGORY_DESC, CATEGORY_TYPE, SIGN_OF_TRANSACTION_CD, RATIO_CD,
		EBA_FP_CODE, INTRAGROUP_CPARTY_FLG, INTRAGROUP_CPARTY_CD, TEMPLATE_CD,
		VALUE_TYPE_CD, ALMT_MATURITY_CD, REPORT_DT, SOURCE_CD, REFERENCE_DT,
		FREQ_CD, ORIGINAL_REFERENCE_DT, SCENARIO_CD, SUBSCENARIO_CD,
		CFL_DATE_RICALCOLATA, TIME_BUCKET_CD, FLOW_TYPE_CD, COUNTERPARTY_DESC,
		GROSS_CARRYING_VAL_AMT, NOMINAL_AMT, NOMINAL_CCY_AMT, CARRYING_VALUE_AMT,
		BUCKET_TYPE_AMT, QIS_KEY, DQ_KEY, PAY_BUCKET_CD, PAY_AMT, CARRYING_VAL_EUR_AMT,
		NOMINAL_HOLD_AMT, NOMINAL_HOLD_CCY_AMT, INSURED_AMT, INSURED_PCT,
		TOBE_RECEIVED_CCY_AMT, TOBE_RECEIVED_AMT, TOBE_DELIVERED_CCY_AMT,
		TOBE_DELIVERED_AMT, TRANSACT_SPOT_CTRVL_AMT, TRANS_SPOT_CNTRVAL_CRNCY_AMT,
		FV_EUR_AMT, FV_CRNCY_AMT, FUND_WRITEDOWN_AMT, HAIRCUT_PCT, FIELD_AMT,
		NOMINAL_UNDRAWN_AMT, NOMINAL_UNDRAWN_CCY_AMT, ORIGINATOR_IND,
		SELF_SECURITIZATION_IND, FAIR_VALUE_AMT, EQUIVALENT_COUNTERVALUE_AMT,
		FV_ISSUING_CCY_AMT, COLLATERAL_CASH_AMT, SECURITY_DESC, SECURITY_MATURITY_DT,
		CALLABLE_IND, PUTABLE_IND, STRUCTURED_IND, SUBORDINATED_IND,
		GUARANTEE_IND, ISSUER_CD, ISSUER_DESC, INTRAGROUP_ISSUER_IND,
		SUBCONSOLIDATED_ISSUER_CD, B3_ISSUER_TYPE_CD, ISSUER_COUNTRY_CD,
		ISSUANCE_RATING_CD, GUARANTOR_CD, GUARANTOR_TYPE_CD, GUARANTOR_COUNTRY_CD,
		ELIGIBILITY_IND, BANK_ELIGIBILITY_CD, EQUITY_INDEX_IND, PRICE_AMT,
		POOL_FACTOR_AMT, INTRAGROUP_ISSUER_CD, COVERED_BOND_HAIRCUT_PCT,
		CENTRAL_BANK_HAIRCUT_PCT, TRANCHE_ABS_CD, OPERATION_CD, RATING_TYPE_CD,
		LIQ_CREDIT_QUALITY_CD, SPECIFIC_ISSUER_CD, SPECIFIC_GUARANTOR_CD,
		CIU_UNDER_ASSET_TYPE_CD, GUAR_ASSET_FLG, INFRA_ORIG_ASSET_FLG,
		FULL_REC_FLG, LOAN_TO_VALUE_PCT, PART_RETAINER_FLG, WAL_DT, ISSUED_DT,
		FINREP_ISSUING_TYPE_CD, FINREP_GUA_TYPE_CD, EQUIVALENT_CNTRVAL_CCY_AMT,
		FV_HEDGING_DERIVATIVES_AMT, COLLATERAL_USED_AMT, COLLATERAL_REC_AMT,
		RECORD_ID, DEPOSITED_AMT, ENCUMBERED_AMT, UNENCUMBERED_AMT, ON_BALANCE_FLOW_AMT,
		CB_HAIRCUT_PCT, ON_BALANCE_FLOW_NOMINAL_AMT, FUND_SEC_LEND_AMT,
		UNSEC_LEND_AMT, PCT, AMOUNT, COMM_TYPE_CD, COMM_CTP_CD, COMM_PRODUCT_CD,
		PROJ_EXPIRED_IND, ORIGINAL_WAL_DT, PROJ_WAL, ORIGINAL_CARRYING_VALUE,
		ORIGINAL_FAIR_VALUE_AMT, ORIGINAL_NOMINAL_AMT, ORIGINAL_FFV,
		ORIGINAL_CONTRACT_MATURITY, DIM_BSI_SCHEMA_CD, DIM_BSI_SCHEMA_DESC,
		DIM_BSI_SIGN_CD, AF11_SECURITY_DESC, AF11_SECURITY_TYPE_CD, AF11_CURRENCY_CD,
		AF11_SUBORDINATED_IND, AF11_ISSUER_CD, AF11_ISSUER_DESC, AF11_INTRAGROUP_ISSUER_IND,
		AF11_B3_ISSUER_TYPE_CD, AF11_ISSUER_COUNTRY_CD, AF11_ISSUANCE_RATING_CD,
		AF11_EQUITY_INDEX_IND, AF11_INTRAGROUP_ISSUER_CD, AF11_OPERATION_CD,
		AF11_ASSET_CLASS_CD, AF11_LIQ_CREDIT_QUALITY_CD, AF11_FINREP_ISSUING_TYPE_CD,
		AF11_SECURITY_MATURITY_DT, AF11_CALLABLE_IND, AF11_PUTABLE_IND,
		AF11_FIRST_NOTICE_DATE_CD, AF11_STRUCTURED_IND, AF11_GUARANTEE_IND,
		AF11_SUBCONSOLIDATED_ISSUER_CD, AF11_RWA_B2_STAND_APPR_PCT, AF11_GUARANTOR_CD,
		AF11_GUARANTOR_TYPE_CD, AF11_GUARANTOR_COUNTRY_CD, AF11_ELIGIBILITY_IND,
		AF11_BANK_ELIGIBILITY_CD, AF11_PRICE_AMT, AF11_POOL_FACTOR_AMT,
		AF11_COVERED_BOND_HAIRCUT_PCT, AF11_MORTGAGE_TYPE_CD, AF11_CENTRAL_BANK_HAIRCUT_PCT,
		AF11_TRANCHE_ABS_CD, AF11_RATING_TYPE_CD, AF11_SPECIFIC_ISSUER_CD,
		AF11_SPECIFIC_GUARANTOR_CD, AF11_CIU_UNDER_ASSET_TYPE_CD, AF11_GUAR_ASSET_FLG,
		AF11_INFRA_ORIG_ASSET_FLG, AF11_FULL_REC_FLG, AF11_LOAN_TO_VALUE_PCT,
		AF11_PART_RETAINER_FLG, AF11_COMM_CPARTY_TYPE_CD, AF11_WAL_DT,
		AF11_ISSUED_DT, AF11_FINREP_GUA_TYPE_CD, AF11_CALC_ORIGINAL_MATURITY_CD,
		AF11_INTRAGROUP_ISSUER_DESC, SEC_CAT_ID_BB_GLOBAL, SEC_CAT_DA_CAT_TYPE,
		SEC_CAT_B3_CAT_TYPE, SEC_CAT_B3_EXP_TYPE, SEC_CAT_COND, SEC_CAT_DA_CAT_NUM,
		SEC_CAT_DA_CAT_CD, SEC_CAT_DA_CAT_DES, SEC_CAT_DA_ITS_ROW_NUM,
		SEC_CAT_ISO_CURRENCY_CD, SEC_CAT_LE_ISO_COUNTRY_CD, AF31_NOMINAL_AMT,
		AF31_INSURED_AMT, AF31_INSURED_PCT, DIM_FB_BRANCH_DESC, DIM_FB_LE_CD,
		DIM_FB_LE_DESC, DIM_FB_LE_ISO_COUNTRY_CD, DIM_FB_SUBCONSOLIDATED_CD,
		DIM_FB_SUBCONSOLIDATED_DESC, DIM_FB_CONSOLIDATED_CD, DIM_FB_CONSOLIDATED_DESC,
		DIM_FB_REPORTING_BANK_CD, DIM_FB_IN_BRANCH_DESC, DIM_FB_IN_LE_CD,
		DIM_FB_IN_LE_DESC, DIM_FB_IN_LE_ISO_COUNTRY_CD, DIM_FB_IN_SUBCONSOLIDATED_CD,
		DIM_FB_IN_SUBCONSOLIDATED_DESC, DIM_FB_IN_CONSOLIDATED_CD, DIM_FB_IN_CONSOLIDATED_DESC,
		DIM_FB_IN_REPORTING_BANK_CD, PERIMETER_I_IND, PERIMETER_S_IND,
		PERIMETER_C_IND, PERIMETER_X_IND, PERIMETER_COUNTRY_IND, AMLT41_NOMINAL_HOLD_AMT_PER_I,
		AMLT41_NOMINAL_AMT_PER_I, AMLT41_HOLDING_PCT_PER_I, AMLT41_NOMINAL_HOLD_AMT_PER_S,
		AMLT41_NOMINAL_AMT_PER_S, AMLT41_HOLDING_PCT_PER_S, AMLT41_NOMINAL_HOLD_AMT_PER_C,
		AMLT41_NOMINAL_AMT_PER_C, AMLT41_HOLDING_PCT_PER_C, AF2_ORIGINATOR_IND,
		AF2_SELF_SECURITIZATION_IND, AF4_RETAIL_IND, SUM_ALL_BUCKET_AMT,
		SUM_CF_BUCKET_AMT, COUNT_ALL_BUCKETS, COUNT_CF_BUCKETS, SUM_ABS_BUCKET_AMT,
		SUM_BUCKET_AMT_SCAD_0_6, SUM_BUCKET_AMT_SCAD_6_12, SUM_BUCKET_AMT_SCAD_12_OVER,
		SUM_BUCKET_30DAYS, BUCKET_30DAYS_EXPIRED_IND, US_MATURITY_CD,
		US_COUNTRY_CD, US_COUNTRY_DESC COUNTRY_DESC, US_INDIVIDUAL_LE_CD, US_CONSOLIDATED_LE_CD,
		US_INDIVIDUAL_PERIM_IND, US_CONSOLIDATED_PERIM_IND, US_INTRAGROUP_COUNTRY_CD INTRAGROUP_COUNTRY_CD,
		US_INTRAGROUP_COUNTRY_DESC INTRAGROUP_COUNTRY_DESC, QIS_CAT_CD, QIS_CAT_DES, QIS_LEVEL,
		NSFR_CLUSTER_CD, NSFR_INDIVIDUAL_LE_CD, NSFR_CONSOLIDATED_LE_CD,
		NSFR_INDIVIDUAL_PERIM_IND, NSFR_CONSOLIDATED_PERIM_IND, NSFR_MANUAL_DATA_INPUT_VALUE,
		NSFR_ISIN_CAP_EX_SUB_TYPE, NSFR_POOLF_OBFNA_GIVE_0_6, NSFR_POOLF_OBFNA_GIVE_6_12,
		NSFR_POOLF_OBFNA_GIVE_12_OVER, NSFR_POOLF_OBFNA_RECEIVE_TOT,
		NSFR_POOLF_CCL_CAT_CD, MIN_GROSS_CARRYING_VAL_AMT, MIN_NOMINAL_AMT,
		MIN_CARRYING_VALUE_AMT, MIN_FAIR_VALUE_AMT, MIN_ENCUMBERED_AMT,
		MIN_UNENCUMBERED_AMT,
      '"'||t2.FLG_010||'","'||t2.FLG_010b2||'","'||t2.FLG_010b||'","'||t2.FLG_010c1||'","'||t2.FLG_010c6||'"' as TEMPLATE_ROW_FLG
FROM	P_KGU_GLM_UES.GLRT_COMMON_SOURCE_V t1 left join &tdStagedb..US_Distinct_NOCFL1 t2
        on cast(t1.SK_ID_NOCFL as VARCHAR(20))=t2.SK_ID_NOCFL
)          
)  by teradata;

/************************************
			END USER CODE 
************************************/
%mend;