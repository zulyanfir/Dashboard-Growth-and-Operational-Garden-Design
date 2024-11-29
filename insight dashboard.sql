# insight Top Requested Designer 
SELECT 
	u.name AS user_name,
	count(id_order) AS number_of_request
FROM
	order_design od 
JOIN 
	user u ON u.id_user = od.id_designer 
GROUP BY user_name
ORDER BY number_of_request DESC
LIMIT 10;


# Lokasi customer yang memesan design
SELECT 
	ac.administrative_area_level_1,
	ac.administrative_area_level_2,
	ac.administrative_area_level_3,
	count(id_order) AS total_orders
FROM
	order_design od 
LEFT JOIN
    address_components ac ON ac.address_componentable_id = od.id_order
WHERE 
	ac.address_componentable_type like '%OrderDesign%'
GROUP by
	ac.administrative_area_level_1
ORDER BY total_orders DESC limit 10; 

# Jumlah pesanan berdasarkan size
SELECT 
	CASE
		WHEN cs.id_category = 1 THEN '< 10m^2'
		WHEN cs.id_category = 2 THEN '11 - 20m^2'
		WHEN cs.id_category = 3 THEN '21 - 30m^2'
		WHEN cs.id_category = 4 THEN '31 - 40m^2'			
		when cs.id_category = 5 then '41 - 50m^2'
	ELSE '> 50m^2'
	END AS category_size,
	COUNT(od.id_order) AS number_of_ordered_size
FROM 
	order_design od
LEFT JOIN
	category_size cs on cs.id_category = od.id_category
GROUP BY category_size
LIMIT 10;

# Total order design bulan ini   
SELECT 
    COUNT(CASE 
	      	WHEN MONTH(created_at) = MONTH(CURRENT_DATE) THEN id_order 
	      END) AS number_of_order_this_month,
    DATE_FORMAT(CURRENT_DATE, '%M') AS current_month_name
FROM 
    order_design od
WHERE 
	od.status = 'finish'
GROUP BY 
    current_month_name;
   
# Total order design last month 
SELECT 
    COUNT(CASE 
	    	WHEN MONTH(created_at) = MONTH(DATE_SUB(CURRENT_DATE(), INTERVAL 1 MONTH)) THEN id_order 
	      END) AS number_of_order_last_month,
    DATE_FORMAT(DATE_SUB(CURRENT_DATE(), INTERVAL 1 MONTH), '%M') AS last_month_name
FROM 
    order_design od;

# Total order design on going (belum dibuat)

# Revenue (belum dibuat)
   
   
