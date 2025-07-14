# Data Dictionary

## Overview

After cleaning & transformation, the Sales_Data table can be used for analytical and reporting purpose. It consists of 10 columns for specific business metrics.

| Sales_Data           | Column Origin | Data Type     | Description                                                                                         |
|----------------------|--------------|---------------|-----------------------------------------------------------------------------------------------------|
| `shipped_date`         | Original     | Date          | The date when the sku was shipped to the customer.                                                  |
| `sku`                  | Original     | Text          | Product's identity code (stock keeping unit)                                                        |
| `channel`              | Original     | Text          | The channel that distributed a particular sku                                                       |
| `qty`                  | Original     | Whole Number  | The number of units of the sku shipped from a particular channel in a day                           |
| `calc_revenue`         | Calculated   | Decimal       | The total monetary value of the sales for sku for the day, in decimal currency units                |
| `calc_COGS`            | Calculated   | Decimal       | The cost or base price of the product, measured in decimal currency units                           |
| `MOQ_order`            | Original     | Whole Number  | Mean order quantity for an sku                                                                      |
| `calc_price`           | Calculated   | Decimal       | The price per sku of the product for the day, in decimal currency units                             |
| `gross_profit`         | Calculated   | Decimal       | Gross profit (=calc_revenue - calc_COGS) for the sku in a day                                       |
| `gross_profit_margin`  | Calculated   | Percentage    | Gross profit margin (=gross_profit/calc_revenue) for the sku in a day                               |
