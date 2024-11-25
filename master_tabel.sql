with master_order_design as(
	select 
		id_order,
		id_designer,
		size_area,
		rating,
		status,
		price,
		total_promo,
		province,
		city,
		created_at,
		updated_at
	from order_design
), master_user as( 
	select
		id_user,
		name,
		phone,
		email,
		status
	from 
		user
), master_design as (
	select 
		id_design,
		id_user,
		design_name,
		area,
		status,
		created_at,
		updated_at,
		deleted_at
	from 
		design
), master_desc_design as (
	select 
		id_desc,
		id_design,
		volume,
		category,
		denom,
		item_name,
		item_unit_qty,
		item_unit_cost,
		item_unit_price,
		item_denom_cost,
		item_denom_price,
		item_total_cost,
		item_total_price
	from 
		desc_design
)
select *
from master_order_design
left join master_user 
  on master_user.id_user = master_order_design.id_designer
left join master_design 
  on master_design.id_user = master_user.id_user
left join master_desc_design 
  on master_desc_design.id_design = master_design.id_design
union all
select *
from master_order_design
right join master_user 
  on master_user.id_user = master_order_design.id_designer
right join master_design 
  on master_design.id_user = master_user.id_user
right join master_desc_design 
  on master_desc_design.id_design = master_design.id_design;



