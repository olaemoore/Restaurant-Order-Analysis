-- ----------------------------
-- Explore the order_details table
-- ----------------------------

select * from order_details;

-- what is the date range?

select 
	min(order_date),
    max(order_date)
from 
	order_details;
    
-- How many items were ordered within this date range?

select
	count(distinct order_id) as Num_Orders
from order_details;

-- How many orders were made within this date range?

select
	count(*) as Num_Items
from order_details;


-- which orders had the most number of items?

select
	order_id,
    count(item_id) as Num_Items
from
	order_details
group by
	order_id
order by 
	Num_Items desc;

-- How many orders had more than 12 items?

select count(*) from 
(select
	order_id,
    count(item_id) as Num_Items
from
	order_details
group by
	order_id
having Num_items > 12) as num_orders;
-- ----------------------------
-- Explore the menu items table
-- ----------------------------
use restaurant_db;

select * from menu_items;

-- Query the number of items on the menu
select
	count(distinct menu_item_id) as NumberOfItems
from menu_items;

-- What are the least and most expensive items on the menu?

select
	item_name,
    max(price) as MostExpensiveItem
   from 
	menu_items
group by item_name
order by MostExpensiveItem desc;

select
	item_name,
    Min(price) as LeastExpensiveItem
   from 
	menu_items
group by item_name
order by LeastExpensiveItem;

select * from menu_items;

-- How many italian dishes are on the menu?
select
	count(distinct menu_item_id) as NumberOfItalianItems
from menu_items
	where category = 'Italian';
    
-- What the least and most expensive items on the menu?

select
	item_name,
Min(price) as LeastExpensiveItem
from menu_items
where category = 'Italian'
group by 
	item_name
order by 
	LeastExpensiveItem
 limit 1;
 
 select
	item_name,
max(price) as MostExpensiveItem
from menu_items
where category = 'Italian'
group by 
	item_name
order by 
	MostExpensiveItem desc
 limit 1;

-- How many dishes are in each category?

select
	category,
	count(item_name) as NumberOfItems
from 
	menu_items
group by 
	category;
    
-- What is the average dish price within each category?

select
	category,
    round(avg(price),2) as AveragePrice
from 
	menu_items	
group by 
	category;
    
-- ----------------------------
-- Analysis
-- ----------------------------

select * from menu_items;

-- 1. Combine the menu_items and order_detail table into a single table

select * from 
order_details as o
left join menu_items as m
	on o.item_id =  m.menu_item_id;
    
-- 2. What are the least and most ordered items?

select m.item_name,
	category,
    count(o.order_details_id) as Num_orders
from 
	order_details as o
left join menu_items as m
	on o.item_id =  m.menu_item_id
group by 
	m.item_name, category
order by
	Num_orders desc;
    
-- 3. What were the top 5 orders that spent the most money?

select
	order_id,
	sum(m.price) as total_Spent
from 
	order_details as o
left join menu_items as m
	on o.item_id =  m.menu_item_id
group by 
	order_id
order by 
	total_spent desc
limit 5;

-- 4. View the details of the highest spend order. which specific items were purchased?  What insights can you gather?
-- we see mutliple categories in the order, let's provide a breakdown...
select
	category,
    count(o.item_id) as Num_items
from 
	order_details as o
left join menu_items as m
	on o.item_id =  m.menu_item_id
where o.order_id = 440
group by category;

select * from order_details;

-- bonus

select
	order_id,
    category,
    count(o.item_id) as Num_items
from 
	order_details as o
left join menu_items as m
	on o.item_id =  m.menu_item_id
where o.order_id in (440, 2075, 1957, 330, 2675)
group by category, order_id;

