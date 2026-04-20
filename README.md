# EmTech Commercial Performance & Growth Analysis
## Background & Project Overview
#### 
EmTech is a consumer electronics and gaming retail company established in 2018, focused on delivering high-demand gaming consoles, premium accessories, and computing devices across multiple global markets.

Between 2019 and 2021, the company processed over 27,000 transactions, generating $8.6M in total revenue across multiple products, regions, and marketing channels.

This project evaluates EmTech’s commercial performance to uncover key drivers of growth, identify risks, and provide actionable business insights  that could help stakeholders in Sales, Product, Marketing, and Regional Operations.

Insights and recommendations are provided based on these key metrics and dimensions:                                                   

North Star Metrics- Revenue, Order Volume and Average Order Value(AOV)                                       
North Star Dimensions - purchase time,product name, marketing channel and region

Key areas to analyse: 

Sales Analysis: Evaluating the performance of the key Performing Indicators across products, marketing channels, and regions.

Product Performance: Analysis of EmTech product lines based on sales, regional performance and marketing channels.

Regional Insights: Evaluating regional demands and product performance within regions so as to identify growth opportunities.


## key business questions:
- How did revenue, orders, and AOV trend over time?

- Which products drive the most revenue and orders?
  
- Which marketing channels are most effective?

- Which regions contribute the most to sales?

- Where are the key risks and opportunities?


## Tools Used
- Power Query → Data cleaning & transformation

- SQL Server → Data analysis (KPI calculations, trends, segmentation)

- Excel → Dashboard creation & visualization


##  Data Workflow
1. Cleaned dataset using Power Query (handled missing values, formatted dates, created new columns)

2. Imported data into SQL Server for analysis

3. Performed KPI calculations (Revenue, Orders, AOV)
4. Analyzed trends, growth, and segment performance
5. Exported results to Excel for dashboard visualization


## Executive Summary

<img width="956" height="309" alt="Screenshot 2026-04-20 233900" src="https://github.com/user-attachments/assets/c397f7da-c5e4-4bf2-b994-e885b39f07f4" />


#### 
This project analyzed three years of EmTech sales data (2019–2021) using SQL for data querying and KPI analysis and Excel for dashboarding and visualization, with the objective of evaluating sales performance, product lines performance, marketing channel efficiency, and regional market dynamics.

The business generated approximately $8.6M in total revenue, with 2020 emerging as the strongest growth year, contributing 47% of total revenue and 49% of total orders. A significant seasonal revenue spike occurred in December 2020, which became the peak month across the analysis period, contributing 14% of total monthly revenue and highlighting strong Q4 demand concentration. Although 2021 recorded declines in revenue (-24%) and order volume (-43.4%), it delivered the highest Average Order Value (+34.5%), signaling a shift toward higher-value premium transactions.

Product analysis revealed strong SKU concentration risk, with just three hero products;Nintendo Switch, 27-inch 4K Gaming Monitor, and Sony PlayStation 5 Bundle, driving over 80% of total revenue and 90% of total order volume. Premium products such as the Sony PlayStation 5 Bundle and Lenovo IdeaPad Gaming 3 were key contributors to the elevated AOV trend in 2021, despite lower transaction counts.

From a marketing perspective, the Direct channel dominated acquisition performance, contributing 84% of total revenue and 80% of all orders, while Social Media underperformed significantly, generating only 1.2% of revenue contribution and 1.5% of order volume. This highlighted both a proven high-conversion acquisition source and a potential channel concentration risk.

Regional analysis showed that North America (NA) and EMEA accounted for 83% of both total revenue and order volume, powered by the same hero products that dominated global performance. In contrast, Latin America (LATAM) contributed only 5% to revenue and 6% to orders, which is obviously due to low product demand.

Overall, the analysis revealed a business model strongly driven by seasonal demand, a narrow hero-product portfolio, heavy reliance on direct acquisition, and concentration in two major regions. Strategic recommendations include diversifying product dependency, expanding acquisition channels beyond Direct, and selectively scaling high-performing products into underpenetrated markets such as Latin America (LATAM).


##  Dashboard


## Key Insights

###  Sales Performance

- Total revenue reached $8.6M, with monthly sales ranging from $80K to $549K

