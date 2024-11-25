with usr as(
	select 
		id_user, 
		name,
		status
	from 
		user 
), prm as(
	select 
		id_promo,
		code,
		type,
		total_promo
	from 
		promo_code pc
), ctgr as(
	select
		id_category,
		size
	from 
		category_size
), dsg as(
	select
		id_design, 
		id_category,
		id_type,
		design_name,
		status as design_status
	from 
		design
), ord_dsg as (
	select 
		id_order,
		id_user,
		id_promo,
		id_category,
		id_designer,
		id_design_finish,
		status as order_status
	from
		order_design
), ctgr_dsg as(
	select 
		id_category_design,
		name as category_name
	from 
		category_design
), det_ord_dsg as(
	select 
		id_order
	from 
		detail_order_design
)
select 
	*
from 
	ord_dsg
left join
	usr on usr.id_user = ord_dsg.id_user
left join
	prm on prm.id_promo = ord_dsg.id_promo
left join
	ctgr on ctgr.id_category = ord_dsg.id_category
left join
	dsg on dsg.id_design = ord_dsg.id_design_finish
left join
	det_ord_dsg on det_ord_dsg.id_order = ord_dsg.id_order
left join
	ctgr_dsg on ctgr_dsg.id_category_design = dsg.id_type
limit 500;
