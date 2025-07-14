# Sales Analysis Report

## Overview
This report summarizes key insights from the sales and margin analysis. The findings are based on a detailed review of sales trends, channel and SKU performance, margin analysis and ABC classification. Recommendations are provided for actionable business improvement.

[Dashboard link](https://github.com/KLinh62/WCM-Test/blob/main/Part2-Sales%20Analysis/Question1s/WCM_Sales_Analysis_Dashboard.pbix)

---
## Data Structure & Initial Cleaning 
The dataset consist of 01 table called 'Sales_Data' with a total row count of 48,363 records. The table consists of 7 column: `shipped_date`,  `sku`,	`channel`,	`qty`,	`revenue`,	`cost of good sold`, and	`MOQ order`.

The dataset can be downloaded [here](https://github.com/KLinh62/WCM-Test/blob/main/Part2-Sales%20Analysis/data/WCM_Sales%20Data.csv).

The issue log of data cleaning and transformation can be found [here](https://github.com/KLinh62/WCM-Test/blob/main/Part2-Sales%20Analysis/Question1s/docs/data-cleaning-transformation.png).

The metadata information can be found [here](https://github.com/KLinh62/WCM-Test/blob/main/Part2-Sales%20Analysis/Question1s/docs/data-dictionary.md).

---
## Executive Summary
#### Overview of Findings

This analysis reveals that business performance was overwhelmingly driven by a small set of channels and products, with leading AWH and ADS channels and a small set of top SKUs contributing the majority of sales and profit. While overall margins were positive (10.64%), persistent losses in certain channels (particularly ADI) and some SKUs presented significant risk and require urgent corrective action. The clear seasonality in demand, peaking sharply in Q2 & Q4, and dipping at mid-year, underscored the importance of aligning inventory, marketing, and operational planning with these cycles to maximize growth and minimize missed opportunities. Stakeholders should focus on key channels (AWH, ADS) and key SKUs, urgently addressing sources of loss, and proactively planning for peak periods to ensure sustainable profitability.

Below is the overview page of the Power BI dashboard. The dashboard can be viewed [here](https://github.com/KLinh62/WCM-Test/blob/main/Part2-Sales%20Analysis/Question1s/WCM_Sales_Analysis_Dashboard.pbix).

## Insights Deep Dive
### 1. Overall Sales and Profitability

![sales-performance-overview](https://github.com/KLinh62/WCM-Test/blob/main/Part2-Sales%20Analysis/Question1s/docs/sales_performance_overview.png)

- Over the 1-year period (from Jan 2021 to Jan 2022), the company generated a **total sales of $469.50 million**, **total gross profit of $182.08 million**, total **12.6 million units sold**, covering **661 different SKUs** across all **6 channels**.
  
- The **average gross profit margin stood at 10.64%**. This level of gross margin is quite risky and leaves a thin buffer for unforeseable disruptions. Generally this gross profit margin can be acceptable for high-volume, price-competitive industries like  B2B manufacturing or large-scale distributor/retailer.
  
- The company's sales trend showed **strong seasonality**, with 2 peaks in May and Oct-Dec (likely due to Summer and Winter holidays). The business experienced a mid-year dip around July, suggesting low demand season or operational slowdowns. The sales trend showed an abnormally deep fall in Jan 2022, which was likely due to not having enough data points in that month.
  
- The **revenue and gross profit margin varied significantly over time** across all channels and SKUs.

### 2. Channel Performance
![channel-performance](https://github.com/KLinh62/WCM-Test/blob/main/Part2-Sales%20Analysis/Question1s/docs/channel_performance.png)
- **AWH was the dominant channel**, accounting for **66.8% of total revenue** with **strong gross margins of 30.6%**, and also showed the highest revenue growth over time. Channel **ADS was the secondary channel**, contributing **27.3%** of total sales and **highest profit margin of 31.6%**. Thus the **sales were concentrated on the 2 key channels.** The remaining 4 channels (ADI, FBA, FBM, LAL) contributed very little to overall sales (less than 5% each).
  
- Channel FBA and ADI had **negative gross profit margins** (-3.8% and -664.3% respectively) indicating potential issues like high COGS, underpricing or loss/returns issues.
  
- AWH and ADS were the only channels with significant revenue, and **most of their sales came from A-Class and B-Class items**, respectively. Low-value (C-class) products accounted for only a tiny share of sales in any channel.

### 3. Product Classification 
![product-classification](https://github.com/KLinh62/WCM-Test/blob/main/Part2-Sales%20Analysis/Question1s/docs/product_classification.png)
- According to ABC Analysis, A-class SKUs are the most impactful, with **nearly 70% of the company's sales came from just 69 A-Class SKUs** (10.64% total SKU count). B-Class items acounted for 20.2% of total sales and 13.62% of total SKUs (90 SKUs). C-Class Items were plenty (76% in quantity) but contributed the least value (10.1% of total sales).
  
- While **belonged to A-Class** and generated significant revenue, **some SKUs showed negative profit margins**, which might be due to promotional campains/new product launching (if occurred in short time), or underpricing/high costs issues (if occured persistently).
  
- The top 10 representative SKUs generated *high shares of sales (26.8%, $125.8M)*, and showed much *stronger margins* than the overall margin (31.90% - compared to overall margin 10.64%). The list of Top 10 representative items can be found [here](https://github.com/KLinh62/WCM-Test/blob/main/Part2-Sales%20Analysis/Question1s/docs/top-10-skus.csv).

---

## Actionable Recommendations
Based on the uncovered insights, the below recommendations have been provdided:

- With nearly 95% of sales and the highest margins coming from AWH and ADS, management should prioritize supply chain resources & marketing effort for these 2 channels. **Expanding successful channel strategies from AWH and ADS to other channels where possible could help leverage the business values across the supply chain and mitigate risks if disruptions happen to the key channels**. 

- For underperforming or loss-making channels (expecially ADI) **where profit margins were negative, immediately conduct root cause analysis** of pricing, costs, returns, and operational inefficiencies. **Conider corrective pricing action, cost renegotiation, restructuring of these channels, or even discontinue if turnaround is not feasible in order to avoid continued losses.**

- As 70% of revenue concentrated in just 10% of SKUs, **prioritizing A-Class SKUs and optimize the product portfolio is crucial to maximize business value**. Ensure top-performing A-Class products always have healthy inventory, strong promotion, efficient replenishment cycles; use targeted promotions to drive B-Class' volume; and periodically rationalize or eliminate low-performing SKUs to alleviate resource usage.

- Some A-Class SKUs showed negative or very low margins, indicating the urgent need to **review recent pricing, cost changes, and promotional activities for the underperforming high-value products, and take action accordingly to restore profitability of important SKUs**.

- Aligning inventory and marketing planning with seasonal sales trend could boost sales. **Stock more inventory and run appealing promotions in preparation for peak demand seasons (May, Oct-Dec)** in order to maximize sales and avoid loss reveue from stock-outs. **Scale back during expected low seasons (mid-year dip)** to optimize working capital.

- **Leverage data analytics for proactive, data-driven decision making across the supply chain**. Real-time monitoring of margin, sales, and inventory KPIs by channel and SKU monthly, or using dashboard to flag negative margins can help stakeholders to react quickly and mitigate the risks. Historical data also plays a vital role in demand forecasting, allowinging for proactive inventory policies and supply chain alignment ahead of peak periods.

---

## Assumptions and Caveats:

Throughout the analysis, multiple assumptions were made to manage challenges with the data. These assumptions are noted below:

* Assumption 1: The cost of goods sold and revenue data were missing for some SKUs - this was imputated using the averages of the same SKUs. The revenue and cost of goods varied over time, so we took the averages to have the suitable estimation of the missing information.
    
* Assumption 2: Because about 0.36% of the revenue and quantity columns contained non-sensical values (zero), these were exclued from the analysis.
  
* Assumption 3: The list of 10 representative SKUs was selected based on satisfying 3 criteria: i) belonged to A-Class, ii) topped in sales contribution, and iii) had positive profit margins.
  
* Assumption 4:  When creating the list of 10 representative SKUs, I *did not include items with negative gross profit margins* (regardless of which ABC Class they belonged to). Since I did not know the root cause of the negative margins in some A-class items, doing this would help to safely eliminate items with potential problems from the list of representative SKUs.