- 2020 emerged as the strongest performance year, delivering approximately $4.06M in revenue and 13,364 total orders. This represents a 163% year-over-year revenue growth and 102% growth in order volume . 47% of total revenue and 49% of total orders were generated in 2020 alone, establishing it as EmTech’s highest volume-led growth year

- December 2020 recorded the highest monthly revenue ($549.4K ) and highest monthly order of 1,671. These represent 43% month-over-month revenue growth and 31% growth in order volume. This confirms December as the strongest seasonal demand period, likely influenced by holiday purchasing behavior and promotional activity.

- Revenue declined in 2021 by 24%, while order volume dropped significantly by 43.4%. However, this decline was offset by a 34.5% significant increase in AOV, suggesting that although fewer orders were placed, customers spent substantially more per transaction.

- A sharp post-peak decline began in January 2021, immediately following the December surge. Revenue fell by 47% ($289.3K) and order volume declined by 40.5% (995 orders). The downward trend continued through March, followed by a temporary rebound in April, and renewed declines from May to June. A second recovery phase began from July through December, although October revenue dipped by 21% and orders fell by 26%. This decline suggests weak consumer demand,customer retention, missing records, pricing or product market fit issues. EmTech may need to re-strategize through marketing, promotions, or change in pricing.

###  Product Analysis

<img width="474" height="336" alt="Screenshot 2026-04-20 234106" src="https://github.com/user-attachments/assets/dbd8e83c-4b61-488e-9c45-0e78bbf8bab5" />


- The product catalog consist of 8 products
  
- The strongest revenue-generating products across the analysis period were : Nintendo Switch (~$2.8M), 27-inch 4K Gaming Monitor ( ~$2.5M),  and Sony PlayStation 5 Bundle ( ~$1.7M). Together, these three hero products contributed approximately 82% of total revenue, highlighting significant product concentration and strong customer demand around these products.

- The products driving the greatest transaction frequency were: Nintendo Switch with 13K orders, 27-inch 4K Gaming Monitor, 5.9K orders and JBL Quantum 100 Gaming Headset, 5.8K orders. These products accounted for 90% of all order volume, reinforcing a strong volume-led dependency on a limited product mix.

- The highest-value products by Average Order Value (AOV) were: Sony PlayStation 5 Bundle ( ~$1.5K), Lenovo IdeaPad Gaming 3 ( >$1K),  Acer Nitro V Gaming Laptop ( ~$747). These premium products contributed 78% of total AOV performance, making them the key drivers of high-ticket customer spend behavior. This premium mix played a major role in the elevated overall AOV recorded in 2021.

- In 2020, 27-inch 4K Gaming Monitor, Sony PlayStation 5 Bundle, Nintendo Switch collectively contributed 85% of annual revenue. Similarly, the top order-volume products, Nintendo Switch, 27-inch 4K Gaming Monitor, JBL Quantum 100 Gaming Headset generated 86% of annual orders.

This confirms that 2020’s peak business growth was heavily concentrated in a small number of top products.

- The strongest contributors to 2021’s record-high AOV were Sony PlayStation 5 Bundle, Lenovo IdeaPad Gaming 3, Acer Nitro V Gaming Laptop. These products accounted for 70% of 2021’s total AOV, despite representing only 6% of total order volume. This strongly supports the broader sales finding that 2021 shifted toward premium, value-led purchasing behavior.

- Following the December 2020 seasonal peak, all top-performing products experienced immediate declines in January 2021.
 
  - 27-inch 4K Gaming Monitor dropped by 42% in revenue, 42% in Orders and 0.28% in AOV.
  - Nintendo Switch declined by 38% in revenue and 38% in Orders .
  - Sony PlayStation 5 Bundle decreased by 51% in revenue, 50.5% in orders and 1.01% in AOV.

This confirms that the Q1 2021 downturn was primarily driven by declining demand across hero products.

##  Marketing Channel Performance

- The Direct channel emerged as the strongest marketing channel across the full 2019–2021 analysis period, contributing the largest share of both revenue(84%) and transaction volume(80%). This indicates that EmTech’s growth was overwhelmingly driven by direct customer acquisition and repeat intent-based purchasing behavior.

