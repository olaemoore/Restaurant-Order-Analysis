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
