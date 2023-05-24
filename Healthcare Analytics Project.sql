use health_project;

# Project Name - Dialysis of Patients
# Domain - Healthcare

####################################################################################################################

												####  KPI 1 - Number of Patients across various summaries  ###

SELECT SUM(Number_of_patients_included_in_the_transfusion_summary) AS "Patients in the Transfuion",
              SUM(Number_of_patients_in_hypercalcemia_summary) AS "Patients in hypercalcemia Summary",
              SUM(Number_of_patients_in_Serum_phosphorus_summary) AS "Patients in Serum Phosphorus Summary",
              SUM(Number_of_patients_included_in_hospitalization_summary) AS "Patients included in Hospitalization Summary",
              SUM(Number_of_Patients_included_in_survival_summary) AS "Patients included in survival Summary",
              SUM(Number_of_Patients_included_in_fistula_summary) AS "Patients included in fistula Summary",
              SUM(Number_of_patients_in_long_term_catheter_summary) AS "Patients in long term Catheter Summary",
              SUM(Number_of_patients_in_nPCR_summary) AS "Patients in nPCR Summary"
              FROM DATASET;
              
####################################################################################################################

																		####  KPI 2 - Network wise Profit & Non-Profit  ###

SELECT Network, SUM(CASE WHEN Profit_or_Non_Profit = "Profit" THEN 1 ELSE 0 END) AS "Total Profit Count" ,
                           SUM(CASE WHEN Profit_or_Non_Profit = "Non-Profit" THEN 1 ELSE 0 END) AS "Total Non Profit Count" 
FROM DATASET GROUP BY Network ORDER BY Network ;

####################################################################################################################

								####  KPI 3 - Top 5 Chain Organizations w.r.t. Total Performance Score as No Score  ###

SELECT DENSE_RANK() OVER (ORDER BY COUNT(Total_Performance_Score) DESC) AS "Rank" ,
Chain_Organization, COUNT(Total_Performance_Score) AS "Total Performance Score"
 FROM DATASET 
WHERE Total_Performance_Score = "No Score"
GROUP BY Chain_Organization;

####################################################################################################################

															####  KPI 4 - City wise top 10 No. of Dialysis Station   ###

SELECT DENSE_RANK() OVER (ORDER BY SUM(No_of_Dialysis_Stations) DESC) AS "Rank",
City, SUM(No_of_Dialysis_Stations) AS "Total of Dialysis Stations" 
FROM DATASET
GROUP BY City
LIMIT 10;

####################################################################################################################

															####  KPI 5 - No. of Category Text w.r.t As Expected   ###

SELECT SUM(CASE WHEN Patient_Transfusion_category_text = "As Expected" THEN 1 ELSE 0 END) AS "Patient Transfusion Category Text",
			  SUM(CASE WHEN Patient_hospitalization_category_text = "As Expected" THEN 1 ELSE 0 END) AS "Patient Hospitalization Category Text",
               SUM(CASE WHEN Patient_Survival_Category_Text = "As Expected" THEN 1 ELSE 0 END) AS "Patient Survival Category Text",
               SUM(CASE WHEN Patient_Infection_category_text = "As Expected" THEN 1 ELSE 0 END) AS "Patient Infection Category Text",
               SUM(CASE WHEN Fistula_Category_Text = "As Expected" THEN 1 ELSE 0 END) AS "Fistula Category Text ",
               SUM(CASE WHEN SWR_category_text = "As Expected" THEN 1 ELSE 0 END) AS "SWR Category Text",
               SUM(CASE WHEN PPPW_category_text = "As Expected" THEN 1 ELSE 0 END) AS "PPPW Category Text "
FROM DATASET;

####################################################################################################################

															####  KPI 6 - Average Payment Reduction Rate   ###

SELECT CONCAT("The Average Payment Reduction Rate is ", ROUND(AVG(PY2020_Payment_Reduction_Percentage), 4), " %")AS "Average Payment Reduction Rate"
FROM DATASET;