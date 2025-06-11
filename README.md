# Pizza Shop Sales Analysis Dashboard


## Project Background
**Company:** Pizza Shop Inc.  
**Industry:** Quick-Service Restaurant (QSR) / Food & Beverage  
**Active Years:** 2024 – Present  
**Business Model:**  
Pizza Shop Inc. is a regional pizza chain that operates both dine-in and delivery services. The company sources ingredients locally, operates a fleet of delivery drivers, and uses a centralized kitchen to fulfill online and in-store orders. Revenue streams include single-pizza orders, combo meals, catering packages, and subscription bundles (e.g., weekly meal plans).  

**Key Business Metrics (Annual Averages):**  
- **Total Annual Revenue:** ₹ 8,17,860  
- **Total Orders:** ~21,350  
- **Average Order Value (AOV):** ₹ 38 
- **Average Pizzas per Order:** ₹ 2.32

**Point of View (Data Analyst at Pizza Shop Inc.):**  
As a Data Analyst embedded within the Pizza Shop analytics team, my primary responsibility is to ingest, clean, and analyze transactional data from multiple source tables, then build an interactive Power BI dashboard that enables stakeholders (e.g., Marketing Manager, Operations Director, Finance Director) to explore sales trends, monitor product performance, and identify opportunities for revenue growth or cost optimization. This README describes the end-to-end process, high-level findings, and actionable recommendations based on a full calendar year of pizza sales (January–December).


## Insights and Recommendations
Below are the four key thematic areas (categories) we explore, each concluding with targeted recommendations:

- **Category 1: Overall Sales Trends & Seasonality**  
- **Category 2: Pizza Category Performance (Classic, Supreme, Chicken, Veggie)**  
- **Category 3: Pizza Size Performance (Small, Medium, Large, X-Large, XX-Large)**  
- **Category 4: Product-Level Rankings (Top 5 & Bottom 5 Pizzas by Revenue, Quantity, Orders, AOV)**  