- Revenue within the Direct channel was highly concentrated among three hero products Nintendo Switch, 27-inch 4K Gaming Monitor, and Sony PlayStation 5 Bundle. These products generated 80% of Direct-channel revenue, confirming that both channel success and product success are tightly interconnected. 

- The highest transaction-driving products within the Direct channel were, Nintendo Switch, 27-inch 4K Gaming Monitor, JBL Quantum 100 Gaming Headset. Together, these products contributed 90% of Direct-channel order volume, indicating that the Direct channel is particularly effective at scaling high-frequency hero products.

- The weakest-performing products within the Direct channel were, Dell Gaming Mouse and Razer Pro Gaming Headset. These products accounted for only 0.2% of channel revenue and 1.1% of channel orders.

- Other channels (email, affiliate, social media) had minimal impact. The Social Media channel was the weakest acquisition source, contributing only 1.2% of total revenue and 1.5% of total order volume. 

- Indicates strong reliance on a single acquisition channel.

##  Regional Performance

- North America (NA) and EMEA emerged as the dominant regions across all core sales metrics, consistently leading in: Revenue, Order volume, AOV performance influence.

- Combined, these two regions contributed approximately 83% of total revenue and 83% of total orders. This indicates that EmTech’s commercial performance is heavily concentrated in two mature core markets, making them the primary drivers of enterprise growth.

- LATAM was the weakest-performing region, contributing only 5% of total revenue and 6% of total orders. This suggests a lower market penetration,weaker product-market fit, smaller customer base.

- Within North America, revenue was highly concentrated among Nintendo Switch, 27-inch 4K Gaming Monitor, Sony PlayStation 5 Bundle.These three hero products generated 83% of NA revenue and 74% of NA order volume. This confirms exceptionally strong product-market fit for premium gaming and console products in NA.

- A similar concentration pattern was observed in EMEA, where Nintendo Switch, 27-inch 4K Gaming Monitor, Sony PlayStation 5 Bundle contributed approximately 81% of regional revenue and 73% of regional orders. The similarity between NA and EMEA suggests consistent cross-regional product demand behavior.

- The regional concentration became even more pronounced during 2020, the strongest business year. In that year alone NA + EMEA contributed 82% of annual revenue and drove 82% of annual orders. Meanwhile, LATAM remained significantly smaller, generating 5.6% of revenue and 6% of orders. This confirms that the 2020 growth surge was also driven by established high-performing regions.

- The weakest products in both NA and EMEA were Dell Gaming Mouse and Razer Pro Gaming Headset. They generated 0.4% of total regional revenue and 3% of total regional orders in North America. In EMEA they contributed 0.4% of total regional revenue and 2% of total regional orders.

- This suggests that these products struggle even in the company’s strongest markets, reinforcing their limited strategic value and weak product-market fit.

- Sales performance is highly concentrated in a few regions

## Key Business Risks

- Heavy reliance on few top products; Nintendo Switch, 27-inch 4K Gaming Monitor, Sony PlayStation 5 Bundle (82% revenue)

- Over-dependence on Direct marketing channel (84%)

- High concentration in NA & EMEA markets (83%)

##  Recommendations

- EmTech should diversify product offerings to reduce reliance on top products. Deprioritize inventory for low performing products. Investigate Razer Pro Gaming Headset’s missing sales records.

- EmTech should continue optimizing the Direct channel while testing scalable growth opportunities in underperforming channels such as Social Media to reduce acquisition concentration risk and improve diversified revenue growth.

- EmTech should continue strengthening hero-product penetration in NA and EMEA. Diversify the portfolio in the Latin American region and  other underperforming regions, by expanding product offerings, sales channels, and market reach to reduce geographic concentration risk, increase sales revenue and order volume. 

-  Leverage high-AOV products(Sony PlayStation 5 Bundle, Lenovo IdeaPad Gaming 3, Acer Nitro V Gaming Laptop) for premium positioning.

##   Conclusion

####
This analysis highlights that while EmTech experienced strong growth in 2020, its performance is heavily dependent on a few products, channels, and regions. Addressing these concentration risks will be key to sustaining long-term growth.











         
