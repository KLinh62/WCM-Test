# 🧪 WCM Planning & Data Test 🧪

# 🚅 Part 1 - SC Case Study

## Case No. 1

### Question 1

**Approach:**  
This is a simple deterministic flow shop problem with fixed nodes and no job prioritization, so we can go with direct time-based analysis (track completion time).

**Assumption:**  
Assume that the product goes straight into the next process (if the next process is available, no waiting time). A process starts when it’s free and a product goes into the WIP bucket in front of that process.

*At initial stage* t = 0, there are:
- 100 products waiting in front of P1.
- 3 products waiting in front of P4 (ready to be processed by P4)

***For the initial 3 WIPs before P4:***
At t = 0, P4 is free.

| Product No. | Process time T4 (s) | Start time (s) | Finish time (s) |
|-------------|---------------------|----------------|-----------------|
| 1           | 7                   | 0              | 0 + 7 = 7       |
| 2           | 7                   | 7              | 7 + 7 = 14      |
| 3           | 7                   | 14             | 14 + 7 = 21     |

Thus, 3 units are finished by t = 21 seconds due to initial WIP at P4. In other words, P4 is busy for the first 21 seconds.

***For the initial 100 WIPs before P1:***

Set:

- $\ C_{i,j} \$: be the completion time of product j at process i.
- $\ S_{i,j} \$: be the start time of product j at process i.
- $\ 1 \leq j \leq 100,\ 1 \leq i \leq 4 \$

Constraints:
- There are 2 scenarios that can happen with the start time of product j at process i.
  The start time of product j at process i can either be the completion time of item j at the previous process node, or the completion time of the previous product at the current process node i, depending on which one finishes later (to ensure the process node i is free when starting to take in a new product).

  $$\ 
  S_{i,j} = \max(C_{i-1, j},\ C_{i, j-1}) 
  \$$

- The completion time of product \( j \) at process \( i \):

  $$\ 
  C_{i,j} = S_{i,j} + T_{i} 
  \$$

