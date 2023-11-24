use [My Practice]
go

select * from shopping_trends
1. /* Gender Wise Sales*/
select Gender,sum(Purchase_Amount_USD) as 'Gender wise sales' from shopping_trends
group by Gender

/*2. Percentage of male and female purchases in total purchases*/

SELECT 
    Gender,
    SUM(Purchase_Amount_USD) AS TotalSales,
 cast(((SUM(Purchase_Amount_USD) * 1.0 / (SELECT SUM(Purchase_Amount_USD) FROM shopping_trends)) * 100)as decimal(10,2)) as PercentageOfTotalSales
FROM shopping_trends
GROUP BY Gender

/* Sales by Category*/

select Category,sum(purchase_amount_usd) as 'CategorywiseSales',
cast(((sum(purchase_amount_usd)*1.0 / (select(sum(purchase_amount_usd)) from shopping_trends))*100) as decimal(10,2))  as 'percentage'
from shopping_trends
group by Category
 /* how to convert to two deciaml point float*/
 select cast((12.4 * 5.25) as decimal(10,2)) as value

 /* 3. Purchases by Age group*/
 
 with k
 as
 (
	 select  
			case 
			 when age >=18 and age < 30 then '18-29'
			 when age>=30 and age < 50 then '30-49'
			 when age>=50 and age < 60 then '50-60'
			else '60+'
		end as AgeGroup,
		purchase_amount_usd
	 from shopping_trends
 )
 select AgeGroup, sum(purchase_amount_usd) as [Purchases by age group], 
 cast(((sum(purchase_amount_usd)*1.0/(select(sum(purchase_amount_usd)) from k))*100)as decimal(10,2))
 as [Purchase% by Age Group]
 from k
 group by AgeGroup
 order by [Purchases by age group] desc

 /* Top 10 items purchased by customers*/
 use [My Practice]
 go
 select * from shopping_trends
 select top 5 Item_purchased,SUM(Purchase_Amount_USD) as [Total Cost of Item] from shopping_trends
 group by Item_Purchased
 order by [Total Cost of Item] desc
 
 /* Top 10 items purchased by male customers*/

 select top 10 Item_purchased,SUM(Purchase_Amount_USD) as [Total Cost of Item] from shopping_trends
 where Gender='Male'
 group by Gender, Item_Purchased
 order by [Total Cost of Item] desc

 /* Top 10 items purchased by female customers*/

 select top 10 Item_Purchased,SUM(Purchase_Amount_USD) as [Total Cost] from shopping_trends
 where Gender='Female'
 group by Item_Purchased
 order by [Total Cost] desc

 /* Total purchased amount by region*/
 use [My Practice]
 go
 select Location, SUM(Purchase_Amount_USD) as [Total Purchased Amount],
 cast((SUM(Purchase_Amount_USD)*1.0 / (select(SUM(Purchase_Amount_USD))
 from shopping_trends)*100)as decimal(10,2)) as [Purchase%]
 from shopping_trends
 group by Location
 order by 2 desc

 /* Purchase percent by payment methods*/
 select Payment_Method,SUM(Purchase_Amount_USD) as [Total Purchased Amount],
 cast((SUM(Purchase_Amount_USD)*1.0 / (select(SUM(Purchase_Amount_USD)) from shopping_trends)*100)as decimal(10,2)) as [Purchase%]
 from shopping_trends
 group by Payment_Method
 order by 2 desc

 /* Seasonal wise sales*/

 select Season, SUM(Purchase_Amount_USD) as [Total Purchased Amount in the Season ] from shopping_trends
 group by Season
 order by 2 desc

 /* Spring season top items purchased*/ 
 use [My Practice]
 go
 select * from shopping_trends
 select top 5 Item_Purchased , 
 SUM(Purchase_Amount_USD) as [Total Purchased Amount in the Season ] from shopping_trends
 where Season = 'Spring'
 group by Item_Purchased 
 order by 2 desc

 /* Winter season top items purchased*/ 
 select top 5 Item_Purchased , 
 SUM(Purchase_Amount_USD) as [Total Purchased Amount in the Season ] from shopping_trends
 where Season = 'Winter'
 group by Item_Purchased 
 order by 2 desc

 /* Fall season top items purchased*/ 

select top 5 Item_Purchased , 
 SUM(Purchase_Amount_USD) as [Total Purchased Amount in the Season ] from shopping_trends
 where Season = 'Fall'
 group by Item_Purchased 
 order by 2 desc

 /* Summer season top items purchased*/ 
 select top 5 Item_Purchased , 
 SUM(Purchase_Amount_USD) as [Total Purchased Amount in the Season ] from shopping_trends
 where Season = 'Summer'
 group by Item_Purchased 
 order by 2 desc

 /* Total purchased amount by shipping partners*/
 select Shipping_Type, SUM(Purchase_Amount_USD) as[Total amount] from shopping_trends
 group by Shipping_Type
 order by 2 desc

 /* Reviews Percentage*/
 select Review_Rating, count(*) as [Count of Review Rating],
 cast(count(Review_Rating)*1.0 / (select(count(Review_Rating)) from shopping_trends)*100 as decimal(10,2))
 as [Review%] from shopping_trends
 group by Review_Rating
 order by 2 desc

 /* Type frequency in shopping*/
 select Frequency_of_Purchases, COUNT(*) as [Count] from shopping_trends
 group by Frequency_of_Purchases
 order by 2 desc

 /* Rank to the regions by total sales*/
 select Location, sum(Purchase_Amount_USD) as [Total Amount],
 DENSE_RANK() over (order by sum(Purchase_Amount_USD) desc) as [Rank]
 from shopping_trends
 group by Location
 order by sum(Purchase_Amount_USD) desc

 /* Seasonal wise Rank to the purchased items*/
 select Season,Item_Purchased,
 SUM(Purchase_Amount_USD) as [Total Amount],
 Dense_Rank() over( partition by Season order by SUM(Purchase_Amount_USD) desc ) 
 as [Seasonal wise_Rank] from shopping_trends
 group by Season, Item_Purchased
 order by 1,3 desc


 select * from shopping_trends