The SQL queries used to inspect and clean the data for this analysis can be found [here](#)   

Targeted SQL queries regarding various business questions can be found [here](https://github.com/Rohan-Morajkar/Pizza-shop-sales-analysis/blob/main/Buisness_Questions_Answered.sql)  

An interactive Power BI dashboard used to report and explore sales trends can be found [here](https://github.com/Rohan-Morajkar/Pizza-shop-sales-analysis/blob/main/Pizza%20Sales%20Dashboard.pbix)


##  Data Cleaning Summary (on 50,000 rows)

To prepare the dataset for analysis, several data cleaning steps were applied:

- **Trimmed whitespace** from `pizza_name` entries (affected ~9,928 rows).
- **Standardized category labels** in `pizza_category` by correcting inconsistent lowercase formatting (~9,694 rows).
- **Handled missing values**:
  - `pizza_size`: ~2,384 rows — imputed with the most frequent value or dropped.
  - `unit_price`: ~2,458 rows — imputed using mean/median.
  - `order_time`: ~2,500 rows — imputed with mode or removed.
- **Corrected typos** such as `'cheez'` to `'cheese'` in product names.
- **Converted `quantity`** from string to integer type (affecting 48,625 rows).
- **Removed 5 exact duplicate rows** from the dataset.

>  Final dataset is clean, consistent, and ready for analysis.




## Executive Summary
### Overview of Findings
If the CEO of Pizza Shop Inc. were to take away three key insights from this analysis, they would be:
1. **Large pizzas and Classic category pizzas drive nearly 60% of total revenue.**  
2. **July is by far the strongest month in terms of order volume (1,935 orders), while Octumber is the slowest (1,685 orders).**  
3. **While The Thai Chicken Pizza and Barbecue Chicken Pizza top the revenue charts, a handful of specialty pizzas (e.g., Spinach pesto Supreme) underperform significantly and could be reconsidered in the product mix.**  

The interactive Power BI dashboard (see screenshot below) aggregates all these metrics on a single canvas, allowing stakeholders to drill into daily, monthly, category, size, and product-level performance in real time.

![Screenshot 2025-06-11 140001](https://github.com/user-attachments/assets/59e989ac-f189-4c5e-920c-e32c8f6f2a3a)



## Insights Deep Dive

### Category 1: Overall Sales Trends & Seasonality
1. **Monthly Revenue & Order Volume Trends**  
   - **Observation:** July 2024 achieved the highest total orders (1,935) and accounted for ~9.6% of full-year revenue. Conversely, Octumber 2024 had the lowest orders (1,646; 7.7% of total revenue).  
   - **Details:**  
     - January: 1,845 orders → ₹ 69,800  
     - February: 1,685 orders → ₹ 65,200  
     - March–May: Gradual climb from 1,840 (₹ 70.4K) to 1,853 (₹ 71.4K) → Peak in July to 1,935 (₹72.1K).  
     - Octumber: Orders fell to 1,646 (₹ 64,028).  
   - **Trend:** Strong summer demand (May–August), likely due to mid-year promotions and cricket season tie-ins.  

2. **Weekly & Daily Order Distribution**  
   - **Observation:** Weekdays (Sunday-Thursday) consistently see 3,000+ orders/day, whereas Friday dip slightly (~2,600).  
   - **Details:**  
     - Sunday: 3,000 orders  
     - Monday: 3,100 orders  
     - Tuesday: 3,300 orders  
     - Wednesday: 3,500 orders (peak mid-week)  
     - Thursday: 3,100 orders  
     - Friday: 2,600 orders (dip-weekend)  
     - Saturday: 2,800 orders  
   - **Trend:** Wednesday mid-week surge likely driven by “Wednesday Special” discount campaigns.  

3. **Key Performance Indicators (KPIs)**  
   - **Total Revenue (2024):** ₹ 817,860  
   - **Total Orders (2024):** 21,350  
   - **Total Pizzas Sold:** 49,574  
   - **Average Order Value (AOV):** ₹ 38.31  
   - **Average Pizzas per Order:** 2.32  

4. **Recommendations (Category 1):**  
   1. **Expand Summer Promotions:** Since July shows peak demand, plan a “Summer Mega Combo” campaign from May through July to capitalize on seasonality.  
   2. **Mid-Week Loyalty Programs:** Wednesday has the highest order volume—leverage “Wednesday Special” loyalty vouchers to further boost repeat visits.  
   3. **Friday Slow-Day Discounts:** Consider a “Make-It-Friday” 10% discount to flatten weekend dips between Friday–Saturday.

> **Visualization (Category 1):**
> 
>![Screenshot 2025-06-11 140329](https://github.com/user-attachments/assets/235e3ba8-9b10-4af4-b3e4-d1998f1a7299)
> 
> *Figure 1: Monthly Orders & Revenue Trend (Area Chart) + Daily Trends (Bar Chart)*



### Category 2: Pizza Category Performance (Classic, Supreme, Chicken, Veggie)
1. **Revenue Share by Category**  
   - **Classic:** ₹ 220K (26.9% of total)  
   - **Supreme:** ₹ 208K (25.5% of total)  
   - **Chicken:** ₹ 194K (23.7% of total)  
   - **Veggie:** ₹ 196K (24.0% of total)  
   - **Observation:** All four categories generate relatively balanced revenue, but Classic leads by ~2.5%.  

2. **Volume (Quantity) Share by Category**  
   - **Classic:** 14,888 pizzas (30.3% of all units sold)  
   - **Supreme:** 11,987 pizzas (24.18%)  
   - **Chicken:** 11,050 pizzas (22.29%)  
   - **Veggie:** 11,649 pizzas (23.5%)  
   - **Observation:** Classic category not only drives revenue but also highest volume.  

3. **Price Elasticity & Average Order Value (by Category)**  
   - **Chicken Pizzas:** AOV of ₹ 22.95 (higher than other category AOV ⇒ indicates upselling to larger sizes or add-ons).  
   - **Classic Pizzas:** AOV of ₹ 20.26 (lowest among categories), possibly due to lower base unit price or more frequent small-size orders.  

4. **Recommendations (Category 2):**  
   1. **Promote Chicken Category Bundles:** Since Chicken accounts for highest AOV, introduce a “Family Feast” bundle featuring two Chicken large pizzas + 2 sides at a 15% discount.  
   2. **Upsell Classic Pizzas:** Classic pizzas have the lowest AOV of 22.95. Train staff to upsell add-ons (e.g., extra cheese, premium toppings) or offer “Classic Supreme Upgrade” to increase AOV.  
   3. **Rebalance Ingredient Inventory:** Because Classic is high-volume, ensure raw crust and cheese inventory is consistently stocked—forecast weekly usage based on monthly trend.  
   4. **Category-Specific Limited-Time Offers:** Rotate a “Chicken Carnival Week” in Q4 to spark demand in lagging months (September–December).

> **Visualization (Category 2):**
> 
> ![Category Breakdown  (Donut Char) ![Screenshot 2025-06-11 140713](https://github.com/user-attachments/assets/861163c9-b3e1-46ee-8d0f-28aef3e4c619)
> 
> *Figure 2: Revenue & Volume Share by Pizza Category*


### Category 3: Pizza Size Performance (Small, Medium, Large, X-Large, XX-Large)
1. **Revenue Share by Size**  
   - **Large:** ₹ 375K (45.9% of total revenue)  
   - **Medium:** ₹ 249K (30.5%)  
   - **Small:** ₹ 178K (21.77%)  
   - **X-Large + XX-Large:** Combined ~₹ (14,076 +1006) = ~₹ (15,082K) (~2%-sizable share; negligible).  
   - **Observation:** Large pizzas are the clear revenue driver; Medium come second.  

2. **Quantity (Units Sold) by Size**  
   - **Large:** 18,956 units (38.24% of all pizzas sold)  
   - **Medium:** 15,635 units (31.54%)  
   - **Small:** 14,403 units (29.5%)  
   - **X-Large:** 552 units (1.11%)  
   - **XX-Large:** 28 units (0.6%)  

3. **Average Order Value by Size**  
   - **Large:** ₹ 29.47 per pizza (higher contribution per unit)  
   - **Medium:** ₹ 22.35 per pizza  
   - **Small:** ₹ 16.98 per pizza  
   - **Observation:** Upselling from Small → Large yields an incremental ₹ ~ 13 per pizza; promotions should highlight this value.  

4. **Recommendations (Category 3):**  
   1. **“Size-Up” Campaigns:** Promote “Buy a Small, Get a Large for ₹ 20 extra” to increase average ticket size.  
   2. **Review X-Large & XX-Large Pricing:** Low sales volumes for X/XX-Large (combined < 10% of revenue) indicate possible price barrier. Consider limited-time discounted “Family XL Meal” to clear stock.  
   3. **Size-Based Bundles:** Create “Triple-Size Special” bundles—one small, one medium, one large—for ₹ 99, boosting sales among budget-conscious customers.  
   4. **Inventory Forecasting:** Since Large accounts for nearly half of all revenue, allocate ~50% of dough production capacity for Large crusts to avoid stockouts on peak days.

> **Visualization (Category 3):**
>
>![Screenshot 2025-06-11 140902](https://github.com/user-attachments/assets/a6e2d668-a36e-4ea8-9a2b-68a16d1efd0c)
> 
> *Figure 3: Revenue & Quantity Share by Pizza Size*


### Category 4: Product-Level Rankings (Top 5 & Bottom 5 Pizzas)
#### 4.1 Top 5 Pizzas by Revenue
1. **The Thai Chicken Pizza:** ₹ 43,000  
2. **Barbecue Chicken Pizza:** ₹ 43,000  
3. **California Chicken Pizza:** ₹ 41,000  
4. **Classic Deluxe Pizza:** ₹ 38,000  
5. **Spicy Italian Pizza:** ₹ 35,000  

- **Insight:** Three of the top five are Chicken-based pizzas. The Classic Deluxe (signature brand pizza) still underperforms relative to newer flavor profiles.

#### 4.2 Top 5 Pizzas by Quantity Sold
1. **Classic Deluxe Pizza:** 2,500 units  
2. **Barbecue Chicken Pizza:** 2,400 units  
3. **Hawaiian Pizza:** 2,400 units  
4. **Pepperoni Pizza:** 2,400 units  
5. **Thai Chicken Pizza:** 2,400 units  

- **Insight:** Classic Deluxe leads in volume, but Pepperoni and Hawaiian compete closely, suggesting broad appeal.

#### 4.3 Top 5 Pizzas by Total Orders
1. **Classic Deluxe Pizza:** 2,300 orders  
2. **Hawaiian Pizza:** 2,300 orders  
3. **Pepperoni Pizza:** 2,300 orders  
4. **Barbecue Chicken Pizza:** 2,300 orders  
5. **Thai Chicken Pizza:** 2,200 orders  

- **Insight:** Order frequency aligns closely with quantity sold, indicating each of these five pizzas typically sells one unit per order on average.

#### 4.4 Top 5 Pizzas by Average Order Value (AOV)
1. **Brie Carre Pizza:** ₹ 24.14  
2. **Greek Pizza:** ₹ 20.91  
3. **Thai Chicken Pizza:** ₹ 19.52  
4. **Five Cheese Pizza:** ₹ 19.18  
5. **Spicy Italian Pizza:** ₹ 19.12  

- **Insight:** Brie Carre and Greek pizzas yield higher margins per order. Marketing can bundle these “premium” pizzas in targeted upsell campaigns.

> **Visualization (Category 4 – Best Sellers):**
> 
>![Screenshot 2025-06-11 141355](https://github.com/user-attachments/assets/e39f8568-0244-453b-853b-d5e22d38bf78)
> 
> *Figure 4: Top 5 Pizzas by Revenue, Quantity, Orders, AOV*

---


#### 4.5 Bottom 5 Pizzas by Revenue
1. **Spinach Pesto Pizza:** ₹ 16,000  
2. **Mediterranean Pizza:** ₹ 15,000  
3. **Spinach Supreme Pizza:** ₹ 15,000  
4. **Green Garden Pizza:** ₹ 14,000  
5. **Brie Carre Pizza:** ₹ 12,000  

- **Insight:** Specialty vegetarian pizzas (Spinach Pesto, Mediterranean) underperform. Brie Carre, despite high AOV, is low volume.

#### 4.6 Bottom 5 Pizzas by Quantity Sold
1. **Soppressata Pizza:** 961 units  
2. **Spinach Supreme Pizza:** 950 units  
3. **Calabrese Pizza:** 937 units  
4. **Mediterranean Pizza:** 934 units  
5. **Brie Carre Pizza:** 490 units  

- **Insight:** Soppressata and Spinach Supreme are niche items with limited appeal. Look into recipe costs vs. revenue to determine discontinuation.

#### 4.7 Bottom 5 Pizzas by Total Orders
1. **Chicken Pesto Pizza:** 938 orders  
2. **Calabrese Pizza:** 918 orders  
3. **Spinach Supreme Pizza:** 918 orders  
4. **Mediterranean Pizza:** 912 orders  
5. **Brie Carre Pizza:** 480 orders  

- **Insight:** Brie Carre’s premium price point discounts its appeal—could be relaunched as a limited-time seasonal special rather than a year-round item.

#### 4.8 Bottom 5 Pizzas by AOV
1. **Pepperoni, Mushroom & Peppers Pizza:** ₹ 14.31  
2. **Green Garden Pizza:** ₹ 14.30  
3. **Hawaiian Pizza:** ₹ 14.15  
4. **Pepperoni Pizza:** ₹ 13.24  
5. **Big Meat Pizza:** ₹ 12.68  

- **Insight:** Certain classic flavors (Pepperoni, Hawaiian) have low AOV—likely because customers purchase them as small or medium only. Consider upselling them to large size.

> **Visualization (Category 4 – Least Sellers):**
> 
>![Screenshot 2025-06-11 142252](https://github.com/user-attachments/assets/d58e9212-f959-4328-b0b8-fecd76db2f34)
> 
> *Figure 5: Bottom 5 Pizzas by Revenue, Quantity, Orders, AOV*


## Recommendations
Based on all the insights above, we recommend the following actions to the **Marketing & Operations Teams**:

1. **Optimize Product Catalog:**  
   - **Discontinue or Reposition**: Move low-volume, low-revenue pizzas (Spinach Pesto, Mediterranean, Calabrese) to a “Seasonal/Rotational” menu rather than perpetual lineup.  
   - **Promote High-Margin Items**: Highlight Brie Carre, Greek, and Thai Chicken in email newsletters and in-app promotions to boost AOV.

2. **Seasonal & Size-Up Promotions:**  
   - **“Summer Fiesta Bundle” (July–August)**: Combine two Large Classic pizzas + 2 sides + 4 drinks for ₹ 499 to leverage peak summer demand.  
   - **Mid-Week “Size-Up” Voucher**: Offer a ₹ 20 voucher that upgrades any Small pizza → Large when customers order on Wednesday or Thursday.

3. **Inventory & Supply Chain Alignment:**  
   - **Focus Dough Production**: Allocate production capacity for Large crusts to cover ~45% of overall demand—reforecast weekly based on rolling 4-week average.  
   - **Ingredient Forecasting**: Use the category performance trends to forecast cheese and topping shipments 2 weeks ahead—Classic cheese demand spikes mid-week, Chicken toppings in Q3.

4. **Customer Segmentation & Loyalty:**  
   - **Target Veggie-Loyal Segment**: Since Veggie category AOV is low, send personalized “Add Extra Cheese” or “Deluxe Veggie” coupons to customers who purchased > 3 Veggie pizzas in past 3 months.  
   - **Reactivation Campaign**: Identify customers who have not ordered since Q2 2024—send them “We Miss You!” vouchers for ₹ 15 off a ₹ 150 order to re-engage.

5. **Menu Engineering & Pricing:**  
   - **Re-price X-Large & XX-Large**: Introduce a limited-time “XL Family Pack” discount (10% off) to test price elasticity; monitor if X/XX volumes increase above 10% share.  
   - **Bundle Upsells**: Bundling a side (e.g., Garlic Bread) with classic pizzas at a nominal extra ₹ 30 improves margin and average order value.