See the time-trace table [here](https://docs.google.com/spreadsheets/d/1gzD-cnGmx3zbf4JzzgXMqsRsAYe7YhwfwTNfH3JJKGY/edit?gid=0#gid=0).

#### For \( j = 8 \):

|        | (1,8) | (2,8) | (3,8) | (4,8) |
|--------|-------|-------|-------|-------|
| **Processing time $\( T_i \$)**    | 5   | 10  | 8   | 7   |
| **Start time $\( S_{i,j} \$)**     | 35  | 75  | 85  | 93  |
| **Completion time $\( C_{i,j} \$)**| 40  | 85  | 93  | 100 |

*After 100 seconds:*

- From initial 3 WIP before P4: 3 products are finished independently after the first 21 seconds.
- From initial WIP before P1: 8 products are finished after 100 seconds.

**Total:** \( 8 + 3 = 11 \) products are finished after 100 seconds.


---
### Question 2

We need to find the number of products that have **completed P2 but not started P3 at t = 100s**.

From the time-trace table:

#### For \( j = 9 \):

|        | (1,9) | (2,9) | (3,9) | (4,9) |
|--------|-------|-------|-------|-------|
| **Processing time $\( T_i \$)** | 5     | 10    | 8     | 7     |
| **Start time \$( S_{i,j} \$)**  | 40    | 85    | 95    | 103   |
| **Completion time \$( C_{i,j} \$)** | 45 | 95    | 103   | 110   |

#### For \( j = 10 \):

|        | (1,10) | (2,10) | (3,10) | (4,10) |
|--------|--------|--------|--------|--------|
| **Processing time $\( T_i \$)** | 5      | 10     | 8      | 7      |
| **Start time $\( S_{i,j} \$)**  | 45     | 95     | 105    | 113    |
| **Completion time $\( C_{i,j} \$)** | 50 | 105    | 113    | 120    |


- **Product 9:** P2 completes at 95s, P3 starts at 95s (assuming no waiting time between processes).
- **Product 10:** P2 completes at 105s (> 100s).

**Conclusion:** WIP level between P2 and P3 at t = 100s is 0.

---

### Question 3

#### Let:

- $\ N = \{1,2,3,4\} \$: the set of stations
- $\ E \subseteq N \times N \$: the subset of all possible directed arcs (allowed non-sequential connections between stations)
- $\ P_i \$: processing time at station $\ i \$
- $\ T \$: required system throughput ( = 16.6 products/sec)
- $\ W \$: max allowed WIP before any station \( = 10 \)

#### Decision Variables

- $\ S_i \in \mathbb{Z}_+ \$: number of parallel stations at process i (a positive integer)
- $\ x_{ij} \in $\{ 0,1 \} \$ \$: binary variable; 1 if there is a connection from process i to j, 0 otherwise
- $\ f_{ij} \in \mathbb{R}_+ \$: flow rate/throughput rate (products/sec) from process i to station j


#### Objective

Minimize total number of stations across all processes:

$$
\text{Minimize}\ Z = \sum_{i \in N} S_i
$$


#### Constraints

* **Throughput Capacity Constraint:**

Each station \( i \) must support the incoming flow from all other nodes in the network.

$$
f_i^* \leq S_i P_i,\quad \forall i \in N
$$

Where:  
$\ f_i^* = \sum_{j:\, (j,i) \in E} f_{ji} \$: total input flow to node i.

* **Flow Conservation:**
Net flow must be preserved (except for source and sink).

$$
\sum_{j: (i,j) \in E} f_{ij} - \sum_{j: (j,i) \in E} f_{ji} =
\begin{cases}
T, & \text{if } i = \text{source} \\
-T, & \text{if } i = \text{sink} \\
0, & \text{otherwise}
\end{cases}
$$

If source/sink not explicitly modeled, enforce:

$$
\sum_{j: (1,j) \in E} f_{1j} = T
$$

$$
\sum_{j: (j,4) \in E} f_{j4} = T
$$

*WIP Constraint:* To keep WIP < 10, enforce rate balance + buffer ⇒ ensure output from upstream doesn't flood downstream.

$$
\frac{f_{j}}{S_j / P_j} - \frac{f_{ij}}{S_i / P_i} \leq \frac{W}{60} \qquad \forall (i, j) \in E
$$

*Binary Activation of Arcs:* Let $M$ be the dummy variable (M very large).

$$
f_{ij} \leq M \cdot x_{ij} \qquad \forall (i, j) \in E
$$

#### Run the Problem on CPLEX
See CPLEX code [here](https://github.com/KLinh62/WCM-Test/blob/main/Part1_Supply%20Chain%20Case%20Study/CPLEX-code.mod).

#### Result:

![cplex-results](https://github.com/KLinh62/WCM-Test/blob/main/Part1_Supply%20Chain%20Case%20Study/cplex-results.png)

- The new network contains **117 stations** (working machines) across all processes, all assigned to **P4** (because S = [0, 0, 0, 117])
- No stations are assigned to P2 or P3.
- This means **P4 alone is processing all 1000 shoes/min**, and earlier stages are bypassed, as allowed by the flexible network rule.

- f = [0, 0, 16.667, 0, 0, 0] means that all flows go from **P1 to P4** (corresponding to E = <1,4>).
- 
**Conclusion:** The new network design is **P1 → P4** (bypassing P2 and P3). This makes sense because the model is allowed to bypass stages if it minimizes stations, and P4 also has the lowest processing time (7s) after P1 (5s).

---

## Case No. 2

The data shows clear **seasonality within each year** — especially higher demand in winter months (October–December) and also a steady upward trend.
![historical-sales](https://github.com/KLinh62/WCM-Test/blob/main/Part1_Supply%20Chain%20Case%20Study/historical-sales-plot.png)

### Methods Used

#### 1. Naive with Seasonality

Link to worksheet - Naive Method can be found [here](https://docs.google.com/spreadsheets/d/1gzD-cnGmx3zbf4JzzgXMqsRsAYe7YhwfwTNfH3JJKGY/edit?gid=635709674#gid=635709674).

- This method takes last year’s actual sales of the same month to be this month’s forecast.
- After obtaining the forecasts for Year 2–Year 6, we compare them against the actual sales and compute error metrics.

#### 2. Classical Decomposition
Link to worksheet - Classical Decomposition Method can be found [here](https://docs.google.com/spreadsheets/d/1gzD-cnGmx3zbf4JzzgXMqsRsAYe7YhwfwTNfH3JJKGY/edit?gid=63276931#gid=63276931).

Classical decomposition breaks time series into 3 components (using the **multiplicative model** since seasonal variations increase over time).

**Process:**
1. Use centered moving average to find the average demand for each month across all years (smooths out both seasonal and irregular variations).
2. Calculate the Seasonal + Irregular Component: Average the seasonal + irregular component for the same months across multiple years to get raw seasonal index, then normalize these raw indices.
3. Deseasonalize Data: Divide the actual demand by the seasonal index. This will be the base for the fitted linear regression.
4. Identify & Forecast Trend: Perform linear regression on the deseasonalized data, fit the linear model to the trend component, and extrapolate for the next 12 months.
5. Final forecast: Multiply the appropriate seasonal indices by the trend forecasts to get final forecasts for Year 6.

#### 3. Holt-Winter’s Exponential Smoothing

Link to worksheet Holt-Winter's Exponential Smoothing Method can be found [here](https://docs.google.com/spreadsheets/d/1gzD-cnGmx3zbf4JzzgXMqsRsAYe7YhwfwTNfH3JJKGY/edit?gid=1429736891#gid=1429736891).

This method is suitable for data that exhibits both trend and seasonality. The Holt-Winters exponential smoothing method splits the observations into 3 components: trend, season, and random error.

**Process:**
1. Initialize the level, trend, and seasonal indices for the first year: \( L_{12}, b_{12}, S_1 \) to \( S_{12} \).
2. Calculate the level, trend, and seasonal indices for each month.
3. Calculate forecasts for year 6.

### Comparing Forecasting Methods

#### Error Metrics Table

| Metric | Naive | Classical Decomposition | Holt-Winter's |
|--------|-------|------------------------|---------------|
| **Bias** | 729.17 | -608.03 | -165.12 |
| **MAD** | 1,366.67 | 2,035.60 | 1,190.48 |
| **MAPE** | 28.97% | 25.01% | 29.77% |
| **MSE** | 5,145,833.33 | 2,986,575.25 | 3,717,682.72 |

**Conclusion:**  
Classical Decomposition gives the **lowest MSE and MAPE**, thus it's the best forecasting method among the three methods.

---

# 💼 Part 2 - Sales Data Analysis

## Question 1. Summary Report of Key Insights About Sales

### Step 1: Clean and Transform Data
- Load data into Power BI.
- Clean and transform data using Power Query.
- 
[Issue Log](https://github.com/KLinh62/WCM-Test/blob/main/Part2-Sales%20Analysis/Question1s/docs/data-cleaning-transformation.png)

- For issues 5 and 6, create new `Price_Ref` and `COGS_Ref` to look up the missing price and COGS values for each SKU. (Hide the lookup tables in Power BI.)

### Step 2: Define Key Dimensions and Calculate Key Metrics
- **Key Dimensions:** channel, SKU, ship_date
- **Key Metrics:**
    - % of Revenue and % of Profit
    - Total Revenue, Average Revenue per SKU
    - Total Quantity
    - Total SKUs
    - Gross Profit = Revenue - COGS
    - Gross Profit Margin = Total Gross Profit / Total Revenue

### Step 3: Define Key Business Questions
- **Top Performing Channels:** Which channel drives the most revenue/profit? Are there underperforming channels?
- **Product Contribution (SKUs):** Which SKUs contribute most to revenue and profit? Are there SKUs with low revenue but high margin, or vice versa?
- **Growth & Trends:** Is revenue/profit growing (MoM, YoY)? Are there seasonal peaks or dips?
- **Profitability:** Which channels/SKUs have the best gross profit margins? Any negative margins?
- **Sales Mix:** What % of sales come from top 10 SKUs? Does the 80/20 rule apply?
- **Channel Priority:** Prioritize channels with high volume, high margin, or strong growth. Recommend strategies for lagging channels.

### Step 4: Preparation Step: 
Create new columns, measures, reference tables, and modify the schema.

- Create new table `Revenue_By_Sku` to calculate total revenue for each SKU.
![preparation-steps](https://github.com/KLinh62/WCM-Test/blob/main/Part2-Sales%20Analysis/Question1s/docs/schema.png)

- From `Revenue_By_Sku`, create a new table `ABC` to perform ABC Analysis.
![abc-table-creation](https://github.com/KLinh62/WCM-Test/blob/main/Part2-Sales%20Analysis/Question1s/docs/abc-table-creation.png)

- Create measures: `CP_revenue` (cumulative percent revenue), `ABC_Class`, and `Rank' for ABC Table.
![abc-add-columns](https://github.com/KLinh62/WCM-Test/blob/main/Part2-Sales%20Analysis/Question1s/docs/abc-add-columns.png)

- In `Sales_Data`, create new cleaned/calculated columns as necessary: `calc_price`, `calc_revenue`, `gross_profit`.

**Step 5: Build Power BI Reports and Extract Business Insights**

**Step 6: Write a Summary Report on Key Insights About Sales.**  
See full report [here](https://github.com/KLinh62/WCM-Test/blob/main/Part2-Sales%20Analysis/Question1s/sales-analysis-report.md).

---

##  Question 2. List Top 10 Representative SKUs

We filter out a representative list of top 10 key SKUs that satisfy the criteria:
- Belong to A-class
- Top in sales contribution
- Have positive profit margins

**Representative List of SKUs:**

| No | SKU     | Total Revenue      | Avg Gross Profit Margin | ABC Class      | Rank of Revenue |
|----|---------|--------------------|------------------------|----------------|-----------------|
| 1  | FJDJ6B  | $35,492,073.64     | 21.10%                 | A [High Value] | 1               |
| 2  | VJK56C  | $33,976,485.46     | 39.20%                 | A [High Value] | 2               |
| 3  | 6HSD4J  | $9,810,307.46      | 34.90%                 | A [High Value] | 4               |
| 4  | 7XL27C  | $8,031,200.46      | 44.30%                 | A [High Value] | 5               |
| 5  | LHR5LZ  | $7,500,259.83      | 36.40%                 | A [High Value] | 6               |
| 6  | HK1R6J  | $6,867,538.82      | 32.00%                 | A [High Value] | 9               |
| 7  | Y6HWKQ  | $6,375,908.08      | 24.80%                 | A [High Value] | 10              |
| 8  | BJ30D6  | $6,240,071.77      | 22.80%                 | A [High Value] | 11              |
| 9  | NLDP86  | $5,796,091.93      | 36.50%                 | A [High Value] | 12              |
| 10 | SHZ5Y2  | $5,742,946.16      | 32.00%                 | A [High Value] | 13              |

* Add 3 key metrics for top 10 SKUs:

![metrics-top10-1](https://github.com/KLinh62/WCM-Test/blob/main/Part2-Sales%20Analysis/Question1s/docs/metrics-top10-1.png)

![metrics-top10-2](https://github.com/KLinh62/WCM-Test/blob/main/Part2-Sales%20Analysis/Question1s/docs/metrics-top10-2.png)

## 3. Provide the Sales Forecast for the Upcoming 6 Months for the Top 10 SKUs

- The sales trend for each SKU showed high volatility but no obvious trend across the whole period (data covers only 1 year).
- **Method chosen:** 3-Month Moving Average (3MA), suitable for highly volatile series.

**Process:**
#### Step 1. Load data into pandas, reshape to long format, and add a truncated `date` column.
#### Step 2. Forecasting with 3MA:
- Set up subplots for plotting all SKUs in a 2-column × 5-row grid.
    
- Loop through SKUs: skip if <3 data points or all zeros.
    
- Initialize the "recent" list with the last 3 actual sales.
    
- Forecast next 6 months using rolling 3MA.
    
- Create future dates for the 6 forecast months.
    
- Store forecasts in results and plot historical sales and forecasts for each SKU in its subplot.
    
#### Step 4. Save results to DataFrame and export to csv files (both long and wide format).

See Python code [here](https://github.com/KLinh62/WCM-Test/blob/main/Part2-Sales%20Analysis/Question3/Forecasting.ipynb).

---

## 4. Create the Ordering Plan for Top 10 SKUs

- **Initial SOH** = 0.5 × First month’s forecast
- **Forecast period:** Next 6 months
- **Lead time:** 25 days (from order to delivery)
- **Objective:** Never go out of stock and keep ending inventory level ≈ 0.5 month’s forecast.

### Process:
#### Step 1. Initialize Parameters: Lead Time and Target SOH level.
#### Step 2. For Each SKU:
- Get the 6-month forecasted sales.
- Set initial SOH as 0.5 × first month’s forecasted sales.
#### Step 3: For Each Month in the Forecast Horizon (6 months):
* Calculate the Target Ending SOH = 0.5 × next month’s forecast, or use current month’s forecast for the last period.
 
    *Ending SOH = Beginning SOH + Order Quantity - Sales*

* Determine the Sales Forecast for each Month.

* Calculate Order Quantity:
    
  - For a 25-day lead time (~0.83 months), to cover sales in Month (t+1), we must place the order in Month t.
  
  - If the order arrives after the 6th period, use the current period’s forecast:
    
  *Order_Quantity = max(target_SOH_next + Sales - SOH_Begin, 0)*

* Record values for the list `order_plan`.

* Update SOH for the Next Month:
  
  *SOH_Begin_next = SOH_End = SOH_Begin + Order_Quantity - Sales*

#### Step 4: Store results in a DataFrame for reporting or further analysis.

See Python code [here](https://github.com/KLinh62/WCM-Test/blob/main/Part2-Sales%20Analysis/Question4/Ordering%20Plan.ipynb).

